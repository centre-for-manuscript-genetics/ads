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

## Contents

This folder contains three web applications, all of which must be deployed
together for the full edition to function:

| Folder | Contents |
|--------|----------|
| `ads/` | The main Cocoon 2.1.11 application |
| `exist/` | A minimal eXist XML database instance (as a Cocoon block), providing the full-text search engine |
| `exit/` | A small JSP application that shuts down Tomcat and removes the tray icon from the user's OS — part of the original CD-ROM user experience |

## Port configuration

The links to the search engine have the localhost port number hardcoded.
**Tomcat must be configured to run on port 9999.** Edit `conf/server.xml`
in your Tomcat installation and set the HTTP connector port to 9999:

```xml
<Connector port="9999" protocol="HTTP/1.1" ... />
```

## Installation

1. Download and install Apache Tomcat 8 or 9 from
   [https://tomcat.apache.org](https://tomcat.apache.org) if you do not
   already have it.

2. Configure Tomcat to run on port 9999 as described above.

3. Copy all three folders from this directory into Tomcat's `webapps/`
   directory:
   ```
   cp -r ads/ exist/ exit/ /path/to/tomcat/webapps/
   ```
   On macOS with a default Tomcat installation this is typically:
   ```
   /usr/local/opt/tomcat/libexec/webapps/
   ```
   On Linux:
   ```
   /var/lib/tomcat8/webapps/
   ```

4. Start Tomcat:
   ```
   /path/to/tomcat/bin/startup.sh
   ```
   On Windows:
   ```
   \path\to\tomcat\bin\startup.bat
   ```

5. Open a browser and navigate to:
   ```
   http://localhost:9999/ads/Ads.htm
   ```

## Stopping Tomcat

```
/path/to/tomcat/bin/shutdown.sh
```

## Notes

- The full-text search engine requires the `exist/` folder to be deployed
  alongside `ads/`. Without it, the rest of the edition functions normally
  but search is unavailable.
- The application requires no external services beyond Tomcat. All edition
  data is contained within the `ads/` folder as TEI P4 XML files transformed
  at request time via XSLT.
- The edition was developed and tested with Tomcat running on macOS. It
  should work on Linux and Windows without modification.
- Cocoon 2.1.11 is no longer actively maintained. The application is
  archived here for reference and reproducibility, not for production use.
- If the application fails to start, check Tomcat's `logs/catalina.out`
  for error messages.

## Relationship to the static edition

The static edition was generated from the same XML source files contained
in this application, using the build scripts in `build/`. The `source/`
folder contains the modified XSLT stylesheets and XML files used for the
static build; the stylesheets in this Cocoon application reflect the
original dynamic version.
