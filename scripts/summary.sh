#!/bin/bash
#
# Prints a summary of folders and databases to backup.
#

function print_summary()
{
	echo -e "\n\e[1mBACKUP SUMMARY:\e[0m\n"

	# Print folders included in the backup.
	for dir in $backup_paths
	do
		# Print the size of the directory to be backed up.
		echo -e "\e[1mData to backup in \e[32m$dir:\e[0m"
		du -sh $dir

		# Also print subdirectories if there are less than 10.
		num_subdirs=`find $dir/* -maxdepth 0 -type d | wc -l`
		if [ $num_subdirs -lt 10 ]; then
			du -sh $dir/*
		fi

		echo -e ""
	done

	# Print excluded folders (if any).
	if [ ! -z "$backup_excludes" ]; then

		echo -e "\e[1mExcluded paths:\e[0m"
		for dir in $backup_excludes
		do
			echo $dir
		done

		echo -e ""
	fi

	# Print MySQL database space usage.
	if [ ! -z "$backup_mysql_pass" ]; then

		echo -e "\e[1mData to backup in \e[32mMySQL databases:\e[0m"

		mysql -u root -p$backup_mysql_pass -e "SELECT table_schema AS 'Database', \
			ROUND(SUM(data_length + index_length) / 1024 / 1024, 2) AS 'Size (MB)' \
			FROM information_schema.TABLES \
			GROUP BY table_schema;"

		echo -e ""
	fi
}

