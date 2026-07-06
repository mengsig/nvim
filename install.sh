#!/usr/bin/env bash
set -euo pipefail

# Cross-distro installer for this Neovim configuration.
# Supports Arch Linux (pacman) and Ubuntu/Debian (apt).
#
# It installs the external tools this config depends on, then syncs Lazy
# plugins, installs Mason-managed tools, and installs the configured
# Tree-sitter parsers.

# This config tracks Neovim 0.11.x (nvim-treesitter is pinned to a
# 0.11-compatible commit). On distros where we fetch a prebuilt Neovim
# (Ubuntu/Debian), pin to this release. Bump it after removing the
# treesitter pin in lua/custom/plugins/treesitter.lua.
NVIM_VERSION="${NVIM_VERSION:-v0.11.2}"

# Node.js LTS to install directly (from nodejs.org) when no npm is found.
# See https://docs.npmjs.com/downloading-and-installing-node-js-and-npm
NODE_VERSION="${NODE_VERSION:-v22.11.0}"

log() { printf '\033[1;32m==>\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33mwarning:\033[0m %s\n' "$*" >&2; }

# Make sure user-local binaries (e.g. the fd symlink we create below) and
# any prebuilt Neovim are on PATH for the headless steps at the end.
export PATH="$HOME/.local/bin:/opt/nvim-linux/bin:/opt/node-lts/bin:$PATH"

# --- Detect package manager -------------------------------------------------
if command -v pacman >/dev/null 2>&1; then
  DISTRO=arch
elif command -v apt-get >/dev/null 2>&1; then
  DISTRO=debian
else
  echo "install.sh supports Arch Linux (pacman) and Ubuntu/Debian (apt) only." >&2
  exit 1
fi

# --- Helpers ----------------------------------------------------------------

# Returns 0 (true) if a usable Neovim >= 0.11 is already installed.
have_modern_nvim() {
  command -v nvim >/dev/null 2>&1 || return 1
  local v major minor
  v=$(nvim --version | head -n1 | grep -oE '[0-9]+\.[0-9]+' | head -n1) || return 1
  major=${v%%.*}
  minor=${v##*.}
  [ "$major" -gt 0 ] || { [ "$major" -eq 0 ] && [ "$minor" -ge 11 ]; }
}

install_prebuilt_nvim() {
  local tarball
  case "$(uname -m)" in
    x86_64) tarball=nvim-linux-x86_64.tar.gz ;;
    aarch64 | arm64) tarball=nvim-linux-arm64.tar.gz ;;
    *)
      warn "No prebuilt Neovim for $(uname -m); install Neovim >= 0.11 manually."
      return 1
      ;;
  esac

  local url="https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/${tarball}"
  local tmp
  tmp=$(mktemp -d)
  log "Downloading Neovim ${NVIM_VERSION} (${tarball})"
  curl -fL "$url" -o "$tmp/$tarball"
  sudo rm -rf /opt/nvim-linux
  sudo mkdir -p /opt/nvim-linux
  sudo tar -C /opt/nvim-linux --strip-components=1 -xzf "$tmp/$tarball"
  sudo ln -sf /opt/nvim-linux/bin/nvim /usr/local/bin/nvim
  rm -rf "$tmp"
}

install_prebuilt_node() {
  local arch_tag
  case "$(uname -m)" in
    x86_64) arch_tag=x64 ;;
    aarch64 | arm64) arch_tag=arm64 ;;
    armv7l) arch_tag=armv7l ;;
    *)
      warn "No prebuilt Node.js for $(uname -m); install Node.js LTS manually."
      return 1
      ;;
  esac

  local pkg="node-${NODE_VERSION}-linux-${arch_tag}"
  local url="https://nodejs.org/dist/${NODE_VERSION}/${pkg}.tar.xz"
  local tmp
  tmp=$(mktemp -d)
  log "Downloading Node.js LTS ${NODE_VERSION} (${arch_tag})"
  curl -fL "$url" -o "$tmp/node.tar.xz"
  sudo rm -rf /opt/node-lts
  sudo mkdir -p /opt/node-lts
  sudo tar -C /opt/node-lts --strip-components=1 -xJf "$tmp/node.tar.xz"
  sudo ln -sf /opt/node-lts/bin/node /usr/local/bin/node
  sudo ln -sf /opt/node-lts/bin/npm /usr/local/bin/npm
  sudo ln -sf /opt/node-lts/bin/npx /usr/local/bin/npx
  rm -rf "$tmp"
}

