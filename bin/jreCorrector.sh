DIRNAME=`dirname "$0"`

validate()
{
    if [ $? -ne 0 ];
    then
       echo $1
       exit 1970
    fi
}

move()
{
   extensions="_old _new"
   for extension in $extensions; do
     originalFile=$1
     destination="${originalFile}${extension}"
     if test -d "$destination"
	   then
          rm -rf "$originalFile"
	        mv  "$destination" "$originalFile"
	       if [ $? -ne 0 ];
	       then
	         echo "Unable to move the file/folder $destination to $originalFile"
	         exit 1970
	       fi
     elif [ -f "$destination" ]; then
          mv  "$destination" "$originalFile"
	        if [ $? -ne 0 ];
	        then
	         echo "Unable to move the file/folder $destination to $originalFile"
	         exit 1970
	       fi
      fi
done
}

SERVER_HOME=$(cd "$DIRNAME/.."; pwd -P)

if [ ! -f "$SERVER_HOME/jre.lock" ]; then
  move "$SERVER_HOME/lib/fips"
  move "$SERVER_HOME/lib/os-utils"
  if [ -f "$SERVER_HOME/lib/os-utils_delete" ];then
         rm -rf "$SERVER_HOME/lib/os-utils_delete"
         validate "Unable to remove $SERVER_HOME/lib/os-utils_delete file. Hint :: It might not have proper permissions or held by a process. Remove the folder and proceed."
         rm -rf "$SERVER_HOME/lib/os-utils"
         validate "Unable to remove $SERVER_HOME/lib/os-utils folder. Hint :: It might not have proper permissions or held by a process. Remove the folder and proceed."
   fi
    if [ -f "$SERVER_HOME/clean_new_jre" ]; then
        if test -d "$SERVER_HOME/jre_new"; then
            rm -rf "$SERVER_HOME/jre_new"
            validate "Unable to remove $SERVER_HOME/jre_new folder. Hint :: It might not have proper permissions or held by a process. Remove the folder and proceed."
        fi
        rm -rf "$SERVER_HOME/clean_new_jre"
        validate "Unable to remove $SERVER_HOME/clean_new_jre file. Hint :: It might not have proper permissions or held by a process. Remove the file and proceed."
    elif [ -f "$SERVER_HOME/use_old_jre" ]; then
    	if test -d "$SERVER_HOME/jre"; then
          if test -d "$SERVER_HOME/jre_old"; then
            rm -rf "$SERVER_HOME/jre"
            validate "Unable to remove $SERVER_HOME/jre folder. Hint :: It might not have proper permissions or held by a process. Remove the folder and proceed."
          fi
        fi
        if test -d "$SERVER_HOME/jre_old"; then
            mv "$SERVER_HOME/jre_old" "$SERVER_HOME/jre"
            validate "Unable to move/rename $SERVER_HOME/jre_old to $SERVER_HOME/jre folder. Hint :: It might not have proper permissions or held by a process. Rename the folder and proceed."
        fi
        if test -d "$SERVER_HOME/jre_new"; then
            rm -rf "$SERVER_HOME/jre_new"
            validate "Unable to remove $SERVER_HOME/jre_new folder. Hint :: It might not have proper permissions or held by a process. Remove the folder and proceed."
        fi
        rm -rf "$SERVER_HOME/use_old_jre"
        validate "Unable to remove $SERVER_HOME/use_old_jre file. Hint :: It might not have proper permissions or held by a process. Remove the file and proceed."
    else
        if test -d "$SERVER_HOME/jre_new"; then
            if test -d "$SERVER_HOME/jre"; then
                if test -d "$SERVER_HOME/jre_old"; then
                    rm -rf "$SERVER_HOME/jre_old"
                    validate "Unable to remove $SERVER_HOME/jre_old folder. Hint :: It might not have proper permissions or held by a process. Remove the folder and proceed."
                fi
                mv "$SERVER_HOME/jre" "$SERVER_HOME/jre_old"
                validate "Unable to move/rename $SERVER_HOME/jre to $SERVER_HOME/jre_old folder. Hint :: It might not have proper permissions or held by a process. Rename the folder and proceed."
            fi
            mv "$SERVER_HOME/jre_new" "$SERVER_HOME/jre"
            validate "Unable to move/rename $SERVER_HOME/jre_new to $SERVER_HOME/jre folder. Hint :: It might not have proper permissions or held by a process. Rename the folder and proceed."
        fi
    fi
fi
