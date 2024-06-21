@ECHO off

SETLOCAL enabledelayedexpansion

SET SERVER_HOME=%~dp0%..
SET STATUS_FILE="%SERVER_HOME%\conf\ha\UpgradeStatus.txt"
SET FIND_CMD="%SystemRoot%\system32\findstr.exe"
SET MODULE_FILE="%SERVER_HOME%\conf\Persistence\module-startstop-processors.xml"

REM checking if HA or DB HA is enabled
%FIND_CMD% /I "\"HA\""  %MODULE_FILE%> NUL
IF %ERRORLEVEL% NEQ 0 GOTO end

:monitor
	IF EXIST %STATUS_FILE% (
		%FIND_CMD% /I "\<waitForUpgrade\>" %STATUS_FILE% > NUL
		REM do not use %ERRORLEVEL% here instead of !ERRORLEVEL!, variables that changes inside a loop have to be enclosed between two exclamatory marks to get proper value
		IF !ERRORLEVEL! EQU 0 ( 
			ECHO Upgrade is in progress.. hence waiting for it to finish.
			REM waiting for ten seconds before checking the upgrade status
			TIMEOUT /T 10 /NOBREAK > NUL
			GOTO monitor
			)
		)
		
:end 
REM no need to move to serverhome again, ENDLOCAL command will take control to folder where execution has started
ENDLOCAL