# Ensure npm is available, installing Node.js LTS directly if it isn't.
ensure_node() {
  if command -v npm >/dev/null 2>&1; then
    log "npm already present (node $(node --version 2>/dev/null), npm $(npm --version 2>/dev/null))"
    return
  fi
  log "npm not found; installing Node.js LTS directly"
  install_prebuilt_node
}

# Ensure a modern Neovim is available, installing a pinned stable build directly
# if the current one is missing or older than 0.11.
ensure_neovim() {
  if have_modern_nvim; then
    log "Neovim already present ($(nvim --version | head -n1))"
    return
  fi
  log "Neovim >= 0.11 not found; installing ${NVIM_VERSION} directly"
  install_prebuilt_nvim
}

# Ensure the Claude Code CLI is available (required by the nvime plugin).
# Uses the official installer, which drops `claude` into ~/.local/bin.
ensure_claude() {
  if command -v claude >/dev/null 2>&1; then
    log "Claude Code CLI already present ($(claude --version 2>/dev/null))"
    return
  fi
  log "Installing Claude Code CLI via the official installer"
  curl -fsSL https://claude.ai/install.sh | bash
}

# --- Install system packages ------------------------------------------------
# Neovim and Node.js/npm are handled separately (ensure_neovim / ensure_node)
# so they can be installed directly when missing or too old, on any distro.
case "$DISTRO" in
  arch)
    log "Installing packages with pacman"
    packages=(
      git curl unzip
      gcc make            # telescope-fzf-native, treesitter parsers, luasnip jsregexp
      ripgrep fd          # telescope / snacks pickers
      tree-sitter-cli     # nvim-treesitter (main branch) parser compilation
      wl-clipboard xclip  # system clipboard (wayland + X11)
      python python-pip   # general / Mason python tooling
      gh-cli              # github-cli
    )
    sudo pacman -S --needed "${packages[@]}"
    ;;

  debian)
    log "Adding gh-keyring"
    (type -p wget >/dev/null || (sudo apt update && sudo apt install wget -y)) \
    	&& sudo mkdir -p -m 755 /etc/apt/keyrings \
    	&& out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
    	&& cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
    	&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
    	&& sudo mkdir -p -m 755 /etc/apt/sources.list.d \
    	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
    log "Installing packages with apt"
    sudo apt-get update
    packages=(
      git curl unzip xz-utils  # xz-utils: extract the Node.js .tar.xz tarball
      build-essential          # gcc, g++, make
      ripgrep fd-find          # telescope / snacks pickers (binary is 'fdfind')
      wl-clipboard xclip       # system clipboard (wayland + X11)
      python3 python3-pip python3-venv
      gh                       # github-cli
    )
    sudo apt-get install -y "${packages[@]}"

    # Telescope/snacks call the `fd` executable, but Debian/Ubuntu ship it as
    # `fdfind`. Expose it as `fd` on the user's PATH.
    if ! command -v fd >/dev/null 2>&1 && command -v fdfind >/dev/null 2>&1; then
      mkdir -p "$HOME/.local/bin"
      ln -sf "$(command -v fdfind)" "$HOME/.local/bin/fd"
      log "Linked fdfind -> ~/.local/bin/fd (ensure ~/.local/bin is on your PATH)"
    fi
    ;;
esac

# Node.js/npm and Neovim: use the distro build if it's good enough, otherwise
# install the official LTS / pinned stable release directly.
ensure_node
ensure_neovim

# tree-sitter CLI isn't packaged for apt; install it globally via npm (needs the
# npm ensured just above). On Arch it came from the pacman package list.
if [ "$DISTRO" = debian ] && ! command -v tree-sitter >/dev/null 2>&1; then
  log "Installing tree-sitter-cli via npm"
  sudo npm install -g tree-sitter-cli
fi

# Claude Code CLI required by the nvime plugin (installs into ~/.local/bin).
ensure_claude

# --- Bootstrap Neovim plugins and tools -------------------------------------
# gitflow and nvime are now regular GitHub plugins (devGunnin/gitflow,
# mengsig/nvime), so lazy.nvim clones them during the sync below.
if ! have_modern_nvim; then
  warn "Neovim >= 0.11 not found on PATH; skipping plugin bootstrap."
  warn "Install Neovim >= 0.11, then re-run this script."
  exit 1
fi

log "Syncing Lazy plugins"
nvim --headless '+Lazy! sync' '+qa'

log "Installing Mason tools and Tree-sitter parsers"
nvim --headless '+MasonToolsInstallSync' '+TSInstallConfigured' '+qa'

log "Done. Neovim plugins, Mason tools, and Tree-sitter parsers are installed."
