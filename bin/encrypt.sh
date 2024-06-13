#!/bin/bash

# automate the encryption for the given plaintext.
# Author Divya J.
### ====================================================================== ###
##                                                                          ##
## encrypt.sh  <PLAIN_TEXT> 
##                                                                          ##
### ====================================================================== ###

. ./setCommonEnv.sh

PLAINTEXT=$1
CLASS_PATH=$SERVER_HOME/lib/toolkit-commons.jar:$SERVER_HOME/lib/framework-tools.jar:$SERVER_HOME/lib/conf.jar:$SERVER_HOME/lib/fips/bc-fips-1.0.2.3.jar:$SERVER_HOME/lib/fips/bcpkix-fips-1.0.7.jar:$SERVER_HOME/lib/fips/bctls-fips-1.0.14.jar
if [ $# -lt 1 ]
then
$JAVA -Dserver.home=$SERVER_HOME -Dapp.home=$SERVER_HOME -cp $CLASS_PATH com.zoho.framework.utils.crypto.CryptoUtil "showUsage"
exit 1;
fi

$JAVA -Dserver.home=$SERVER_HOME -Dapp.home=$SERVER_HOME -Dorg.bouncycastle.fips.approved_only=true -Djava.security.properties=../conf/fips.security -cp $CLASS_PATH com.zoho.framework.utils.crypto.CryptoUtil "$@"
