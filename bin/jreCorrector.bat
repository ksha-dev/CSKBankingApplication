@echo off

set SERVER_HOME=%~dp0%\..
set error=0
set IS_EXECUTED_DIR=-1
set IS_FILE=0

IF NOT EXIST "%SERVER_HOME%\jre.lock" (
   set IS_EXECUTED_DIR=1
   call :MOVE "%SERVER_HOME%\lib\fips"
   call :MOVE "%SERVER_HOME%\lib\os-utils"
   set IS_EXECUTED_DIR=-1
   IF EXIST "%SERVER_HOME%\lib\os-utils_delete" (
	 IF EXIST "%SERVER_HOME%\lib\os-utils" (
           rd /S /Q "%SERVER_HOME%\lib\os-utils"
           IF EXIST "%SERVER_HOME%\lib\os-utils" (
                 echo "Unable to remove %SERVER_HOME%\lib\os-utils folder. Hint :: It might not have proper permissions or held by a process. Remove the folder and proceed."
                  set error=1970
                   goto endOfScript
          )
	)
             DEL /Q "%SERVER_HOME%\lib\os-utils_delete"
                IF EXIST "%SERVER_HOME%\lib\os-utils_delete" (
                echo "Unable to remove %SERVER_HOME%\lib\os-utils_delete file. Hint :: It might not have proper permissions or held by a process. Remove the folder and proceed."
                set error=1970
                goto endOfScript
          )
	)

    IF EXIST "%SERVER_HOME%\clean_new_jre" (
        IF EXIST "%SERVER_HOME%\jre_new" (
            rd /S /Q "%SERVER_HOME%\jre_new"
			IF EXIST "%SERVER_HOME%\jre_new" (
			   echo "Unable to remove %SERVER_HOME%\jre_new folder. Hint :: It might not have proper permissions or held by a process. Remove the folder and proceed."
			   set error=1970
			   goto endOfScript
			)
        )
        DEL /Q "%SERVER_HOME%\clean_new_jre"
		IF EXIST "%SERVER_HOME%\clean_new_jre" (
			   echo "Unable to delete %SERVER_HOME%\clean_new_jre file. Hint :: It might not have proper permissions or held by a process. Delete the file and proceed."
			   set error=1970
			   goto endOfScript
		)
    ) ELSE (
        IF EXIST "%SERVER_HOME%\use_old_jre" (
            IF EXIST "%SERVER_HOME%\jre" (
               IF EXIST "%SERVER_HOME%\jre_old" (
                rd /S /Q "%SERVER_HOME%\jre"
				IF EXIST "%SERVER_HOME%\jre" (
			      echo "Unable to remove %SERVER_HOME%\jre folder. Hint :: It might not have proper permissions or held by a process. Remove the folder and proceed."
				  set error=1970
			      goto endOfScript
			    )
			  )
            )
            IF EXIST "%SERVER_HOME%\jre_old" (
                MOVE "%SERVER_HOME%\jre_old" "%SERVER_HOME%\jre"
				IF EXIST "%SERVER_HOME%\jre_old" (
			           echo "Unable to move/rename %SERVER_HOME%\jre_old folder to %SERVER_HOME%\jre . Hint :: It might not have proper permissions or held by a process. Rename the folder and proceed."
					   set error=1970
			           goto :endOfScript
			    )
            )
            IF EXIST "%SERVER_HOME%\jre_new" (
                rd /S /Q "%SERVER_HOME%\jre_new"
				IF EXIST "%SERVER_HOME%\jre_new" (
			      echo "Unable to remove %SERVER_HOME%\jre_new folder. Hint :: It might not have proper permissions or held by a process. Remove the folder and proceed."
				  set error=1970
			      goto endOfScript
			  )
            )
            DEL /Q "%SERVER_HOME%\use_old_jre"
			IF EXIST "%SERVER_HOME%\use_old_jre" (
			   echo "Unable to delete %SERVER_HOME%\use_old_jre file. Hint :: It might not have proper permissions or held by a process. Delete the file and proceed."
			   set error=1970
			   goto endOfScript
		    )
        ) ELSE (
            IF EXIST "%SERVER_HOME%\jre_new" (
                if EXIST "%SERVER_HOME%\jre" (
                    if EXIST "%SERVER_HOME%\jre_old" (
                        rd /S /Q "%SERVER_HOME%\jre_old"
                        if EXIST "%SERVER_HOME%\jre_old" (
			              echo "Unable to remove %SERVER_HOME%\jre_old folder. Hint :: It might not have proper permissions or held by a process. Remove the folder and proceed."
						  set error=1970
			              goto :endOfScript
			          )
                    )
                    MOVE "%SERVER_HOME%\jre" "%SERVER_HOME%\jre_old"
					IF EXIST "%SERVER_HOME%\jre" (
			           echo "Unable to move/rename %SERVER_HOME%\jre folder to %SERVER_HOME%\jre_old . Hint :: It might not have proper permissions or held by a process. Rename the folder and proceed."
					   set error=1970
			           goto :endOfScript
			        )
                )
                MOVE "%SERVER_HOME%\jre_new" "%SERVER_HOME%\jre"
				IF EXIST "%SERVER_HOME%\jre_new" (
			           echo "Unable to move/rename %SERVER_HOME%\jre_new folder to %SERVER_HOME%\jre . Hint :: It might not have proper permissions or held by a process. Rename the folder and proceed."
					   set error=1970
			           goto :endOfScript
			    )
            )
        )
    )
:endOfScript
exit /b %error%
)


:MOVE
  IF %IS_EXECUTED_DIR% == 1 (
  setlocal enabledelayedexpansion
  set extensions[0]=_old
  set extensions[1]=_new
  for /l %%a in (0,1,1) do (
       set originalFile=%1%
       set destination=!originalFile!!extensions[%%a]!
	   IF EXIST "!destination!" (
         IF EXIST "!originalFile!" (
		 IF %IS_FILE% == 0 (
            rd /S /Q "!originalFile!"
		 ) ELSE (
		   DEL /Q "!originalFile!"
		 )
         IF EXIST "!originalFile!" (
           echo "Unable to remove "!originalFile!" file/folder. Hint :: It might not have proper permissions or held by a process. Remove the file/folder and proceed."
           exit /b 1970
          )
		 )
		  MOVE "!destination!" "!originalFile!"
	      IF NOT EXIST "!originalFile!" (
	       echo "Unable to move "!destination!" to "!originalFile!" file/folder. Hint :: It might not have proper permissions or held by a process. Remove the file/folder and proceed."
		   exit /b 1970
      )
   )
  )
 )
