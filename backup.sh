#!/bin/bash

if [[ $# != 2 ]]
then
  echo "backup.sh target_directory_name destination_directory_name"
  exit
fi

if [[ ! -d $1 ]] || [[ ! -d $2 ]]
then
  echo "Invalid directory path provided"
  exit
fi

targetDirectory=$1
destinationDirectory=$2

echo "The target Directory is: $targetDirectory"
echo "The destination Directory is: $destinationDirectory"

currentTS=`date +%s`

backupFileName="backup-`echo $currentTS`.tar.gz"

origAbsPath=`pwd`

destDirAbsPath=`cd $destinationDirectory || exit; pwd`

cd $origAbsPath
cd $targetDirectory

yesterdayTS=$((`echo $currentTS` - 24*3600))

declare -a toBackup

for file in *
do
  if [[ `date -r $file +%s` -gt $yesterdayTS ]]
  then 
    toBackup+=("$file")
  fi
done

for item in ${toBackup[@]}; do
    zip -r $backupFileName $item
done

mv $backupFileName $destDirAbsPath