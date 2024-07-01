@echo off

set SERVER_HOME=%~dp0%\..

if "%JAVA_HOME%"=="" (
    echo Set java home in the variable 'JAVA_HOME'
    exit /b
) else (
    echo JAVA HOME: %JAVA_HOME%
)

if "%~1"=="" (
    echo Help : validate.bat ^<TDValidatorClassName^>
    exit /b
)

:: Setting Class path for TDValidation
set CLASSPATH="%SERVER_HOME%\lib\*;%SERVER_HOME%\bin\run.jar;%SERVER_HOME%\lib\tomcat\*;%SERVER_HOME%\lib\zohosecurity\*"


echo STARTING VALIDATIONS
"%JAVA_HOME%\bin\java" -classpath %CLASSPATH% com.adventnet.db.persistence.metadata.util.StaticTDValidatorUtil %1