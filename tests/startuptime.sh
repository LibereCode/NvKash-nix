#!/usr/bin/env bash

repo_dir="$(dirname "$(dirname "$0")")"
cd "$repo_dir" || exit

startuptime_path="$HOME/.local/share/nvim/startuptime.log"
mkdir -p "$(dirname "$startuptime_path")"
touch "${startuptime_path}"

# nix run . -- modules/nixvim/default.nix "${startuptime_path}" --startuptime "${startuptime_path}"
nvim modules/nixvim/default.nix "${startuptime_path}" --startuptime "${startuptime_path}"
