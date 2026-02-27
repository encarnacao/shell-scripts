#!/usr/bin/env bash
set -euo pipefail

PREFIX="${1:-}"

if [ -z "$PREFIX" ]; then
  echo "Usage: $0 <lambda-name-prefix>" >&2
  exit 1
fi

# Disable AWS CLI pager
export AWS_PAGER=""

# Get function names matching prefix
FUNCTIONS=$(aws lambda list-functions \
  --query "Functions[?starts_with(FunctionName, \`${PREFIX}\`)].FunctionName" \
  --output text)

for FN in $FUNCTIONS; do
  echo "Updating alias 'prod' -> \$LATEST for $FN"

  if ! aws lambda update-alias \
    --function-name "$FN" \
    --name prod \
    --function-version '$LATEST' \
    --no-cli-pager \
    >/dev/null; then
      echo "ERROR updating $FN" >&2
  fi
done

