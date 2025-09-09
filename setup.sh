#!/usr/bin/env bash

SRC_DIR="$(dirname ${BASH_SOURCE[0]})"
nix-shell -p home-manager --run "home-manager switch --flake ${SRC_DIR}#goldan"
