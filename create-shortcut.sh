#!/bin/bash

DESCRIPTION='Wine-powered game'
VERBOSE=0

# Color Codes
RED=$'\033[0;31m'
GREEN=$'\033[0;32m'
YELLOW=$'\033[0;33m'
BLUE=$'\033[0;34m'
MAGENTA=$'\033[0;35m'
CYAN=$'\033[0;36m'
WHITE=$'\033[0;37m'
NO_COLOR=$'\033[0m'

print_color(){
  COLOR_CODE="$1"
  MESSAGE="$2"
  echo -e "${COLOR_CODE}${MESSAGE}${NO_COLOR}"
}

slugify() {
  local s="$1"
  s=${s,,}          # lowercase
  s=${s// /-}       # spaces → dashes
  echo "$s"
}

print_usage() {
  cat <<EOF
${BLUE}Usage:${NO_COLOR} create-game-shortcut [options] <name> <path> <icon>

Parameters:
  name    Game name
  path    Executable path
  icon    Icon path

Options:
  -d        Game DESCRIPTION
  -v        Verbose mode

Example:
  create-game-shortcut -v -d foobar foo bar baz
EOF
}

# Flags available -> d: denotes that d has accepts an argument
while getopts 'd:vh' arg; do
  case $arg in
    d) 
      DESCRIPTION=$OPTARG 
      ;;
    v) 
      VERBOSE=1 
      ;;
    h)
      print_usage
      exit 0
      ;;
    \?) 
      print_usage
      exit 1 
      ;;
  esac
done

# Makes sure you access correct arguments shifting the positional parameters.
shift $((OPTIND - 1))

EXECUTABLE_NAME=$1
EXECUTABLE_PATH=$2
ICON_PATH=${3:-"wine"}
APP_SLUG=$(slugify "$EXECUTABLE_NAME")

if [ $VERBOSE -eq 1 ]; then
  echo "Verbose Mode Information:"
  echo "EXECUTABLE NAME = ${BLUE}$EXECUTABLE_NAME${NO_COLOR}"
  echo "EXECUTABLE PATH = ${BLUE}$EXECUTABLE_PATH${NO_COLOR}"
  echo "ICON PATH = ${BLUE}$ICON_PATH${NO_COLOR}"
  echo "APP_SLUG = ${YELLOW}$APP_SLUG${NO_COLOR}"
  echo "DESCRIPTION = ${YELLOW}$DESCRIPTION${NO_COLOR}"
fi

if [[ -z $EXECUTABLE_NAME || -z $EXECUTABLE_PATH || -z $ICON_PATH ]]; then
  print_color "$RED" "Required parameters not sent"
  print_usage
  exit 1
fi

if [ ! -f $EXECUTABLE_PATH ]; then
  print_color "$RED" "Executable file $EXECUTABLE_PATH not found"
fi

if [ ! -f $ICON_PATH ]; then
  print_color "$RED" "Icon file $ICON_PATH not found"
fi

desktopTemplateFile="${HOME}/Templates/application.desktop"
desktopTargetFile="${HOME}/.local/share/applications/${APP_SLUG}.desktop"

cp "$desktopTemplateFile" "$desktopTargetFile"

sed -i "s|EXECUTABLE-NAME|${EXECUTABLE_NAME}|g" "$desktopTargetFile"
sed -i "s|EXECUTABLE-DESCRIPTION|${DESCRIPTION}|g" "$desktopTargetFile"
sed -i "s|EXECUTABLE-PATH|${EXECUTABLE_PATH}|g" "$desktopTargetFile"
sed -i "s|ICON-PATH|${ICON_PATH}|g" "$desktopTargetFile"

print_color "$GREEN" "Shortcut Created"

