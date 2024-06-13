@echo off

rem $Id$

call .\setCommonEnv.bat

IF !%1 == ! (
 echo Usage: 
    echo ..........................................................
    echo  changeKey.bat  ^<new_ectag^>
    echo ..........................................................
    goto End
)

    set JAVA="%JAVA_HOME%\bin\java"
    set JAVA_OPTS= -Dserver.home="%SERVER_HOME%" -Dapp.home="%SERVER_HOME%"  -Ddb.home="%DB_HOME%" -Dfile.encoding="utf8" -Djava.library.path="%SERVER_HOME%\lib\native" -Djava.util.logging.manager="org.apache.juli.ClassLoaderLogManager" -Duser.language="en" -Dfile.encoding="utf8" -Dorg.bouncycastle.fips.approved_only="true" -Djava.security.properties="../conf/fips.security"

    set CLASS_PATH=%SERVER_HOME%\bin\run.jar;%SERVER_HOME%\lib\tomcat\tomcat-juli.jar;%SERVER_HOME%\lib\conf.jar;%SERVER_HOME%\lib\fips\bc-fips-1.0.2.3.jar;%SERVER_HOME%\lib\fips\bcpkix-fips-1.0.7.jar;%SERVER_HOME%\lib\fips\bctls-fips-1.0.14.jar

    %JAVA% %JAVA_OPTS%  -cp "%CLASS_PATH%" com.adventnet.mfw.ChangeECTag %1

:END
