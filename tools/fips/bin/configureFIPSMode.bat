@echo off

rem $Id$

call .\setCommonEnv.bat

set JAVA="%JAVA_HOME%\bin\java"

set JAVA_OPTS=-Dserver.home="%SERVER_HOME%" -Dapp.home="%SERVER_HOME%" -Ddb.home="%DB_HOME%" -Djava.library.path="%SERVER_HOME%\lib\native" -Dstandalone.logger.name="fips" -Drun.standalone.class="com.zoho.mickey.fips.ConfigureFIPS"

set CLASS_PATH="%SERVER_HOME%"\bin\run.jar;"%SERVER_HOME%"\lib\AdventNetNPrevalent.jar;"%SERVER_HOME%"\lib\conf.jar;

%JAVA% -cp %CLASS_PATH% %JAVA_OPTS%  com.adventnet.mfw.Starter runStandalone %*

set MOD_OPENPDF="%SERVER_HOME%\tools\fips\lib\openpdf-1.3.30.jar"

if exist "%MOD_OPENPDF%" (
    copy /Y "%MOD_OPENPDF%" "%SERVER_HOME%"\lib
)