#!/bin/bash

# ============================================================================================== #
#  {-ABOUT-}                                                                                     #
# |This is a backup scipt for backing up folders/files by creating timestamped (.tar.gz) backups.#
# |The script will create a Backups folder within the directory you run it in, This allows you to# 
# |create multiple backups at a moments notice.                                                  #
#   												 #
#  {-USAGE-}											 #
# "Creates simple backup"									 #
# |~$ backup folder/file  									 #
# ---												 #
# "Creates custom named backup"									 #
# |~$ backup folder/file name_of_backup								 #
#                                                          					 #
#  {-VERSION HISTORY-}										 #
# | v1.0 - Initial release, beta test                                                            #
#                                                                                                #
#  {-AUTHOR-}                                                                                    #
# | Jaison Brooks                                                                                #
#                                                                                                #
# ============================================================================================== #


BACKUP_FOLDER=$1
FOLDER_NAME=$1
TIMESTAMP=$(date +%m%d%Y-%H%M%S)
BACKUP_DIR="Backups"

function makeDir {
 mkdir $BACKUP_DIR
 echo "Created '$BACKUP_DIR' Folder"
}

function displayOutput {
	echo "Created backup file: '$FILE_NAME.tar.gz' in $BACKUP_DIR/"
}

function createBackup {
	echo "Backing up '$FOLDER_NAME'"
	FILE_NAME=$FOLDER_NAME"_"$TIMESTAMP
  	tar -czf $BACKUP_DIR/$FILE_NAME.tar.gz $BACKUP_FOLDER
  	displayOutput
}

function setupBackup { 
	if [ -d $BACKUP_DIR ]; then
    		createBackup
  	else
     		makeDir && createBackup
	fi
}

### [ User Interaction ] ###
if [[ -z "$1" ]]; then
	echo "Missing folder name, try again :)"
  else
  	if [[ -z "$2" ]]; then
    		echo "Missing param 2"
    		if [[ $1 = */* ]]
			then
			    #'/' is in the Value
				FOLDER_NAME=${FOLDER_NAME%"/"}
				setupBackup
			else
				setupBackup
			fi
    	else
    		echo "Its there"
    		if [[ $2 = */* ]]
			then
			    #'/' is in the Value
			    FOLDER_NAME=$2
				FOLDER_NAME=${FOLDER_NAME%"/"}
				setupBackup
			else
				FOLDER_NAME=$2
				setupBackup
			fi
    fi
	
fi
