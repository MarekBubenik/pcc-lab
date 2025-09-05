#!/bin/bash
# Script to archive files with date range in filename

# Define directories
SOURCE_DIR="/var/log/audit/temp_logs"
ARCHIVE_DIR="/var/log/audit/archived_logs"
LOCKFILE="/var/run/audit_archive.lock"

# Logging function
log_message() {
	local level="$1"
	local message="$2"
	local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
	        
	case "$level" in
		"ERROR")
			echo "[$timestamp] ERROR: $message" >&2
			;;
		"WARN")
			echo "[$timestamp] WARNING: $message" >&2
			;;
		"INFO")
			echo "[$timestamp] INFO: $message"
			;;
	esac
}

# Function to cleanup on exit
cleanup() {
	if [[ -f "$LOCKFILE" ]]; then
		rm -f "$LOCKFILE"
		log_message "INFO" "Removed lockfile on exit"
	fi
}

# Set up trap to cleanup on script exit
trap cleanup EXIT

# Error handling function
handle_error() {
	local exit_code=$?
  local line_number=$1
	log_message "ERROR" "Script failed at line $line_number with exit code $exit_code"
	exit $exit_code
}

# Enable error trapping
set -eE
trap 'handle_error $LINENO' ERR

# Start logging
log_message "INFO" "Starting archive process (PID: $$)"

# Check if script is already running (prevent multiple instances)
if [[ -f "$LOCKFILE" ]]; then
	log_message "ERROR" "Archive script is already running (lockfile exists: $LOCKFILE)"
	exit 1
fi

# Create lockfile
if ! echo $$ > "$LOCKFILE"; then
	log_message "ERROR" "Failed to create lockfile: $LOCKFILE"
	exit 1
fi

log_message "INFO" "Created lockfile: $LOCKFILE"


# Check if source directory exists and has files
if [[ ! -d "$SOURCE_DIR" ]]; then
	log_message "ERROR" "Source directory $SOURCE_DIR does not exist"
	exit 1
fi

FILE_COUNT=$(find "$SOURCE_DIR" -type f 2>/dev/null | wc -l)
if [[ $FILE_COUNT -eq 0 ]]; then
	log_message "INFO" "No files found in $SOURCE_DIR to archive"
	exit 0
fi

log_message "INFO" "Found $FILE_COUNT files to archive"


# Create archive directory if it doesn't exist
if [[ ! -d "$ARCHIVE_DIR" ]]; then
	if ! mkdir -p "$ARCHIVE_DIR"; then
		log_message "ERROR" "Failed to create archive directory: $ARCHIVE_DIR"
		exit 1
	fi
		log_message "INFO" "Created archive directory: $ARCHIVE_DIR"
fi

# Find oldest and newest files by modification time
log_message "INFO" "Analyzing file dates..."

if ! OLDEST_FILE=$(find "$SOURCE_DIR" -type f -printf '%T@ %p\n' 2>/dev/null | sort -n | head -n 1 | cut -d' ' -f2-); then
	log_message "ERROR" "Failed to find oldest file"
	exit 1
fi

if ! NEWEST_FILE=$(find "$SOURCE_DIR" -type f -printf '%T@ %p\n' 2>/dev/null | sort -n | tail -n 1 | cut -d' ' -f2-); then
	log_message "ERROR" "Failed to find newest file"
	exit 1
fi

#OLDEST_DATE=$(stat -c %y "$OLDEST_FILE" | cut -d'.' -f1 | tr ' ' 'T')

# Get dates in YYYY-MM-DD format
if ! OLDEST_DATE=$(stat -c %y "$OLDEST_FILE" 2>/dev/null | cut -d'.' -f1 | tr ' ' 'T'); then
	log_message "ERROR" "Failed to get date for oldest file: $OLDEST_FILE"
	exit 1
fi

if ! NEWEST_DATE=$(stat -c %y "$NEWEST_FILE" 2>/dev/null | cut -d'.' -f1 | tr ' ' 'T'); then
	log_message "ERROR" "Failed to get date for newest file: $NEWEST_FILE"
	exit 1
fi

log_message "INFO" "Oldest file: $(basename "$OLDEST_FILE") - $OLDEST_DATE"
log_message "INFO" "Newest file: $(basename "$NEWEST_FILE") - $NEWEST_DATE"

# Create archive filename with date range
if [[ "$OLDEST_DATE" == "$NEWEST_DATE" ]]; then
	ARCHIVE_NAME="audit.log_${OLDEST_DATE}.tar.gz"
	log_message "INFO" "All files from same date: $OLDEST_DATE"
else
	ARCHIVE_NAME="audit.log_${OLDEST_DATE}_to_${NEWEST_DATE}.tar.gz"
	log_message "INFO" "Files span from $OLDEST_DATE to $NEWEST_DATE"
fi

ARCHIVE_PATH="$ARCHIVE_DIR/$ARCHIVE_NAME"

# Check if archive already exists
if [[ -f "$ARCHIVE_PATH" ]]; then
	log_message "WARN" "Archive already exists: $ARCHIVE_PATH"
	TIMESTAMP=$(date +%H%M%S)
	ARCHIVE_NAME="audit.log_${OLDEST_DATE}_to_${NEWEST_DATE}_${TIMESTAMP}.tar.gz"
	ARCHIVE_PATH="$ARCHIVE_DIR/$ARCHIVE_NAME"
	log_message "INFO" "Using timestamped filename: $ARCHIVE_NAME"
fi

# Create compressed archive
log_message "INFO" "Creating archive: $ARCHIVE_NAME"

if cd "$SOURCE_DIR" && tar -czf "$ARCHIVE_PATH" . 2>/dev/null; then
	log_message "INFO" "Successfully created archive: $ARCHIVE_PATH"
						    
	# Display archive info
	if ARCHIVE_SIZE=$(du -h "$ARCHIVE_PATH" 2>/dev/null | cut -f1); then
		log_message "INFO" "Archive size: $ARCHIVE_SIZE"
	else
	        log_message "WARN" "Could not determine archive size"
	fi
												    
	log_message "INFO" "Removing source files..."
	if find "$SOURCE_DIR" -type f -delete 2>/dev/null; then
		log_message "INFO" "Successfully removed source files"
	else
		log_message "ERROR" "Failed to remove some source files"
		exit 1
	fi

else
	log_message "ERROR" "Failed to create archive: $ARCHIVE_PATH"
	exit 1
	
fi

log_message "INFO" "Archive process completed successfully"


