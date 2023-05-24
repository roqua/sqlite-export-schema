This repository contains an export from SchemaSpy that lets people browse the database structure of our SQLite exports.

The [SQLite Export](https://docs.roqua.net/en/developer/rom/data_export/sql_export/#schema) page on the API section of the RoQua documentation links to this pages site. 


### Run in Docker
Place the sqlite export of a demo org named `demo_export.db` in this folder.

Run ```DOCKER_BUILDKIT=1 docker build -t schemaspy . && docker run -it --mount type=bind,source="$(pwd)",target=/host schemaspy```

### Run manually
[SchemaPsy](https://github.com/schemaspy/schemaspy/releases) needs java (`brew install openjdk`), graphviz (`brew install graphviz`) and [sqlite-jdbc](https://github.com/xerial/sqlite-jdbc). See also their [docs](https://schemaspy.readthedocs.io/en/latest/installation.html).

Example: `java -jar target/schemaspy-6.1.0.jar -t sqlite-xerial -db demo_export.db -dp sqlite-jdbc-3.34.0.jar -cat % -s schema -u sqlite -o public/sqlite-export-schema`

As of [SchemaSpy 6.2.2](https://github.com/schemaspy/schemaspy/releases) one might drop graphviz and instead use `-vizjs` on the commandline. Also the newer [sqlite-jdbc-3.42.0.0.jar](https://repo1.maven.org/maven2/org/xerial/sqlite-jdbc/3.42.0.0/) might eliminate some warnings with some DBs. 

When rerunning SchemaSpy make sure to remove the dead XML link on `index.html` afterwards. The docker approach does this automatically. 