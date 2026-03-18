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

create-log() {
  timestamp=$(date +"%Y-%m-%d %H:%M:%S")
  {
    echo "[$timestamp] Pattern: '$WINDOW_PATTERN', Possible Class: '$POSSIBLE_CLASS', Found Address: '$WINDOW_ADDRESS'"
    echo "---------------------------CLASS_INFO------------------------------"
    echo "$CLASS_INFO"
    echo "--------------------------CLIENT_INFO------------------------------"
    echo "$CLIENT_INFO"
    echo "==================================================================="
  } >>"$HOME/.logs/launch-or-focus.log"

}

WINDOW_PATTERN="$1"
LAUNCH_COMMAND="${2:-"uwsm-app -- $WINDOW_PATTERN"}"
CLASS_INFO=$("$HOME/.local/bin/infer-hypr-class" "$WINDOW_PATTERN" 2>/dev/null || true)
POSSIBLE_CLASS=$(printf '%s\n' "$CLASS_INFO" | jq -r '.possible_app_id // empty' 2>/dev/null)

CLIENT_INFO=$(hyprctl clients -j | jq -r --arg p "$WINDOW_PATTERN" --arg pc "$POSSIBLE_CLASS" '
  ($p | gsub("[^a-zA-Z0-9]";"") | ascii_downcase) as $norm_p |
  ($pc | gsub("[^a-zA-Z0-9]";"") | ascii_downcase) as $norm_pc |
  .[] |
  ((.class // "") | gsub("[^a-zA-Z0-9]";"") | ascii_downcase) as $c |
  ((.title // "") | gsub("[^a-zA-Z0-9]";"") | ascii_downcase) as $t |
  select(
    ($c | contains($norm_p)) or
    ($t | contains($norm_p)) or
    (($norm_p | contains($c)) and $c != "") or
    (($norm_p | contains($t)) and $t != "") or
    (($c | contains($norm_pc)) and $norm_pc != "") or
    (($norm_pc | contains($c)) and $c != "")
  )')

WINDOW_ADDRESS=$(printf '%s\n' "$CLIENT_INFO" | jq -r '.address // empty' | head -n1)

create-log

if [ $DEBUG -eq 1 ]; then
  echo "$WINDOW_PATTERN"
  echo "$POSSIBLE_CLASS"
  echo "$WINDOW_ADDRESS"
  notify-send "$WINDOW_PATTERN - $WINDOW_ADDRESS"
  exit 0
fi

if [[ -n $WINDOW_ADDRESS ]]; then
  hyprctl dispatch focuswindow "address:$WINDOW_ADDRESS"
else
  eval exec setsid "$LAUNCH_COMMAND"
fi
