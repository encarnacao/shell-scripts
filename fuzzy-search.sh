#!/usr/bin/env bash
set -euo pipefail

# Usage: ./find-in-matching-dirs.sh <dir_name_substring> <file_content_substring>
#
# - Scans only directories in the current working directory whose names contain <dir_name_substring>
# - Searches for <file_content_substring> inside files under those directories
# - Skips common dependency/env folders and virtualenvs (node_modules, .venv, venv, env, dist, build, etc.)
# - Prints paths of files that contain the substring (one per line)

if [[ $# -ne 2 ]]; then
  echo "Usage: $0 <dir_name_substring> <file_content_substring>" >&2
  exit 2
fi

DIR_SUBSTR="$1"
NEEDLE="$2"

# Find matching top-level directories (names containing DIR_SUBSTR)
mapfile -d '' DIRS < <(
  find . -maxdepth 1 -mindepth 1 -type d -name "*${DIR_SUBSTR}*" -print0
)

if [[ ${#DIRS[@]} -eq 0 ]]; then
  exit 0
fi

# Grep options:
# -R: recursive
# -l: print file names only
# -F: fixed-string match (treat NEEDLE literally)
# --binary-files=without-match: ignore binary hits
# --exclude-dir / --exclude: skip dependency/venv/.env files
grep -RIlF --binary-files=without-match \
  --exclude-dir=node_modules \
  --exclude-dir=.venv \
  --exclude-dir=venv \
  --exclude-dir=env \
  --exclude-dir=.env \
  --exclude-dir=dist \
  --exclude-dir=build \
  --exclude-dir=target \
  --exclude-dir=.git \
  --exclude-dir=.next \
  --exclude-dir=.turbo \
  --exclude-dir=.cache \
  --exclude-dir=.pytest_cache \
  --exclude-dir=__pycache__ \
  --exclude=.env \
  --exclude=.env.* \
  --exclude=poetry.lock \
  --exclude=package-lock.json \
  --exclude=yarn.lock \
  --exclude=pnpm-lock.yaml \
  -- "$NEEDLE" "${DIRS[@]}" \
  | sed 's|^\./||'
