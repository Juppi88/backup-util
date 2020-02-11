#!/bin/bash

function print_usage()
{
	echo -e "\nUsage: $0 <files/databases/summary> [options]\n"
	echo -e "    files <outpath> <user>         Backup folders specified in cfg/paths.txt (ecluding cfg/excludes.txt)"
	echo -e "    databases <outpath> <outuser>  Backup all MySQL databases"
	echo -e "    summary                        Print a summary of files/databases to backup"
	echo -e ""
}

if [ $# -eq 0 ]; then
	print_usage
	exit 0
fi

# Set working directory to the location of this script.
cd "$(dirname "$0")";

source scripts/read-cfg.sh
source scripts/backup-files.sh
source scripts/backup-databases.sh
source scripts/summary.sh
source scripts/utils.sh

# Parse config files into environment variables.
read_cfg

if [[ "$1" = "files" && $# -ge 3 ]]; then
	backup_files $2 $3
elif [[ "$1" = "databases" && $# -ge 3 ]]; then
	backup_databases $2 $3
elif [ "$1" = "summary" ]; then
	print_summary
else
	print_usage
fi
