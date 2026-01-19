#!/bin/bash

ENV_FILE=${1:-".env"}

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

if [ ! -f "$ENV_FILE" ]; then
  print_color "$RED" "Environment file '$ENV_FILE' not found!"
  exit 1
fi

print_color "$GREEN" " Loading environment variables from '$ENV_FILE'..."

dotenv -e "$ENV_FILE" -- node -e "console.log(process.env)"

if [ $? -ne 0 ]; then
  print_color "$RED" " Failed to load environment variables from '$ENV_FILE'."
  exit 1
fi