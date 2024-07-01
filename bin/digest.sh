#!/bin/bash

# Creates digest for given file in <file>.digest
# Author Srivathson KK.
### ====================================================================== ###
##                                                                          ##
## digest.sh <FILES>
##                                                                          ##
### ====================================================================== ###

. ./setCommonEnv.sh

if [ $# -lt 1 ]
then
    echo "syntax: $0 <p1> [p2 ...";
    exit 1;
fi

JAVA_OPTS="-Dorg.bouncycastle.fips.approved_only=true -Djava.security.properties=../conf/fips.security "

CLASS_PATH=$SERVER_HOME/lib/toolkit-commons.jar:$SERVER_HOME/lib/framework-tools.jar:$SERVER_HOME/lib/conf.jar:$SERVER_HOME/lib/fips/bc-fips-1.0.2.3.jar:$SERVER_HOME/lib/fips/bcpkix-fips-1.0.7.jar:$SERVER_HOME/lib/fips/bctls-fips-1.0.14.jar

$JAVA  -cp $CLASS_PATH $JAVA_OPTS com.zoho.framework.utils.FileUtils digest "$@"