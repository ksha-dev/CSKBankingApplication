@echo off

rem $Id$

call .\setCommonEnv.bat

set JAVA="%JAVA_HOME%\bin\java"

set JAVA_OPTS= -Dserver.home="%SERVER_HOME%" -Dapp.home="%SERVER_HOME%"  -Ddb.home="%DB_HOME%" -Dfile.encoding="utf8" -Djava.library.path="%SERVER_HOME%\lib\native" -Dstandalone.logger.name="ChangeDBPassword" -Drun.standalone.class="com.zoho.mickey.tools.ChangePassword" -Dgen.db.password="false" -Dorg.bouncycastle.fips.approved_only="true" -Djava.security.properties="../conf/fips.security"


set CLASS_PATH=%SERVER_HOME%\bin\run.jar;%SERVER_HOME%\lib\AdventNetNPrevalent.jar;%SERVER_HOME%\lib\conf.jar;%SERVER_HOME%\lib\fips\bc-fips-1.0.2.3.jar;%SERVER_HOME%\lib\fips\bcpkix-fips-1.0.7.jar;%SERVER_HOME%\lib\fips\bctls-fips-1.0.14.jar

%JAVA% %JAVA_OPTS%  -cp "%CLASS_PATH%" com.adventnet.mfw.Starter runStandalone %*
