#!/bin/bash
#
# Reads configuration files (paths, excludes, database passwords)
# into environment variables.
#

export backup_paths=""
export backup_excludes=""
export backup_mysql_pass=""

function read_cfg()
{
	local paths_file="cfg/paths.txt"
	local excludes_file="cfg/excludes.txt"
	local mysqlpass_file="cfg/dbpass.txt"

	# Read a list of paths to backup.
	if [ -f $paths_file ]; then
		while read -r line
		do
			export backup_paths="$backup_paths $line"
		done < $paths_file
	else
		error_msg "$paths_file does not exist!"
	fi

	# Read a list of files/paths to exclude.
	if [ -f $excludes_file ]; then
		while read -r line
		do
			export backup_excludes="$backup_excludes $line"
		done < $excludes_file
	else
		error_msg "$excludes_file does not exist!"
	fi

	# Read MySQL admin password.
	if [ -f $mysqlpass_file ]; then
		while read -r line
		do
			export backup_mysql_pass="$line"
			break
		done < $mysqlpass_file
	fi
}
