This repository contains an export from SchemaSpy that lets people browse the database structure of our SQLite exports.

[SchemaPsy](https://schemaspy.readthedocs.io/en/latest/installation.html) needs java (`brew install openjdk`), graphviz (`brew install graphviz`) and [sqlite-jdbc](https://github.com/xerial/sqlite-jdbc).

Example: `java -jar schemaspy-6.1.0.jar -t sqlite-xerial -db demo_export.db -o blah -u blah -dp sqlite-jdbc-3.34.0.jar -cat blah -s blah`
     