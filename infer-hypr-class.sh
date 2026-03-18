#!/usr/bin/env bash

set -uo pipefail

usage() {
  cat <<'EOF'
Usage:
  infer-hypr-class <command-or-path>

Examples:
  infer-hypr-class 64gram-desktop
  infer-hypr-class /usr/bin/64gram-desktop
  infer-hypr-class ghostty

What it checks, in order:
  1. Matching .desktop file by Exec=
  2. StartupWMClass= from that .desktop file
  3. Desktop filename (without .desktop) as a possible app id
  4. Executable basename

Notes:
  - This is heuristic only.
  - The only authoritative value is the one reported by a real window at runtime.
EOF
}

if [[ $# -ne 1 ]]; then
  usage >&2
  exit 1
fi

cmd_input="$1"
cmd_base="$(basename "$cmd_input")"

desktop_file=""

find_desktop_file() {
  local target="$1"
  local dir file exec_line exec_first

  for dir in ~/.local/share/applications /usr/local/share/applications /usr/share/applications; do
    [[ -d "$dir" ]] || continue

    while IFS= read -r -d '' file; do
      exec_line="$(grep -m1 '^Exec=' "$file" 2>/dev/null || true)"
      [[ -n "$exec_line" ]] || continue

      exec_line="${exec_line#Exec=}"

      # keep only first token
      exec_first="${exec_line%% *}"
      exec_first="${exec_first##*/}"

      if [[ "$exec_first" == "$target" ]]; then
        printf '%s\n' "$file"
        return 0
      fi
    done < <(find "$dir" -type f -name '*.desktop' -print0 2>/dev/null)
  done

  retur
}

desktop_file="$(find_desktop_file "$cmd_base" || true)"
printf '{\n'
printf '"command": "%s",\n' "$cmd_input"
printf '"basename": "%s",\n' "$cmd_base"

if [[ -n "$desktop_file" ]]; then
  printf '"desktop_file": "%s",\n' "$desktop_file"

  startup_wmclass="$(grep -m1 '^StartupWMClass=' "$desktop_file" 2>/dev/null || true)"
  startup_wmclass="${startup_wmclass#StartupWMClass=}"

  desktop_id="$(basename "$desktop_file" .desktop)"

  if [[ -n "$startup_wmclass" ]]; then
    printf '"best_guess_class": "%s",\n' "$startup_wmclass"
  else
    printf '"best_guess_class": null,\n'
  fi

  printf '"possible_app_id": "%s"\n' "$desktop_id"
else
  printf '"desktop_file": null,\n'
  printf '"best_guess_class": null,\n'
  printf '"possible_app_id": "%s"\n' "$cmd_base"
fi
printf '}\n'
