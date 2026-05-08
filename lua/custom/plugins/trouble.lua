return {
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = 'Trouble',
    keys = {
      { '<leader>xx', '<cmd>Trouble diagnostics toggle<CR>', desc = 'Trouble: Diagnostics' },
      { '<leader>xd', '<cmd>Trouble diagnostics toggle filter.buf=0<CR>', desc = 'Trouble: Buffer Diagnostics' },
      { '<leader>xw', '<cmd>Trouble diagnostics toggle<CR>', desc = 'Trouble: Workspace Diagnostics' },
      { '<leader>xq', '<cmd>Trouble qflist toggle<CR>', desc = 'Trouble: Quickfix' },
      { '<leader>xl', '<cmd>Trouble loclist toggle<CR>', desc = 'Trouble: Location List' },
      {
        '[t',
        function()
          require('trouble').prev { mode = 'last', jump = true }
        end,
        desc = 'Trouble: Previous item',
      },
      {
        ']t',
        function()
          require('trouble').next { mode = 'last', jump = true }
        end,
        desc = 'Trouble: Next item',
      },
      {
        '<leader>fq',
        function()
          vim.cmd 'Trouble qflist open'

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
