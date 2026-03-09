#!/bin/bash

RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW=$'\033[0;33m'
RESET="\033[0m"

if [[ -z "$1" ]]; then
    echo "Usage: $(basename "$0") <path-to-script>"
    echo "Example: $(basename "$0") /home/user/scripts/myscript.sh"
    exit 0
fi

if [[ ! -f "$1" ]]; then
    echo -e "${RED}Error: File '$1' does not exist.${RESET}"
    exit 1
fi

SCRIPT_PATH="$(realpath "$1")"
LOCAL_BIN_DIR="$HOME/.local/bin"
STRIPED_SCRIPT_NAME="$(basename "$SCRIPT_PATH")"
SCRIPT_NAME_NO_EXT="${STRIPED_SCRIPT_NAME%.*}"
LINK_PATH="$LOCAL_BIN_DIR/$SCRIPT_NAME_NO_EXT"

if [[ ! -d "$LOCAL_BIN_DIR" ]]; then
    echo -e "${YELLOW}Directory '$LOCAL_BIN_DIR' does not exist. Creating it...${RESET}"
    mkdir -p "$LOCAL_BIN_DIR"
fi

if [ -L "$LINK_PATH" ] || [ -e "$LINK_PATH" ]; then
    echo -e "${YELLOW}⚠️  A file or link named '$SCRIPT_NAME_NO_EXT' already exists in '$LOCAL_BIN_DIR'.${RESET}"
    echo "Please remove or rename it before running this script."
    exit 1
fi

ln -s "$SCRIPT_PATH" "$LINK_PATH"
chmod +x "$SCRIPT_PATH"

echo -e "${GREEN}✅ Link created: '$LINK_PATH' -> '$SCRIPT_PATH'"
echo -e "${GREEN}You can now run '$SCRIPT_NAME_NO_EXT' from anywhere in the terminal.${RESET}"