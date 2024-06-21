@rem Please set your Java path here.set
@echo off
cd ..
set SERVER_HOME=%~dp0%\.
cd bin
call .\setcommonenv.bat
cd ..
if NOT EXIST "%JAVA_HOME%\bin\java.exe" echo "Please set the JAVA_HOME parameter in" %0
if NOT EXIST "%JAVA_HOME%\bin\java.exe" exit /b 1
cd lib
if NOT EXIST AdventNetUpdateManagerInstaller.jar_new goto start
copy AdventNetUpdateManagerInstaller.jar_new AdventNetUpdateManagerInstaller.jar
del AdventNetUpdateManagerInstaller.jar_new
:start
cd ..
set PATH=%PATH%;".\lib\native"
set CLASSPATH=.\lib\AdventNetUpdateManagerInstaller.jar;.\lib\fips\bc-fips-1.0.2.3.jar;.\lib\fips\bcpkix-fips-1.0.7.jar;.\lib\fips\bctls-fips-1.0.14.jar
set JAVA_COMPILER=NONE

@rem set JAVA_OPTS=-Ddb.home="%DB_HOME%" -Dtools.discSpaceCheck="false" -Dfile.encoding="utf8"

set JAVA_OPTS=-Ddb.home="%DB_HOME%" -Dtools.discSpaceCheck="false" -Dfile.encoding="utf8" -Djava.security.properties="./conf/fips.security" -Dorg.bouncycastle.fips.approved_only="true"

"%JAVA_HOME%\bin\java" -Xms128m -Xmx512m  %JAVA_OPTS% -Dtier-type=BE -Djava.library.path=.\lib\native -Dtier-id=BE1 com.adventnet.tools.update.installer.UpdateManager -u conf %*
cd bin
