#!/usr/bin/env bash
set -e

if [ -z "$1" ]; then
  echo "Usage: $0 <host>"
  exit 1
fi

HOST=$1

sudo nix run --extra-experimental-features "nix-command flakes" github:nix-community/disko -- --mode disko --flake ".#${HOST}"
sudo nixos-install --flake ".#${HOST}"
