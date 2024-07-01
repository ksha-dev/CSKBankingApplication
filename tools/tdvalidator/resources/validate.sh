if [ -n "$JAVA_HOME" ];then
        echo JAVA HOME : $JAVA_HOME
else
        echo "Set java home in the variable 'JAVA_HOME'"
	exit
fi

if [ -z "$1" ]
then
    echo "Help : sh validate.sh     <<TDValidatorClassName>> "
    exit
fi

CLASSPATH=
for i in `ls ./lib/*.jar`
do
        CLASSPATH="$i:$CLASSPATH"
done
export CLASSPATH=$CLASSPATH

echo CLASSPATH

echo STARTING VALIDATIONS
$JAVA_HOME/bin/java com.adventnet.db.persistence.metadata.util.StaticTDValidatorUtil $1
