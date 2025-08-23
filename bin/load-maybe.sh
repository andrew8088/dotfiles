#!/bin/bash

# PostgreSQL dump restore script
# Usage: ./restore_dump.sh YYYY-MM-DD.sql.gz

set -e  # Exit on any error

# Check if filename provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <dump_file.sql.gz>"
    echo "Example: $0 2024-10-15.sql.gz"
    exit 1
fi

DUMP_FILE="$1"

# Validate file exists
if [ ! -f "$DUMP_FILE" ]; then
    echo "Error: File '$DUMP_FILE' not found"
    exit 1
fi

# Extract date from filename (assuming YYYY-MM-DD.sql.gz format)
BASENAME=$(basename "$DUMP_FILE" .sql.gz)
DATE_PART="$BASENAME"

# Validate date format
if [[ ! "$DATE_PART" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
    echo "Error: Filename must be in YYYY-MM-DD.sql.gz format"
    exit 1
fi

# Create database name
DB_NAME="maybe_data_${DATE_PART//-/_}"

echo "Restoring $DUMP_FILE to database: $DB_NAME"

# Drop database if it exists (optional - comment out if you want to keep existing)
echo "Dropping existing database if it exists..."
dropdb --if-exists "$DB_NAME"

# Create the database
echo "Creating database: $DB_NAME"
createdb "$DB_NAME"

# Restore the dump
echo "Restoring dump..."
gunzip -c "$DUMP_FILE" | psql -d "$DB_NAME" -v ON_ERROR_STOP=1

echo "Restore completed successfully!"
echo "Database: $DB_NAME"

# Optional: Show some basic info about the restored database
echo -e "\nDatabase info:"
psql -d "$DB_NAME" -c "\dt" -c "SELECT count(*) as total_tables FROM information_schema.tables WHERE table_schema = 'public';"
