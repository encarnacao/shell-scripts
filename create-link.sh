#!/bin/bash

SCRIPT_PATH="$(realpath "$1")"
LOCAL_BIN_DIR="$HOME/.local/bin"
STRIPED_SCRIPT_NAME="$(basename "$SCRIPT_PATH")"
SCRIPT_NAME_NO_EXT="${STRIPED_SCRIPT_NAME%.*}"
LINK_PATH="$LOCAL_BIN_DIR/$SCRIPT_NAME_NO_EXT"

if [ -L "$LINK_PATH" ] || [ -e "$LINK_PATH" ]; then
    echo "⚠️  A file or link named '$SCRIPT_NAME_NO_EXT' already exists in '$LOCAL_BIN_DIR'."
    echo "Please remove or rename it before running this script."
    exit 1
fi

ln -s "$SCRIPT_PATH" "$LINK_PATH"
chmod +x "$SCRIPT_PATH"

echo "✅ Link created: '$LINK_PATH' -> '$SCRIPT_PATH'"
echo "You can now run '$SCRIPT_NAME_NO_EXT' from anywhere in the terminal."