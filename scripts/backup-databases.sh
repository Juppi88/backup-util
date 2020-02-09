#!/bin/bash
#
# Backs up all MySQL databases on the local system.
#

function backup_databases()
{
	# Create the backup directory if it doesn't exist.
	create_out_path $1

	echo -e "Backing up MySQL databases into archive $1/dbs-latest.sql.gz (user: $2)..."

	folder=$(date +%a)
	suffix=$(date +%d.%m.%Y-%H.%M)

	mkdir -p "$1/dbs/$folder"

	rm -f $1/dbs/$folder/*.sql.gz

	mysqldump --all-databases -h localhost -u root -p$backup_mysql_pass | gzip > "$1/dbs/$folder/dbs-$suffix.sql.gz"
	cp "$1/dbs/$folder/dbs-$suffix.sql.gz" "$1/dbs-latest.sql.gz"

	# Ensure the target user can read the backup files.
	update_permissions $2 $1
}
