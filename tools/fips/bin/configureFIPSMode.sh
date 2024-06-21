# $Id$
#!/bin/sh
. ./setCommonEnv.sh

JAVA="$JAVA_HOME/bin/java"

JAVA_OPTS="-Dserver.home=$SERVER_HOME -Dapp.home=$SERVER_HOME -Ddb.home=$DB_HOME -Djava.library.path=$SERVER_HOME/lib/native -Dstandalone.logger.name=fips -Drun.standalone.class=com.zoho.mickey.fips.ConfigureFIPS"

CLASS_PATH=$SERVER_HOME/bin/run.jar:$SERVER_HOME/lib/AdventNetNPrevalent.jar:$SERVER_HOME/lib/conf.jar

$JAVA -cp $CLASS_PATH $JAVA_OPTS com.adventnet.mfw.Starter runStandalone "$@"

MOD_OPENPDF="$SERVER_HOME/tools/fips/lib/openpdf-1.3.30.jar"

if [ -e "$MOD_OPENPDF" ]; then
    cp -f "$MOD_OPENPDF" "$SERVER_HOME/lib"
fi