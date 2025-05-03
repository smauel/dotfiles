#!/bin/bash

# Define dirs and targets
DIRS=("home" "bin" ".config")
TARGETS=("$HOME" "$HOME" "$HOME/.config")

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[1;34m'
NC='\033[0m' # no color

# Options
DRY_RUN=false
VERBOSE=false
COMMAND="stow"

# Parse arguments
for arg in "$@"; do
    case "$arg" in
        stow|restow|unstow|overwrite)
            COMMAND="$arg"
            ;;
        --dry-run)
            DRY_RUN=true
            ;;
        --verbose)
            VERBOSE=true
            ;;
        --help)
            echo -e "${BLUE}Usage:${NC} $0 [stow|restow|unstow|overwrite] [--dry-run] [--verbose]"
            echo ""
            echo "Commands:"
            echo "  stow        → Stow all directories (default)"
            echo "  restow      → Unstow and then stow all directories"
            echo "  unstow      → Only unstow all directories"
            echo "  overwrite   → Remove matching items from targets, then stow"
            echo ""
            echo "Options:"
            echo "  --dry-run   → Show commands without running them"
            echo "  --verbose   → Print each directory as it’s processed"
            echo "  --help      → Show this help message"
            exit 0
            ;;
        *)
            echo -e "${YELLOW}Unknown argument:${NC} $arg"
            echo "Use --help for usage."
            exit 1
            ;;
    esac
done

# Functions
run_cmd() {
    local cmd=$1
    if $DRY_RUN; then
        echo "[dry-run] $cmd"
    else
        eval "$cmd"
    fi
}

stow_all() {
    echo -e "${GREEN}Stowing...${NC}"
    for i in "${!DIRS[@]}"; do
        $VERBOSE && echo "  → ${DIRS[$i]}"
        run_cmd "stow -t '${TARGETS[$i]}' '${DIRS[$i]}'"
    done
}

unstow_all() {
    echo -e "${YELLOW}Unstowing...${NC}"
    for i in "${!DIRS[@]}"; do
        $VERBOSE && echo "  → ${DIRS[$i]}"
        run_cmd "stow -D -t '${TARGETS[$i]}' '${DIRS[$i]}'"
    done
}

overwrite_all() {
    echo -e "${RED}Checking for existing top-level items...${NC}"
    local conflicts=()

    for i in "${!DIRS[@]}"; do
        for item in "${DIRS[$i]}"/*; do
            [ -e "$item" ] || continue  # skip if nothing matches
            name=$(basename "$item")
            target="${TARGETS[$i]}/$name"
            if [ -e "$target" ] || [ -L "$target" ]; then
                conflicts+=("$target")
            fi
        done
    done

    if [ ${#conflicts[@]} -eq 0 ]; then
        echo "✅ No existing top-level items found."
    else
        echo "⚠️ Existing top-level items to be REMOVED:"
        for c in "${conflicts[@]}"; do
            echo "  $c"
        done

        echo -n "Do you want to REMOVE these files/dirs/symlinks and continue? (y/n): "
        read -r answer
        if [[ "$answer" != "y" ]]; then
            echo "❌ Aborting."
            exit 1
        fi

        for c in "${conflicts[@]}"; do
            run_cmd "rm -rf \"$c\""
        done
    fi

    stow_all
}

# Execute command
case "$COMMAND" in
    stow)
        stow_all
        ;;
    restow)
        unstow_all
        stow_all
        ;;
    unstow)
        unstow_all
        ;;
    overwrite)
        overwrite_all
        ;;
esac
