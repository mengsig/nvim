#!/usr/bin/env bash
set -euo pipefail

if ! command -v pacman >/dev/null 2>&1; then
  echo "install.sh currently supports Arch Linux and pacman only." >&2
  exit 1
fi

packages=(
  neovim
  git
  curl
  unzip
  gcc
  make
  npm
  ripgrep
  fd
  tree-sitter-cli
  wl-clipboard
)

sudo pacman -S --needed "${packages[@]}"

nvim --headless '+Lazy! sync' '+qa'
nvim --headless '+MasonToolsInstallSync' \
  '+TSInstallConfigured' \
  '+qa'

echo "Neovim plugins, Mason tools, and Tree-sitter parsers are installed."
