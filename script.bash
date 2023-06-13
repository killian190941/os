#!/bin/bash


if [$# -ne 2 ]
then 
    echo "usage; backup.sh <source_directory><target_directory>"
    echo  "try again"
    exit 1
fi

fi ! command -v rsync > /dev/null 2>&1
then
    echo "try again"
    echo "plrequire rsync"
    exit 2
fi

current_data=$(date +Y-%m-%d)
rsync_option= "-avb --backupdir $2/current_date --delete --dry-run"

$(which rsync) $rsync_option $1 $2/current >> backup_$current_date.log