#!/bin/bash
# Script to check for .19 files in /var/log/audit/ and move them to temp_logs/

# Define directories
AUDIT_DIR="/var/log/audit"
TEMP_DIR="/var/log/audit/temp_logs"
LOCKFILE="/var/run/audit_processor.lock"

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
log_message "INFO" "Starting audit log processor (PID: $$)"

# Check if script is already running (prevent multiple instances)

if [[ -f "$LOCKFILE" ]]; then
  log_message "ERROR" "Audit processor is already running (lockfile exists: $LOCKFILE)"
  exit 1
fi

# Create lockfile
if ! echo $$ > "$LOCKFILE"; then
  log_message "ERROR" "Failed to create lockfile: $LOCKFILE"
  exit 1
fi

log_message "INFO" "Created lockfile: $LOCKFILE"


# Check if audit directory exists
if [[ ! -d "$AUDIT_DIR" ]]; then
  log_message "ERROR" "Audit directory $AUDIT_DIR does not exist"
  exit 1
fi

log_message "INFO" "Checking for .19 files in $AUDIT_DIR"

# Check if a file ending with .19 exists in the audit directory
if ! NINETEEN_FILE=$(find "$AUDIT_DIR" -maxdepth 1 -name "*.19" -type f 2>/dev/null | head -n 1); then
  log_message "ERROR" "Failed to search for .19 files in $AUDIT_DIR"
  exit 1
fi


if [[ -z "$NINETEEN_FILE" ]]; then
  log_message "INFO" "No file ending with .19 found in $AUDIT_DIR"
  exit 0
fi


log_message "INFO" "Found .19 file: $(basename "$NINETEEN_FILE")"


# Verify the file is readable
if [[ ! -r "$NINETEEN_FILE" ]]; then
  log_message "ERROR" "File $NINETEEN_FILE is not readable"
  exit 1
fi


# Get file size for logging
if FILE_SIZE=$(du -h "$NINETEEN_FILE" 2>/dev/null | cut -f1); then
  log_message "INFO" "File size: $FILE_SIZE"
else
  log_message "WARN" "Could not determine file size"
fi


# Create temp_old_logs directory if it doesn't exist
if [[ ! -d "$TEMP_DIR" ]]; then
  if ! mkdir -p "$TEMP_DIR"; then
    log_message "ERROR" "Failed to create directory: $TEMP_DIR"
    exit 1
  fi
  log_message "INFO" "Created directory: $TEMP_DIR"
else
  log_message "INFO" "Using existing directory: $TEMP_DIR"
fi

# Verify temp directory is writable
if [[ ! -w "$TEMP_DIR" ]]; then
  log_message "ERROR" "Directory $TEMP_DIR is not writable"
  exit 1
fi

# Get current ISO date (YYYY-MM-DD format)
ISO_DATE=$(date +"%Y-%m-%dT%H:%M:%S")
  log_message "INFO" "Using ISO date: $ISO_DATE"

# Define the new filename
NEW_FILENAME="audit.log.19_$ISO_DATE"
DESTINATION="$TEMP_DIR/$NEW_FILENAME"

# Check if destination file already exists - create timestamped file
if [[ -f "$DESTINATION" ]]; then
  log_message "WARN" "Destination file already exists: $DESTINATION"
  # Add timestamp to make it unique
  TIMESTAMP=$(date +%H%M%S)
  NEW_FILENAME="audit.log_${ISO_DATE}_${TIMESTAMP}"
  DESTINATION="$TEMP_DIR/$NEW_FILENAME"
  log_message "INFO" "Using timestamped filename: $NEW_FILENAME"
fi

# Log the move operation
log_message "INFO" "Moving $(basename "$NINETEEN_FILE") to $NEW_FILENAME"


# Move the file
if mv "$NINETEEN_FILE" "$DESTINATION"; then
  log_message "INFO" "Successfully moved file to: $DESTINATION"
  
  # Verify the move was successful
  if [[ -f "$DESTINATION" ]] && [[ ! -f "$NINETEEN_FILE" ]]; then
  
    # Get final file size
    if FINAL_SIZE=$(du -h "$DESTINATION" 2>/dev/null | cut -f1); then
      log_message "INFO" "Final file size: $FINAL_SIZE"
    fi

    log_message "INFO" "File move operation completed successfully"
  else
    log_message "ERROR" "File move verification failed"
    exit 1
    
  fi
  
else
  log_message "ERROR" "Failed to move file from $NINETEEN_FILE to $DESTINATION"
  exit 1
fi

log_message "INFO" "Audit log processor completed successfully"

