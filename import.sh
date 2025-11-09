#!/bin/bash

# import.sh - Import utility to safely copy local files into the repo
# Usage: ./import.sh <path_to_local_file> <path_to_repo_file>

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_color() {
    local color=$1
    shift
    echo -e "${color}$@${NC}"
}

# Function to print usage
usage() {
    echo "Usage: $0 <path_to_local_file> [path_to_repo_file]"
    echo ""
    echo "If path_to_repo_file is omitted, defaults to dotfiles/<basename>"
    echo ""
    echo "Examples:"
    echo "  $0 ~/.zshrc                    # defaults to dotfiles/.zshrc"
    echo "  $0 ~/CLAUDE.md                 # defaults to dotfiles/CLAUDE.md"
    echo "  $0 ~/.zshrc dotfiles/.zshrc    # explicit path"
    exit 1
}

# Check arguments
if [ $# -lt 1 ] || [ $# -gt 2 ]; then
    print_color "$RED" "Error: Wrong number of arguments"
    usage
fi

LOCAL_FILE="$1"

# Default to dotfiles/<basename> if second arg not provided
if [ $# -eq 2 ]; then
    REPO_FILE="$2"
else
    BASENAME=$(basename "$LOCAL_FILE")
    REPO_FILE="dotfiles/$BASENAME"
    print_color "$BLUE" "→ Defaulting to repo file: $REPO_FILE"
    echo ""
fi

# Validate local file exists
if [ ! -f "$LOCAL_FILE" ]; then
    print_color "$RED" "Error: Local file does not exist: $LOCAL_FILE"
    exit 1
fi

# Check if repo file exists
REPO_FILE_EXISTS=true
if [ ! -f "$REPO_FILE" ]; then
    REPO_FILE_EXISTS=false
fi

# Get absolute path for repo file (or create directory if needed)
if [ "$REPO_FILE_EXISTS" = true ]; then
    REPO_FILE_ABS=$(cd "$(dirname "$REPO_FILE")" && pwd)/$(basename "$REPO_FILE")
else
    # Get absolute path even if file doesn't exist yet
    REPO_DIR=$(dirname "$REPO_FILE")
    if [ ! -d "$REPO_DIR" ]; then
        print_color "$RED" "Error: Repo directory does not exist: $REPO_DIR"
        exit 1
    fi
    REPO_FILE_ABS=$(cd "$REPO_DIR" && pwd)/$(basename "$REPO_FILE")
fi

print_color "$BLUE" "═══════════════════════════════════════════════════════════════"
print_color "$BLUE" "Import Utility"
print_color "$BLUE" "═══════════════════════════════════════════════════════════════"
echo ""
echo "Local file:  $LOCAL_FILE"
echo "Repo file:   $REPO_FILE"

if [ "$REPO_FILE_EXISTS" = false ]; then
    print_color "$YELLOW" "Note: Repo file does not exist yet (will be created)"
fi

echo ""

# If repo file doesn't exist, this is a new file import
if [ "$REPO_FILE_EXISTS" = false ]; then
    print_color "$BLUE" "─────────────────────────────────────────────────────────────"
    print_color "$BLUE" "Preview (new file):"
    print_color "$BLUE" "─────────────────────────────────────────────────────────────"
    echo ""
    head -n 20 "$LOCAL_FILE"

    LINE_COUNT=$(wc -l < "$LOCAL_FILE")
    if [ "$LINE_COUNT" -gt 20 ]; then
        echo ""
        print_color "$BLUE" "... ($((LINE_COUNT - 20)) more lines)"
    fi
    echo ""

    print_color "$BLUE" "─────────────────────────────────────────────────────────────"
    print_color "$BLUE" "Analysis:"
    print_color "$BLUE" "─────────────────────────────────────────────────────────────"
    echo ""
    echo "Total lines: $LINE_COUNT"
    echo ""
    print_color "$GREEN" "✓ Status: NEW FILE"
    echo "  This will create a new file in the repository."
    echo ""
    print_color "$BLUE" "─────────────────────────────────────────────────────────────"
else
    # Check if files are identical
    if diff -q "$REPO_FILE" "$LOCAL_FILE" > /dev/null 2>&1; then
        print_color "$GREEN" "✓ Files are identical. No import needed."
        exit 0
    fi

    # Show the diff
    print_color "$BLUE" "─────────────────────────────────────────────────────────────"
    print_color "$BLUE" "Diff (repo file → local file):"
    print_color "$BLUE" "─────────────────────────────────────────────────────────────"
    echo ""

    # Generate unified diff
    DIFF_OUTPUT=$(diff -u "$REPO_FILE" "$LOCAL_FILE" || true)
    echo "$DIFF_OUTPUT"
    echo ""

    # Analyze the diff
    # Count additions (lines starting with + but not +++)
    ADDITIONS=$(echo "$DIFF_OUTPUT" | grep -c "^+[^+]" || true)
    # Count deletions (lines starting with - but not ---)
    DELETIONS=$(echo "$DIFF_OUTPUT" | grep -c "^-[^-]" || true)

    print_color "$BLUE" "─────────────────────────────────────────────────────────────"
    print_color "$BLUE" "Analysis:"
    print_color "$BLUE" "─────────────────────────────────────────────────────────────"
    echo ""
    echo "Additions: $ADDITIONS line(s)"
    echo "Deletions: $DELETIONS line(s)"
    echo ""

    # Provide recommendation
    if [ "$ADDITIONS" -gt 0 ] && [ "$DELETIONS" -eq 0 ]; then
        print_color "$GREEN" "✓ Status: ONLY ADDITIONS"
        echo "  This is safe to import. The local file only adds new content."
    elif [ "$DELETIONS" -gt 0 ] && [ "$ADDITIONS" -eq 0 ]; then
        print_color "$YELLOW" "⚠ Status: ONLY DELETIONS"
        echo "  Safe to import if these deletions are intentional."
    else
        print_color "$YELLOW" "⚠ Status: MIXED CHANGES"
        echo "  The local file has both additions and deletions."
        echo "  Recommend carefully reviewing the diff before importing."
    fi

    echo ""
    print_color "$BLUE" "─────────────────────────────────────────────────────────────"
fi

# Prompt user
while true; do
    read -p "Do you want to import the local file into the repo? [import/abort]: " response
    case "$response" in
        import|i|yes|y)
            cp "$LOCAL_FILE" "$REPO_FILE_ABS"
            print_color "$GREEN" "✓ Successfully imported $LOCAL_FILE to $REPO_FILE"
            exit 0
            ;;
        abort|a|no|n)
            print_color "$YELLOW" "Import aborted."
            exit 0
            ;;
        *)
            print_color "$RED" "Please type 'import' or 'abort'"
            ;;
    esac
done
