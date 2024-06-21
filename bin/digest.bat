@echo off
REM # Creates digest for given file in <file>.digest
REM # Author Srivathson KK.
REM ### ====================================================================== ###
REM ##                                                                          ##
REM ## digest.sh <FILES>
REM ##                                                                          ##
REM ### ====================================================================== ###

call .\setCommonEnv.bat

IF "%~1"=="" GOTO SHOW_SYNTAX

set JAVA_OPTS= -Dorg.bouncycastle.fips.approved_only="true" -Djava.security.properties="../conf/fips.security"

set CLASS_PATH="%SERVER_HOME%\lib\toolkit-commons.jar;%SERVER_HOME%\lib\framework-tools.jar;%SERVER_HOME%\lib\conf.jar;%SERVER_HOME%\lib\fips\bc-fips-1.0.2.3.jar;%SERVER_HOME%\lib\fips\bcpkix-fips-1.0.7.jar;%SERVER_HOME%\lib\fips\bctls-fips-1.0.14.jar"

"%JAVA%" %JAVA_OPTS% -cp %CLASS_PATH% com.zoho.framework.utils.FileUtils digest %*
GOTO END_DIGEST

:SHOW_SYNTAX
echo Syntax: %0 p1 [p2...]

:END_DIGEST
