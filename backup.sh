#!/bin/bash


# ============================================================================================= #
# ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| #
#                                                                                               #
# =ABOUT=                                                                                       #
# This is a scipt for backing up folders/files quickly, cleanly and efficently.                 #
# By outputing the files into a compressed/uncompressed "tar.gz" or ".zip" file. These backups  #
# are then saved into a local folder called "Backups" where all of your timestamped backups are #
# located and managed.                                                                          #
#                                                                                               #
# =USAGE=                                                                                       #
#  Creating a simple backup                                                                     #
# |> ~$ backup folder/file                                                                      #
#                                                                                               #
#  Creating a advanced backup with verbose                                                      #
# |> ~$ backup folder/file name_of_backup -v                                                    #
#                                                                                               #
# =REVISION HISTORY=                                                                            #
# |> 1.0 | Initial release, beta test                                                           #
# |> 1.1 | Fixed param echo                                                                     #
# |> 1.2 | Added Verbose/Help option                                                            #
# |> 1.3 | Included zip output, uncompressed output, improved ui                                #
#                                                                                               #
# =AUTHOR=                                                                                      #
# |> Jaison Brooks                                                                              #
#                                                                                               #
# ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| #
# ============================================================================================= #

BACKUP_FOLDER=$1
FOLDER_NAME=$1
TIMESTAMP=$(date +%m%d%Y-%H%M%S)
BACKUP_DIR="Backups"
PROG=`basename $0`
VERBOSE=false
OUTZIP=false

function showHelp {
	HELP=yes
	echo "$PROG:|==========[ HELP ]===========|"
	echo "$PROG:|"
	echo "$PROG:| This help section is not really done yet, stay tunned"
	echo "$PROG:|"
	echo "$PROG:| BASIC USAGE"
	echo "$PROG:|   - $ backup file/folder"
	echo "$PROG:|"
	echo "$PROG:| INTERMEDIATE USAGE"
	echo "$PROG:|   - $ backup file/folder -v"
	echo "$PROG:|   - This will create a backup and display the verbose output"
	echo "$PROG:|"
	echo "$PROG:| ADVANCED USUAGE"
	echo "$PROG:|   - $ backup file/folder -v -z"
	echo "$PROG:|   - Creates backup while displaying verbose and exports to a zip file"
	echo "$PROG:|"
	echo "$PROG:|==========[ /HELP ]===========|"
}

function makeDir {
 	mkdir $BACKUP_DIR
 	echo "$PROG:| Created '$BACKUP_DIR' Folder"
}

function displayOutput {
	if [[ $OUTZIP == true ]]; then
		echo "$PROG:| Created backup file '$FILE_NAME.zip' in $BACKUP_DIR/"
	else
		echo "$PROG:| Created backup file '$FILE_NAME.tar.gz' in $BACKUP_DIR/"
	fi
}

function createBackup {

	function outputToZip {
		echo "$PROG:| Exporting files zip file"
		tar -czf $BACKUP_DIR/$FILE_NAME.tar.gz $BACKUP_FOLDER && cp $BACKUP_DIR/$FILE_NAME.tar.gz $BACKUP_DIR/$FILE_NAME.zip && rm -r $BACKUP_DIR/$FILE_NAME.tar.gz
	}
	function outputToZipV {
		echo "$PROG:| Exporting files to zip file"
		tar -cvzf $BACKUP_DIR/$FILE_NAME.tar.gz $BACKUP_FOLDER && cp $BACKUP_DIR/$FILE_NAME.tar.gz $BACKUP_DIR/$FILE_NAME.zip && rm -r $BACKUP_DIR/$FILE_NAME.tar.gz
	}

	echo "$PROG:| Backing up '$FOLDER_NAME'"
	FILE_NAME=$FOLDER_NAME"_"$TIMESTAMP
	if [[ $VERBOSE == true ]]; then
		if [[ $OUTZIP == true ]]; then
			outputToZipV
		else
			tar -cvzf $BACKUP_DIR/$FILE_NAME.tar.gz $BACKUP_FOLDER
		fi
	else
		if [[ $OUTZIP == true ]]; then
			outputToZip
		else
			tar -czf $BACKUP_DIR/$FILE_NAME.tar.gz $BACKUP_FOLDER
		fi
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
echo "$PROG:|..."
for x; do
	if [[ $x == "-v" ]]; then
		echo "$PROG:| Running w/ Verbose"
		VERBOSE=true
	fi
	if [[ $x == "-z" ]]; then
		echo "$PROG:| Outputing into a .zip file"
		OUTZIP=true
	fi
	if [[ $x == "--" ]]; then
		echo "$PROG:| Not a valid Argument, try again :{"
		showHelp
	fi
done
if [[ -z "$1" ]]; then
	echo "$PROG:| Missing folder name, try again :{"
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

		if [[ $2 == "open" ]]
			then
			echo "Opening Backups folder"
			$(open Backups/)
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
	   fi
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




