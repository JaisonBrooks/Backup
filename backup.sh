#!/bin/bash

# ============================================================================================== #
# =ABOUT=                                                                                        #
# |This is a scipt for backing up folders/files quick and easily. The script creates compressed..#
# |(.tar.gz) files and stores them in a Backups folder in the current directory.                 # 
#                                                                                                #
# =USAGE=                                                                                        #
# |> "Creates simple backup"                                                                     #
# |> ~$ backup folder/file                                                                       #
#                                                                                                #
# |> "Creates custom named backup"                                                               #
# |> ~$ backup folder/file name_of_backup                                                        #
#                                                                                                #
# =REVISION HISTORY=                                                                             #
# |> v1.0 - Initial release, beta test                                                           #
# |> v1.1 - Fixed param echo                                                                     #
# |> v1.2 - Added Verbose/Help option                                                            #
#                                                                                                #
# =AUTHOR=                                                                                       #
# |> Jaison Brooks                                                                               #
#                                                                                                #
# ============================================================================================== #

BACKUP_FOLDER=$1
FOLDER_NAME=$1
TIMESTAMP=$(date +%m%d%Y-%H%M%S)
BACKUP_DIR="Backups"
PROG=`basename $0`
VERBOSE=false


function showHelp {
	HELP=yes
	echo "$PROG:|==========[ HELP ]===========|"
	echo "$PROG:|"
	echo "$PROG:| This help section is not really done yet, stay tunned"
	echo "$PROG:|"
	echo "$PROG:| BASIC USAGE"
	echo "$PROG:|   - $ backup file/folder"
	echo "$PROG:|"
	echo "$PROG:| ADVANCED USAGE"
	echo "$PROG:|   - $ backup file/folder name_of_backup -v"
	echo "$PROG:|   - This will create a backup, with a custom name and include verbose output"
	echo "$PROG:|"
	echo "$PROG:|==========[ /HELP ]===========|"
}

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
	if [[ $VERBOSE == true ]]; then
		tar -cvzf $BACKUP_DIR/$FILE_NAME.tar.gz $BACKUP_FOLDER
	else
		tar -czf $BACKUP_DIR/$FILE_NAME.tar.gz $BACKUP_FOLDER
	fi
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
echo "Starting..."
for x; do
	if [ $x == "-v" ]; then
		echo "$PROG:| Running w/ Verbose"
		VERBOSE=true
	elif [[ $x == "-h" ]]; then
		showHelp
	elif [[ $x == "--" ]]; then
		echo "$PROG:| Not a valid Argument"
	fi
done
if [[ -z "$1" ]]; then
	echo "$PROG:| Missing folder name, try again :)"
	  else
	  	# if [[ -z "$2" ]]; then
		if [[ $1 = */* ]]
		then
		    #'/' is in the Value
			FOLDER_NAME=${FOLDER_NAME%"/"}
			setupBackup
		else
			setupBackup
		fi
	   			# else
	   			# #echo "$PROG:| Its there"
	   			# if [[ $2 = */* ]]
				# then
				#     #'/' is in the Value
				#     FOLDER_NAME=$2
				# 	FOLDER_NAME=${FOLDER_NAME%"/"}
				# 	setupBackup
				# else
				# 	FOLDER_NAME=$2
				# 	setupBackup
				# fi
	    		#fi
fi

# WILL MOVE TO TRADITIONAL OPTIONS EVENTUALLY
# getopt -T > /dev/null
# 	if [ $? -eq 4 ]; then
# 	  # GNU enhanced getopt is available
# 	  ARGS=`getopt --name "$PROG" --long help,verbose --options ho:v -- "$@"`
# 	else
# 	  # Original getopt is available (no long option names, no whitespace, no sorting)
# 	  ARGS=`getopt ho:v "$@"`
# 	fi
# 	if [ $? -ne 0 ]; then
# 	  echo "$PROG: You've used it wrong, try using (-h for help)" >&2
# 	  exit 2
# 	fi
# 	eval set -- $ARGS

# 	while [ $# -gt 0 ]; do
# 	    case "$1" in
# 	        -h | --help)     showHelp;;
# 	        -v | --verbose)  showVerbose;;
# 			-n | --name)	 backupCustomName;;
# 	        --)              shift; break;; # end of options
# 	    esac
# 	    shift
# 	done

# 	if [ $# -gt 0 ]; then
# 	  # Remaining parameters can be processed
# 	  for ARG in "$@"; do
# 	    echo "$PROG: argument: $ARG"
# 	  done
# 	fi




