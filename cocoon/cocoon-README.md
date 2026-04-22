# Running the Original ADS Edition in Apache Tomcat

This folder contains the original dynamic web application for the ADS edition
(*Achter de Schermen* / *Opdracht* by Willem Elsschot), implemented in
**Apache Cocoon 2.1.11**. It is archived here as a complete record of the
application that the static edition was derived from.

## Requirements

- **Java**: Java 8 or later
- **Apache Tomcat**: version 8 or 9 (both tested)
  - Tomcat 10 is not supported (Cocoon 2.1.11 is not compatible with the
    Jakarta EE namespace changes introduced in Tomcat 10)
- **Operating system**: macOS, Linux, or Windows

## Installation

1. Download and install Apache Tomcat 8 or 9 from
   [https://tomcat.apache.org](https://tomcat.apache.org) if you do not
   already have it.

2. Copy the `ads/` folder from this directory into Tomcat's `webapps/`
   directory:

   ```
   cp -r ads/ /path/to/tomcat/webapps/
   ```

   On macOS with a default Tomcat installation this is typically:
   ```
   /usr/local/opt/tomcat/libexec/webapps/
   ```

   On Linux:
   ```
   /var/lib/tomcat8/webapps/
   ```

3. Start Tomcat:

   ```
   /path/to/tomcat/bin/startup.sh
   ```

   On Windows:
   ```
   \path\to\tomcat\bin\startup.bat
   ```

4. Open a browser and navigate to:

   ```
   http://localhost:8080/ads/Ads.htm
   ```

   If Tomcat is configured to run on a different port (e.g. 8282), adjust
   the URL accordingly.

## Stopping Tomcat

```
/path/to/tomcat/bin/shutdown.sh
```

## Notes

- The application requires no database or external services. All data is
  contained within the `ads/` folder as TEI P4 XML files transformed at
  request time via XSLT.
- The edition was developed and tested with Tomcat running on macOS. It
  should work on Linux and Windows without modification.
- Cocoon 2.1.11 is no longer actively maintained. The application is
  archived here for reference and reproducibility, not for production use.
- If the application fails to start, check Tomcat's `logs/catalina.out`
  for error messages.

## Relationship to the Static Edition

The static edition in `output/` was generated from the same XML source files
contained in this application, using the build scripts in `build/`. The
`source/` folder contains the modified XSLT stylesheets and XML files used
for the static build; the stylesheets in this Cocoon application reflect the
original dynamic version.
