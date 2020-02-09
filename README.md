# Backup Utils

This is a collection of Bash scripts to help with backing up data to a folder on the local system. The backup files should then be copied onto a remote system by using e.g. `scp`.

These scripts should always be run as the root user as they require read access to the folders to be backed up.

## Configuration

The repository contains a sample configuration in _cfg/SAMPLE_. Copy the files in _cfg/SAMPLE_ into _cfg/_ and edit them for your purposes.

__*NOTE:*__ Ensure these configuration files are only readable by the root user (especially if they contain your MySQL root password)!

### Backup files

By editing _cfg/paths.txt_ you can specify which folders you would like to include in the backup. Certain folders can be excluded from the backup by adding them into _cfg/excludes.txt_. File backup can be invoked by running `backup.sh files`.

### Backup databases

By adding your MySQL root username into _cfg/dbpass.txt_ you can create a copy of all the MySQL databases on the system. This is a separate function from file copy and should be invoked by running `backup.sh databases`.

## Sample usage

The recommended way of using the backup util scripts is by automating the calls with cron.

As an example, back up files on the first day of every month and MySQL databases daily (here backup utils is cloned into /root):

```
sudo crontab -e

...

0 4 1 * * /root/backup-util/backup.sh files /tmp/backups myusername
30 4 1 * * /root/backup-util/backup.sh databases /tmp/backups myusername
```
