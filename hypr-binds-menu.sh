#!/bin/bash

set -euo pipefail

chosen="$(
  hyprctl binds -j | jq -r '
    def mods($m):
      [
        if (($m / 64 | floor) % 2) != 0 then "SUPER" else empty end,
        if (($m / 8  | floor) % 2) != 0 then "ALT"   else empty end,
        if (($m / 4  | floor) % 2) != 0 then "CTRL"  else empty end,
        if ($m % 2)                != 0 then "SHIFT" else empty end
      ] | join("+");

    .[]
    | select(.mouse == false)
    | {
        combo:
          (
            (mods(.modmask))
            + (if (mods(.modmask) != "" and ((.key // "") != "" or (.keycode // 0) != 0)) then "+" else "" end)
            + (if (.key // "") != "" then .key else ("code:" + ((.keycode // 0) | tostring)) end)
          ),
        submap: (if (.submap // "") == "" then "default" else .submap end),
        desc: (if (.has_description // false) then (.description // "") else "" end),
        action: ((.dispatcher // "") + (if (.arg // "") != "" then " " + .arg else "" end))
      }
    | "\(.combo)\t[\(.submap)]\t" + (if .desc != "" then .desc else .action end)
  ' | sort -u | rofi -dmenu -i -p "Hypr binds"
)"

[ -z "${chosen:-}" ] && exit 0

printf '%s\n' "$chosen" | wl-copy
notify-send "Hyprland binds" "Copied selected line to clipboard"
