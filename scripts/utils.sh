#!/bin/bash
#
# Utility functions.
#

function error_msg()
{
	echo -e "\e[91m$1\e[0m"
}

function create_out_path()
{
	mkdir -p "$1/dbs"
}

function update_permissions()
{
	chown -R $1:$1 $2
	chmod 700 $2
}

