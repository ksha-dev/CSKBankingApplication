#!/bin/sh

. ./setCommonEnv.sh
if [ -z ${JAVA} ];
then
   echo "JAVA Home is not set. Kindly set and proceed"
   exit
fi

cd ../lib

	if [ -f AdventNetUpdateManagerInstaller.jar_new ];
	then
		cp AdventNetUpdateManagerInstaller.jar_new AdventNetUpdateManagerInstaller.jar
		rm -r AdventNetUpdateManagerInstaller.jar_new
	else
		echo ""
	fi

cd ..

LD_LIBRARY_PATH=$DB_HOME/lib/:./lib/native:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH

CLASSPATH=./lib/AdventNetUpdateManagerInstaller.jar:./lib/fips/bc-fips-1.0.2.3.jar:./lib/fips/bcpkix-fips-1.0.7.jar:./lib/fips/bctls-fips-1.0.14.jar
export CLASSPATH

JAVA_OPTS="-Ddb.home=$DB_HOME -Dfile.encoding=utf8 -Djava.security.properties=./conf/fips.security -Dorg.bouncycastle.fips.approved_only=true"

$JAVA -Xms128m -Xmx512m  $JAVA_OPTS -Dtier-type=BE -Djava.library.path=./lib/native -Dtier-id=BE1 -cp $CLASSPATH com.adventnet.tools.update.installer.UpdateManager -u conf $*
cd bin
