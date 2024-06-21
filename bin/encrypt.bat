@echo off
REM # Automate the encryption for the given plaintext.
REM # Author Divya J.
REM ### ====================================================================== ###
REM ##                                                                          ##
REM ## encrypt.bat  <PLAIN_TEXT> 
REM ##                                                                          ##
REM ### ====================================================================== ###

call .\setCommonEnv.bat

set CLASS_PATH="%SERVER_HOME%\lib\toolkit-commons.jar;%SERVER_HOME%\lib\framework-tools.jar;%SERVER_HOME%\lib\conf.jar;%SERVER_HOME%\lib\fips\bc-fips-1.0.2.3.jar;%SERVER_HOME%\lib\fips\bcpkix-fips-1.0.7.jar;%SERVER_HOME%\lib\fips\bctls-fips-1.0.14.jar"

IF "%1"=="" GOTO SHOW_SYNTAX

"%JAVA%"  -Dserver.home="%SERVER_HOME%" -Dorg.bouncycastle.fips.approved_only="true" -Djava.security.properties="../conf/fips.security" -cp %CLASS_PATH% com.zoho.framework.utils.crypto.CryptoUtil %*
GOTO END_ENCRYPT

:SHOW_SYNTAX 
"%JAVA%" -Dserver.home="%SERVER_HOME%" -cp %CLASS_PATH% com.zoho.framework.utils.crypto.CryptoUtil "showUsage"

:END_ENCRYPT
