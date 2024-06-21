@echo off

set appHome=%~1
IF "%appHome%" == "" (
	echo "Usage : setAppPermission.bat <AppHomeDirectory>"
    echo "Please provide application home directory path to set access permission"
	GOTO End
)

set CACL_CMD="%SystemRoot%\system32\icacls.exe"

set %errorLevel% = 0
net session >nul 2>&1

    if %errorLevel% == 0 (
       GOTO CHANGE_PERMISSION
    ) else (
        echo You must run the command prompt as administrator to set access permission.
		GOTO End
    )

:CHANGE_PERMISSION	
	%CACL_CMD% "%appHome%" /grant *S-1-5-18:(OI)(CI)F /T /Q /grant *S-1-5-32-544:(OI)(CI)F /T /Q
    %CACL_CMD% "%appHome%" /grant:r "%userdomain%\%username%":(OI)(CI)F /T /Q
 	%CACL_CMD% "%appHome%" /inheritance:r /Q
    %CACL_CMD% "%appHome%" /remove:g "CREATOR OWNER" /T /Q /remove:g "BUILTIN\Users" /T /Q /remove:g *S-1-15-2-1 /T /Q
    %CACL_CMD% "%appHome%" /remove:g *S-1-5-11 /T /Q /remove:g *S-1-15-2-2 /T /Q
 	
:End