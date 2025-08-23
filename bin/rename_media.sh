#!/bin/bash

# Global variable for dry run mode
DRY_RUN=false

# Function to convert filename format
rename_file() {
    local filename="$1"
    
    # Check if file exists
    if [[ ! -f "$filename" ]]; then
        echo "Error: File '$filename' not found"
        return 1
    fi
    
    # Extract base name and extension
    basename="${filename%.*}"
    extension="${filename##*.}"
    
    # Extract the number at the end
    if [[ $basename =~ ^(.+)-([0-9]+)$ ]]; then
        title_part="${BASH_REMATCH[1]}"
        number="${BASH_REMATCH[2]}"
        
        # Convert title: replace hyphens with spaces and apply title case
        formatted_title=$(echo "$title_part" | sed 's/-/ /g' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) tolower(substr($i,2)); print}')
        
        # Format the episode number with leading zero if needed
        formatted_number=$(printf "%02d" "$number")
        
        # Create new filename
        new_filename="${formatted_title} S01E${formatted_number}.${extension}"
        
        # Rename the file (or show what would be renamed in dry run mode)
        if [[ "$DRY_RUN" == "true" ]]; then
            echo "[DRY RUN] Would rename: '$filename' → '$new_filename'"
        else
            if mv "$filename" "$new_filename"; then
                echo "Renamed: '$filename' → '$new_filename'"
            else
                echo "Error: Failed to rename '$filename'"
                return 1
            fi
        fi
    else
        echo "Error: '$filename' doesn't match expected format (name-number.extension)"
        return 1
    fi
}

# Main script logic

# Parse command line options
while [[ $# -gt 0 ]]; do
    case $1 in
        -n|--dry-run)
            DRY_RUN=true
            shift
            ;;
        -h|--help)
            echo "Usage: $0 [-n|--dry-run] [-h|--help] <filename1> [filename2] [filename3] ..."
            echo ""
            echo "Options:"
            echo "  -n, --dry-run    Show what would be renamed without actually renaming files"
            echo "  -h, --help       Show this help message"
            echo ""
            echo "Examples:"
            echo "  $0 ancient-philosophy-1.mp4"
            echo "  $0 --dry-run *.mp4"
            echo "  $0 -n ancient-philosophy-1.mp4 modern-ethics-2.mp4"
            exit 0
            ;;
        -*)
            echo "Unknown option: $1"
            exit 1
            ;;
        *)
            break
            ;;
    esac
done

if [[ $# -eq 0 ]]; then
    echo "Usage: $0 [-n|--dry-run] [-h|--help] <filename1> [filename2] [filename3] ..."
    echo "Use -h or --help for more information"
    exit 1
fi

# Process each file argument
for file in "$@"; do
    rename_file "$file"
done
