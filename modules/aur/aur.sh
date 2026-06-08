#!/usr/bin/env bash
set -euo pipefail

if ! command -v git &> /dev/null; then
  echo "ERROR: 'git' package is not installed, please install it, as it's necessary for getting the AUR package repo."
  exit 1
fi

if ! command -v makepkg &> /dev/null; then
  echo "ERROR: 'makepkg' package is not installed, please install it, as it's necessary for building the AUR package."
  exit 1
fi

get_json_array PACKAGES 'try .["install"][]' "${1}"

# read a single variable from the configuration
# `try` makes the command output 'null' if the key is not found, otherwise it will error out and the build will fail
# the `.["var"]` syntax is optional and could be replaced with the less safe and more error-prone `.var` syntax
VAR=$(echo "$1" | jq -r 'try .["var"]')
echo "$VAR"

# read an array from the configuration
get_json_array ARRAY 'try .["array"][]' "$1"
# loop over the array
for THING in "${ARRAY[@]}"; do
    echo "$THING"
done