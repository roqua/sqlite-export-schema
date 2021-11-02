# based on https://github.com/schemaspy/schemaspy/blob/master/Dockerfile
FROM openjdk:8u111-jre-alpine

ENV LC_ALL=C

ARG GIT_BRANCH=local
ARG GIT_REVISION=local

ENV SQLITE_JDBC_VERSION=3.36.0.1
LABEL SQLITE_JDBC_VERSION=$SQLITE_JDBC_VERSION

LABEL GIT_BRANCH=$GIT_BRANCH
LABEL GIT_REVISION=$GIT_REVISION

ADD docker/open-sans.tar.gz /usr/share/fonts/

RUN adduser java -h / -D && \
    set -x && \
    apk add --no-cache curl unzip graphviz fontconfig && \
    fc-cache -fv && \
    mkdir /drivers_inc && \
    cd /drivers_inc && \
    curl -JLO https://search.maven.org/remotecontent?filepath=org/xerial/sqlite-jdbc/$SQLITE_JDBC_VERSION/sqlite-jdbc-$SQLITE_JDBC_VERSION.jar && \
    chown -R java /drivers_inc && \
    apk del curl


ADD target/schema*.jar /usr/local/lib/schemaspy/
ADD docker/schemaspy.sh /usr/local/bin/schemaspy

USER java
WORKDIR /

ENV SCHEMASPY_DRIVERS=/drivers
ENV SCHEMASPY_OUTPUT=/host/public

ENTRYPOINT ["/usr/local/bin/schemaspy"]
CMD ["-t sqlite-xerial -db /host/demo_export.db -u sqlite -cat % -s schema"]