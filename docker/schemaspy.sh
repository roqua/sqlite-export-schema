#!/bin/sh
[ -d $SCHEMASPY_DRIVERS ] && export DRIVER_PATH=$SCHEMASPY_DRIVERS || export DRIVER_PATH=/drivers_inc/
echo -n "Using drivers:"
ls -Ax $DRIVER_PATH | sed -e 's/  */, /g'
java -jar /usr/local/lib/schemaspy/schemaspy*.jar -dp $DRIVER_PATH -o $SCHEMASPY_OUTPUT $@
rm /host/public/demo_export.db.schema.xml
sed -i '/demo_export\.db\.schema\.xml/d' /host/public/index.html