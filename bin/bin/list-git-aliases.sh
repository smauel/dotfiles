#!/bin/bash

# Set the path to your gitconfig file
GITCONFIG="${HOME}/.gitconfig"

# Define color codes
BOLD='\033[1m'
GRAY='\033[90m'
YELLOW='\033[33m'
RESET='\033[0m'

echo -e "${BOLD}Git Aliases with Comments${RESET}"
echo "--------------------------"

awk -v bold="$BOLD" -v gray="$GRAY" -v yellow="$YELLOW" -v reset="$RESET" '
  BEGIN { in_alias_section = 0 }
  /^\[alias\]/ { in_alias_section = 1; next }
  /^\[/ { in_alias_section = 0 }
  in_alias_section && /^[[:space:]]*[a-zA-Z0-9_.-]+[[:space:]]*=/ {
    line = $0
    sub(/^[[:space:]]*/, "", line)
    split(line, parts, "=")
    alias_name = parts[1]
    rest = substr(line, index(line, "=") + 1)
    gsub(/^[[:space:]]*/, "", rest)

    # Check if there is a comment (#)
    comment_index = index(rest, "#")
    if (comment_index > 0) {
      command = substr(rest, 1, comment_index - 1)
      comment = substr(rest, comment_index)
      gsub(/^[[:space:]]*/, "", command)
      gsub(/^[[:space:]]*/, "", comment)
    } else {
      command = rest
      comment = ""
    }

    printf "%s%s%s → %s%s%s", bold, alias_name, reset, gray, command, reset
    if (comment_index > 0) {
      printf " %s%s%s", yellow, comment, reset
    }
    printf "\n"
  }
' "$GITCONFIG"
