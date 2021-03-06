#!/bin/sh
if [ $# -ne 2 ]
then
    echo "GROUP ID - ARTIFACT ID"
    exit 1
fi

mvn org.apache.maven.plugins:maven-archetype-plugin:3.1.2:generate -DarchetypeArtifactId="objetos-uno" -DarchetypeGroupId="ar.edu.unlp.info.oo1" -DarchetypeVersion="0.0.1-SNAPSHOT" -DgroupId="$1" -DartifactId="$2"
