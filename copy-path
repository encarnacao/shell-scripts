
#!/bin/bash

TARGET="$1"

RED="\033[0;31m"
GREEN="\033[0;32m"
BLUE="\033[0;34m"
RESET="\033[0m"

if [[ -z "$TARGET" ]]; then
  echo -e "${RED}❌ No path provided${RESET}"
  exit 1
fi

if [[ ! -e "$TARGET" ]]; then
  echo -e "${RED}❌ File or folder not found:${RESET} $TARGET"
  exit 1
fi

realpath "$TARGET" | wl-copy

echo -e "${GREEN} Copied to clipboard:${RESET} ${BLUE}$(realpath "$TARGET")${RESET}"

