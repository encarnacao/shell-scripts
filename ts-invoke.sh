#!/bin/bash

ENV_FILE=${1:-".env"}
BUILD_FILE=${2:-"./build/event.js"}

RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
BLUE="\033[0;34m"
MAGENTA="\033[0;35m"
CYAN="\033[0;36m"
WHITE="\033[0;37m"
NO_COLOR="\033[0m"

print_color(){
  COLOR_CODE="$1"
  MESSAGE="$2"
  echo -e "${COLOR_CODE}${MESSAGE}${NO_COLOR}"
}
# If build file does not exists exit 1
if [ ! -f "$BUILD_FILE" ]; then
  print_color "$RED" "Build file '$BUILD_FILE' not found!"
  exit 1
fi

# If file does not exists exit 1
if [ ! -f "$ENV_FILE" ]; then
  print_color "$RED" "Environment file '$ENV_FILE' not found!"
  exit 1
fi

print_color "$GREEN" " Loading environment variables from '$ENV_FILE'..."

dotenv -e "$ENV_FILE" -- node "$BUILD_FILE"