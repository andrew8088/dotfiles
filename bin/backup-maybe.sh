#!/bin/bash

# PostgreSQL Backup Script for Maybe App

set -euo pipefail  # Exit on error, undefined vars, pipe failures

# Configuration
DB_HOST="127.0.0.1"
DB_PORT="5433"
DB_NAME="maybe_production"
DB_USER="maybe_user"
BACKUP_DIR="$HOME/backups/maybe"
DATE="$(date +%Y-%m-%d)"
BACKUP_FILE="$BACKUP_DIR/$DATE.sql.gz"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Functions
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Check if backup already exists for today
if [[ -f "$BACKUP_FILE" ]]; then
    log_warn "Backup for $DATE already exists: $BACKUP_FILE"
    read -p "Overwrite? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        log_info "Backup cancelled"
        exit 0
    fi
fi

# Check if we can reach the Tailscale host
log_info "Checking connectivity to $DB_HOST..."
if ! ping -c 1 "$DB_HOST" &> /dev/null; then
    log_error "Cannot reach $DB_HOST"
    exit 1
fi

export PGPASSWORD="$MAYBE_DB_PASSWORD"

log_info "Starting backup of $DB_NAME from $DB_HOST..."
log_info "Backup will be saved to: $BACKUP_FILE"

# Perform the backup
if pg_dump \
    --host="$DB_HOST" \
    --port="$DB_PORT" \
    --username="$DB_USER" \
    --dbname="$DB_NAME" \
    --verbose \
    --no-password \
    --format=plain \
    --no-owner \
    --no-privileges | gzip > "$BACKUP_FILE"; then
    
    # Get file size for confirmation
    BACKUP_SIZE=$(du -h "$BACKUP_FILE" | cut -f1)
    log_info "Backup completed successfully!"
    log_info "File: $BACKUP_FILE"
    log_info "Size: $BACKUP_SIZE"
    
    # Test that the backup file is valid
    if gzip -t "$BACKUP_FILE"; then
        log_info "Backup file integrity verified"
    else
        log_error "Backup file appears to be corrupted!"
        exit 1
    fi
else
    log_error "Backup failed!"
    exit 1
fi

# Clean up old backups (keep last 30 days)
# log_info "Cleaning up old backups (keeping last 30 days)..."
# find "$BACKUP_DIR" -name "*.sql.gz" -type f -mtime +30 -delete
# OLD_COUNT=$(find "$BACKUP_DIR" -name "*.sql.gz" -type f | wc -l)
# log_info "Backup cleanup complete. Total backups: $OLD_COUNT"

# Unset password
unset PGPASSWORD

log_info "Backup process finished successfully!"
