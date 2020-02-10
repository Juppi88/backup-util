#!/bin/bash
#
# Backup files specified in the paths list, excluding the excludes list.
#

function backup_files()
{
	# Create the backup directory if it doesn't exist.
	create_out_path $1

	echo -e "Backing up files into archive $1/files-latest.tar.gz (user: $2)..."

	local excludes="--exclude=$1"

	for dir in $backup_excludes
	do
		excludes="$excludes --exclude=$dir"
	done

	# Run the archive command.
	tar $excludes -czf "$1/files-latest.tar.gz" $backup_paths

	# Ensure the target user can read the backup files.
	update_permissions $2 $1
}
