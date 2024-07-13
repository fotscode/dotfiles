#!/bin/bash

# make date in RFC 3339 format
DATE=$(date --iso-8601=seconds )

# Define source directories
SRC_DIRS=("$HOME/pictures" "$HOME/documents" "$HOME/videos")

# Define backup directory
BACKUP_DIR=/media/backupfiles/backups

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Function to perform backup using rsync
backup() {
  local SRC_DIR=$1
  local DEST_DIR=$2

  rsync -avh --delete --exclude='.git' --exclude='node_modules' --exclude='*.tmp' "$SRC_DIR" "$DEST_DIR" >> "$BACKUP_DIR/${DATE}_backup.log" 2>&1
}

# Loop through each source directory and perform backup
for SRC_DIR in "${SRC_DIRS[@]}"; do
  # Extract the name of the folder (e.g., "pictures")
  FOLDER_NAME=$(basename "$SRC_DIR")

  # Perform the backup
  backup "$SRC_DIR/" "$BACKUP_DIR/$FOLDER_NAME"
done

echo "Backup completed successfully."
