#grep "public *Builder *set.*String *value)" -A 5 -n $1 > $temp

#Usage sh removeNPE.sh $INPUT_FILE $OUTPUT_FILE

if [ -z "$1" ] | [ -z "$2" ]
then
    echo "Usage :: sh removeNPE.sh <<INPUT_FILE>> <<OUTPUT_FILE>>"
    exit
fi

awk 'BEGIN{
		foundStringSetter=0
        methodName="";
        twoLevelMethodFormationFlag=0;
        }
		{
			if(foundStringSetter== 1 && $1 == "throw")
			{
                print "return "methodName;
                foundStringSetter=0;
                methodName="";
			} else
			{
                print $0
                
                if($0 ~ "public *Builder *set.*java\.lang\.String *value\\)")
				{	
                    methodName=$3
                    sub(/^set/, "clear", methodName);
				    gsub(/\(.*/, "();", methodName);
                    #print methodName;
                    foundStringSetter=1
				}
				else if($0 ~ "public *Builder *set.*\\(")
				{
					methodName=$3;
					twoLevelMethodFormationFlag=1;
				}
				else if((twoLevelMethodFormationFlag==1) && ($0 ~ ".*java\.lang\.String *value\\)"))
				{
                    sub(/^set/, "clear", methodName);
				    gsub(/\(.*/, "();", methodName);
                    #print methodName;
                    foundStringSetter=1
					twoLevelMethodFormationFlag=0;
				}
			}
		}' < $1 > $2
