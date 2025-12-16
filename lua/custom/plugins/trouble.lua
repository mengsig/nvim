return {
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = { 'Trouble', 'TroubleToggle', 'TroubleRefresh' },
    keys = {
      -- simple toggle
      { '<leader>xx', '<cmd>Trouble<CR>', desc = 'Trouble: Toggle' },
      -- diagnostics for the current buffer
      { '<leader>xd', '<cmd>TroubleToggle document_diagnostics<CR>', desc = 'Trouble: Document Diagnostics' },
      -- all workspace diagnostics
      { '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<CR>', desc = 'Trouble: Workspace Diagnostics' },
      -- quickfix / loclist
      { '<leader>xq', '<cmd>Trouble quickfix<CR>', desc = 'Trouble: QuickFix' },
      { '<leader>xl', '<cmd>Trouble loclist<CR>', desc = 'Trouble: Location List' },
      { '[t', '<cmd>TroublePrevious<CR>', desc = 'Trouble: Previous item' },
      { ']t', '<cmd>TroubleNext<CR>', desc = 'Trouble: Next item' },
      {
        '<leader>fq',
        function()
          -- 1) Populate Trouble's quickfix list (this also sets Vim's qf-list)
          vim.cmd 'Trouble quickfix'

          -- 2) Launch Telescope on that quickfix list
          require('telescope.builtin').quickfix()
        end,
        desc = 'Trouble → Telescope Quickfix',
      },
    },
    opts = {
      -- any Trouble.setup() opts go here
      auto_preview = false,
    },
  },
}
