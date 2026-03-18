#!/bin/bash

DEBUG=0

if (($# == 0)); then
  echo "Usage: launch-or-focus [-d] [window-pattern] [launch-command]"
  exit 1
fi

while getopts "d" arg; do
  case $arg in
  d)
    DEBUG=1
    ;;
  \?)
    echo "Invalid option -$OPTARG" >&2
    exit 1
    ;;
  esac
done

shift $((OPTIND - 1))

WINDOW_PATTERN="$1"
LAUNCH_COMMAND="${2:-"uwsm-app -- $WINDOW_PATTERN"}"
WINDOW_ADDRESS=$(hyprctl clients -j | jq -r --arg p "$WINDOW_PATTERN" '
  ($p | gsub("[^a-zA-Z0-9]";"") | ascii_downcase) as $norm_p |
  .[] | 
  ((.class // "") | gsub("[^a-zA-Z0-9]";"") | ascii_downcase) as $c |
  ((.initialTitle // "") | gsub("[^a-zA-Z0-9]";"") | ascii_downcase) as $t |
  select(
    ($c | contains($norm_p)) or
    ($t | contains($norm_p)) or
    (($norm_p | contains($c)) and $c != "") or
    (($norm_p | contains($t)) and $t != "")
  ) | .address' | head -n1)

if [ $DEBUG -eq 1 ]; then
  echo "$WINDOW_PATTERN"
  echo "$LAUNCH_COMMAND"
  echo "$WINDOW_ADDRESS"
  notify-send "$WINDOW_PATTERN - $WINDOW_ADDRESS"
  exit 0
fi

if [[ -n $WINDOW_ADDRESS ]]; then
  hyprctl dispatch focuswindow "address:$WINDOW_ADDRESS"
else
  eval exec setsid "$LAUNCH_COMMAND"
fi
