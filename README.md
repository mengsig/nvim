# Neovim config

This config is managed with `lazy.nvim` and expects a few external tools to be
available before the first Neovim startup.

## Install

On Arch Linux or Ubuntu/Debian:

```sh
./install.sh
```

The installer detects your package manager (`pacman` or `apt`), installs the
system tools this config depends on, syncs Lazy plugins, installs Mason-managed
tools, and installs the configured Tree-sitter parsers.

Node.js and Neovim are not taken from the distro package list. The script
checks for them and, if they are missing or too old, installs an official build
directly:

- **Node.js**: if `npm` is not found, Node.js LTS (`$NODE_VERSION`, default
  `v22.11.0`) is installed to `/opt/node-lts` and symlinked into
  `/usr/local/bin`.
- **Neovim**: if Neovim >= 0.11 is not found, the pinned stable build
  (`$NVIM_VERSION`, default `v0.11.2`) is installed to `/opt/nvim-linux` and
  symlinked into `/usr/local/bin`.
- **Claude Code CLI** (required by the `nvime` plugin): if `claude` is not
  found, it is installed via the official installer
  (`curl -fsSL https://claude.ai/install.sh | bash`), which drops `claude` into
  `~/.local/bin`.

Notes for Ubuntu/Debian:

- `fd` ships as `fdfind`; the script symlinks it to `~/.local/bin/fd`, so make
  sure `~/.local/bin` is on your `PATH`.
- `tree-sitter-cli` is installed globally via `npm`.

## External requirements

- `neovim`
- `git`, `curl`, `unzip`
- `gcc`, `make`
- `npm`
- `ripgrep`, `fd`
- `tree-sitter-cli`
- `wl-clipboard`

## Tree-sitter

The configured parser set lives in `lua/custom/treesitter.lua`.

Install it manually with:

```vim
:TSInstallConfigured
```

`nvim-treesitter` is pinned to a Neovim 0.11-compatible commit. Remove the pin
in `lua/custom/plugins/treesitter.lua` after upgrading Neovim to 0.12 or newer.
