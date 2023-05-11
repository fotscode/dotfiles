#!/bin/bash
# backup pictures, documents, and videos to a external drive mounted at /mnt/backupfiles

# set the date
DATE=$(date +%Y-%m-%d)

# set the backup directory
BACKUPDIR=/media/backupfiles

# set the source directory
SOURCEDIR="pictures/ documents/ videos/"

# set the backup file name
BACKUPFILE=$BACKUPDIR/$DATE-backup.tar.gz

# set the log file
LOGFILE=$BACKUPDIR/$DATE-backup.log

# create the backup
tar -cvpzf "$BACKUPFILE" -C "$HOME" $SOURCEDIR 2> "$LOGFILE"
