#!/usr/bin/env bash

SRC_DIR="$(dirname "$(realpath ${BASH_SOURCE[0]})")"
nix-shell -p home-manager --run "home-manager switch --flake ${SRC_DIR}#goldan --override-input dotfiles ${SRC_DIR}/dotfiles"
