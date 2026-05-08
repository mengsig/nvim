return {
  {
    'nvim-treesitter/nvim-treesitter',
    -- This is the last known-good checkout for Neovim 0.11.x in this config.
    -- Remove the pin after upgrading Neovim to 0.12+.
    commit = '45a07f869b0cffba342276f2c77ba7c116d35db8',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').setup()

      local treesitter = require 'custom.treesitter'
      local notified = {}

      vim.api.nvim_create_user_command('TSInstallConfigured', function()
        treesitter.install():wait(300000)
      end, {
        desc = 'Install configured Tree-sitter parsers',
      })

      vim.api.nvim_create_autocmd('FileType', {
        pattern = vim.tbl_keys(treesitter.filetypes),
        callback = function(args)
          local ok, err = pcall(vim.treesitter.start, args.buf)
          if ok then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            return
          end

          local ft = vim.bo[args.buf].filetype
          if not notified[ft] then
            notified[ft] = true
            vim.notify(('Tree-sitter parser unavailable for %s: %s'):format(ft, err), vim.log.levels.WARN)
          end
        end,
      })
    end,
  },
}
