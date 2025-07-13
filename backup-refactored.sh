#!/usr/bin/env bash
set -euo pipefail

#---------------------------------------------------------------------
# Usage and argument validation
#---------------------------------------------------------------------
if [[ $# -ne 2 ]]; then
  echo "Usage: $0 <source_directory> <destination_directory>" >&2
  exit 1
fi

source_dir=$1
dest_dir=$2

if [[ ! -d "$source_dir" ]]; then
  echo "Error: Source directory '$source_dir' does not exist." >&2
  exit 1
fi

if [[ ! -d "$dest_dir" ]]; then
  echo "Error: Destination directory '$dest_dir' does not exist." >&2
  exit 1
fi

#---------------------------------------------------------------------
# Prepare paths and filenames
#---------------------------------------------------------------------
# Capture absolute paths to avoid surprises when changing directories
origin_path=$(pwd)
dest_path=$(cd "$dest_dir" && pwd)

# Generate a timestamp for our archive name
current_ts=$(date +%s)
backup_file="backup-${current_ts}.tar.gz"

echo "Starting backup of files modified in the last 24h:"
echo "  Source:      $source_dir"
echo "  Destination: $dest_path/$backup_file"
echo

#---------------------------------------------------------------------
# Identify files modified in the last 24 hours
#---------------------------------------------------------------------
# Calculate cutoff timestamp (24 hours ago)
yesterday_ts=$(( current_ts - 24*3600 ))

cd "$source_dir"

# Build an array of files to include in the backup
files_to_backup=()
for item in *; do
  # Skip if not a regular file
  [[ -f "$item" ]] || continue

  # Get modification time in seconds since epoch
  file_mod_ts=$(date -r "$item" +%s)

  # Include if modified within the last day
  if [[ file_mod_ts -gt yesterday_ts ]]; then
    files_to_backup+=("$item")
  fi
done

if [[ ${#files_to_backup[@]} -eq 0 ]]; then
  echo "No files modified in the last 24 hours. Exiting."
  exit 0
fi

#---------------------------------------------------------------------
# Create and move the compressed archive
#---------------------------------------------------------------------
# -c : create archive
# -z : gzip compress
# -f : specify filename
tar -czf "$backup_file" "${files_to_backup[@]}"

# Move the archive to the destination directory
mv "$backup_file" "$dest_path/"

echo
echo "Backup complete: $dest_path/$backup_file"