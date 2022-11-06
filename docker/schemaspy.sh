#!/bin/sh

[ -d $SCHEMASPY_DRIVERS ] && export DRIVER_PATH=$SCHEMASPY_DRIVERS || export DRIVER_PATH=/drivers_inc/
echo -n "Using drivers:"
ls -Ax $DRIVER_PATH | sed -e 's/  */, /g'
[ -d ${SCHEMASPY_OUTPUT} ] && echo "rm -rf ${SCHEMASPY_OUTPUT}" && rm -rf ${SCHEMASPY_OUTPUT}
[ -d ${SCHEMASPY_OUTPUT} ] && echo "Warning: output folder '${SCHEMASPY_OUTPUT}' not cleared" 
java -jar /usr/local/lib/schemaspy/schemaspy*.jar -dp $DRIVER_PATH -o $SCHEMASPY_OUTPUT -db /host/$SCHEMASPY_DB $@
[ -f ${SCHEMASPY_OUTPUT}${SCHEMASPY_DB}.schema.xml ] && rm -v ${SCHEMASPY_OUTPUT}${SCHEMASPY_DB}.schema.xml
if [ -f ${SCHEMASPY_OUTPUT}index.html ]; then
  sed -i "/${SCHEMASPY_DB//./\.}\.schema\.xml/d" ${SCHEMASPY_OUTPUT}index.html
  echo "Done. Now run 'open ${SCHEMASPY_OUTPUT#/host/}index.html' to view '${SCHEMASPY_DB}'"
  echo "  (Optional: specify which DB to process by editing 'ENV SCHEMASPY_DB=' in 'Dockerfile')"
else
  echo "Failure: missing index file '${SCHEMASPY_OUTPUT}index.html' for schema '${SCHEMASPY_DB}'"
fi
