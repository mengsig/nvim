# Neovim config

This config is managed with `lazy.nvim` and expects a few external tools to be
available before the first Neovim startup.

## Install

On Arch Linux:

```sh
./install.sh
```

The installer installs the system tools this config depends on, syncs Lazy
plugins, installs Mason-managed tools, and installs the configured Tree-sitter
parsers.

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
