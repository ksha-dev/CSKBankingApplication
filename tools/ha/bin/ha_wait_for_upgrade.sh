#!/bin/bash
DIRNAME=`dirname $0`

SERVER_HOME=$(cd $DIRNAME/..; pwd -P)
STATUS_FILE="$SERVER_HOME/conf/ha/UpgradeStatus.txt"
MODULE_FILE="$SERVER_HOME/conf/Persistence/module-startstop-processors.xml"

monitor() {
	if [ -f "$STATUS_FILE" ]; then
		grep -iw "waitForUpgrade" "$STATUS_FILE" &>/dev/null
		if [ $? = 0 ]; then 
			echo Upgrade is in progress.. hence waiting for it to finish.
			#waiting for ten seconds before checking the upgrade status
			sleep 10
			monitor
		fi
	fi
}

#checking if HA or DB HA is enabled
grep -i '"HA"' "$MODULE_FILE" &>/dev/null
if [ $? != 0 ]; then 
	exit 0
fi

monitor
