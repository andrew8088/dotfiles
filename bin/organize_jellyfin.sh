#!/bin/bash

# Generalized Jellyfin Media Organizer Script
# Automatically detects shows and organizes them into Jellyfin-compatible folder structure
# Format: "Show Name (YEAR)/Season #/Show Name - S##E##.mp4"

# Parse command line arguments
DRY_RUN=false
YEAR=2024

while [[ $# -gt 0 ]]; do
    case $1 in
        --dry-run|-d)
            DRY_RUN=true
            shift
            ;;
        --year|-y)
            YEAR="$2"
            shift 2
            ;;
        [0-9]*)
            YEAR="$1"
            shift
            ;;
        --help|-h)
            echo "Usage: $0 [OPTIONS] [YEAR]"
            echo ""
            echo "OPTIONS:"
            echo "  --dry-run, -d     Show what would be moved without actually moving files"
            echo "  --year YEAR, -y   Specify the year (default: 2024)"
            echo "  --help, -h        Show this help message"
            echo ""
            echo "Examples:"
            echo "  $0                # Organize files for 2024"
            echo "  $0 2023           # Organize files for 2023"
            echo "  $0 --dry-run      # Preview moves without executing"
            echo "  $0 -d -y 2023     # Preview moves for 2023"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            echo "Use --help for usage information"
            exit 1
            ;;
    esac
done

if [ "$DRY_RUN" = true ]; then
    echo "DRY RUN MODE - No files will be moved"
    echo "Preview of what would be organized for Jellyfin (Year: $YEAR)..."
else
    echo "Organizing media files for Jellyfin (Year: $YEAR)..."
fi
echo "======================================================="

# Find all .mp4 files with S##E## pattern
for file in *.mp4; do
    # Skip if no matching files
    [ ! -f "$file" ] && continue
    
    # Extract show name, season, and episode using regex
    if [[ "$file" =~ ^(.+)\ S([0-9]+)E([0-9]+)\.mp4$ ]]; then
        show_name="${BASH_REMATCH[1]}"
        season_num="${BASH_REMATCH[2]}"
        episode_num="${BASH_REMATCH[3]}"
        
        # Format season and episode with leading zeros
        season_formatted=$(printf "%02d" $((10#$season_num)))
        episode_formatted=$(printf "%02d" $((10#$episode_num)))
        
        # Create directory structure and move file
        show_dir="${show_name} (${YEAR})"
        season_dir="${show_dir}/Season ${season_num}"
        new_filename="${show_name} S${season_formatted}E${episode_formatted}.mp4"
        
        if [ "$DRY_RUN" = true ]; then
            echo "📁 Would create: $season_dir/"
            echo "📄 Would move: $file"
            echo "   -> $season_dir/$new_filename"
        else
            mkdir -p "$season_dir"
            mv "$file" "$season_dir/$new_filename"
            echo "✓ Moved: $file"
            echo "   -> $season_dir/$new_filename"
        fi
        echo ""
    else
        echo "⚠ Skipped: $file (doesn't match S##E## pattern)"
    fi
done

echo "======================================================="
if [ "$DRY_RUN" = true ]; then
    echo "Dry run complete! No files were actually moved."
else
    echo "Organization complete!"
fi
echo ""

if [ "$DRY_RUN" = true ]; then
    echo "Directories that would be created:"
else
    echo "Created folder structure:"
fi
# List the directories (existing ones or planned ones)
if [ "$DRY_RUN" = true ]; then
    # In dry run mode, show what would be created
    for file in *.mp4; do
        [ ! -f "$file" ] && continue
        if [[ "$file" =~ ^(.+)\ S([0-9]+)E([0-9]+)\.mp4$ ]]; then
            show_name="${BASH_REMATCH[1]}"
            season_num="${BASH_REMATCH[2]}"
            show_dir="${show_name} (${YEAR})"
            season_dir="${show_dir}/Season ${season_num}"
            echo "├── $season_dir/"
        fi
    done | sort -u
else
    # Show actual created directories
    find . -name "Season *" -type d | sort | while read dir; do
        show_folder=$(dirname "$dir")
        season_folder=$(basename "$dir")
        file_count=$(ls "$dir"/*.mp4 2>/dev/null | wc -l)
        echo "├── ${show_folder#./}/$season_folder/ ($file_count episodes)"
    done
fi

echo ""
echo "Usage notes:"
echo "- Default year is $YEAR"
echo "- Files must follow pattern: 'Show Name S##E##.mp4'"
echo "- Supports multiple seasons automatically"
echo "- Episode and season numbers will be zero-padded (S01E01)"
echo ""
echo "Command examples:"
echo "  $0                # Organize files for $YEAR"
echo "  $0 2023           # Organize files for 2023"
echo "  $0 --dry-run      # Preview moves without executing"
echo "  $0 -d -y 2023     # Preview moves for 2023"
