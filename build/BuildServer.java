import net.sf.saxon.s9api.*;
import javax.xml.transform.stream.StreamSource;
import java.io.*;
import java.nio.file.*;
import java.util.*;

/**
 * BuildServer: persistent Saxon XSLT transform server.
 *
 * Reads job lines from stdin, transforms, writes output, prints "done" or "error: ..."
 * to stdout after each job. Stays alive for the full build — one JVM startup per worker.
 *
 * Job line format (tab-separated key=value pairs):
 *   input=xml/ads.xml  stylesheet=stylesheets/ads.xsl  output=output/AdsM1.html  param:document=AdsM1  param:text=doclin ...
 *
 * Compile:
 *   javac -cp build/saxon/saxon-he.jar BuildServer.java
 *
 * Run (managed by build_server.py — do not invoke directly):
 *   java -cp build/saxon/saxon-he.jar:. -Xmx256m BuildServer
 */
public class BuildServer {

    // Cache compiled stylesheets keyed by absolute stylesheet path.
    // Each XsltExecutable is thread-safe and reusable across jobs.
    private static final Map<String, XsltExecutable> styleCache = new HashMap<>();
    private static final Processor processor = new Processor(false);
    private static final XsltCompiler compiler = processor.newXsltCompiler();

    public static void main(String[] args) throws Exception {
        BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
        // Flush stdout after every println so the Python side sees responses immediately.
        PrintStream out = new PrintStream(System.out, true, "UTF-8");

        String line;
        while ((line = in.readLine()) != null) {
            line = line.trim();
            if (line.isEmpty()) continue;

            try {
                processJob(line, out);
                out.println("done");
            } catch (Exception e) {
                // Print single-line error so Python side can parse it cleanly.
                String msg = e.getMessage() == null ? e.getClass().getName() : e.getMessage();
                out.println("error: " + msg.replace('\n', ' ').replace('\r', ' '));
            }
        }
    }

    private static void processJob(String line, PrintStream out) throws Exception {
        // Parse tab-separated key=value pairs.
        String inputPath = null;
        String stylesheetPath = null;
        String outputPath = null;
        Map<String, String> params = new LinkedHashMap<>();

        for (String token : line.split("\t")) {
            token = token.trim();
            if (token.isEmpty()) continue;
            int eq = token.indexOf('=');
            if (eq < 0) continue;
            String key = token.substring(0, eq);
            String value = token.substring(eq + 1);
            switch (key) {
                case "input":      inputPath = value;      break;
                case "stylesheet": stylesheetPath = value; break;
                case "output":     outputPath = value;     break;
                default:
                    if (key.startsWith("param:")) {
                        params.put(key.substring(6), value);
                    }
            }
        }

        if (inputPath == null || stylesheetPath == null || outputPath == null) {
            throw new IllegalArgumentException("Missing input, stylesheet, or output in job: " + line);
        }

        // Resolve to absolute paths so Saxon handles them correctly regardless of cwd.
        Path inputAbs      = Paths.get(inputPath).toAbsolutePath();
        Path stylesheetAbs = Paths.get(stylesheetPath).toAbsolutePath();
        Path outputAbs     = Paths.get(outputPath).toAbsolutePath();

        // Ensure output directory exists.
        Files.createDirectories(outputAbs.getParent());

        // Compile stylesheet if not already cached.
        String cacheKey = stylesheetAbs.toString();
        XsltExecutable executable = styleCache.get(cacheKey);
        if (executable == null) {
            executable = compiler.compile(new StreamSource(stylesheetAbs.toFile()));
            styleCache.put(cacheKey, executable);
        }

        // Build and run the transformation.
        XsltTransformer transformer = executable.load();

        // Set parameters.
        for (Map.Entry<String, String> entry : params.entrySet()) {
            transformer.setParameter(
                new QName(entry.getKey()),
                new XdmAtomicValue(entry.getValue())
            );
        }

        // Set source document.
        transformer.setInitialContextNode(
            processor.newDocumentBuilder().build(new StreamSource(inputAbs.toFile()))
        );

        // Set output destination.
        Serializer serializer = processor.newSerializer(outputAbs.toFile());
        transformer.setDestination(serializer);

        transformer.transform();
    }
}
