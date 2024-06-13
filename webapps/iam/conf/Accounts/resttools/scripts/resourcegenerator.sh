main(){
	# $1 - ClassPath
	# $2 - Package Name
	# $3 - Generated Class Name
	# $4 - OutputPath
        # $5 - FilePath
        # $6 - Enum template file

       if [ ! -d $4 ] 
       then
            mkdir $4 ;
       fi
       JAVA_OPTS="-cp $1 -Dres.field.pkg=$2 -Dres.field.class.name=$3 -Dres.field.out.dir=$4 -Dres.field.file.dir=$5 -Dres.enum.file.dir=$6"
       
       JAVA_EXEC="$JAVA_HOME/jre/bin/java"
		if [ ! -a $JAVA_EXEC ]
		then
			JAVA_EXEC="$JAVA_HOME/bin/java"
		fi
        
       $JAVA_EXEC $JAVA_OPTS com.zoho.resource.metadata.internal.ResourceEnumGenerator
       
       JAVA_EXIT_STATUS=$?
		echo "ES CONSTANTS GENERATION FINISHED"
		
		exit ${JAVA_EXIT_STATUS};

}
main $*