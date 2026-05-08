return {
  {
    'devArchOverclocked/termlet',
    event = 'VeryLazy',
    opts = {
      terminal = {
        height_ratio = 0.50,
        width_ratio = 1,
        border = 'rounded', -- "none", "single", "double", "rounded", etc.
        position = 'bottom', -- "bottom", "center", "top"
      },
      scripts = {},
      debug = false,
    },
    keys = {
      {
        '<leader>tm',
        function()
          require('termlet').open_menu()
        end,
        desc = 'TermLet: Open menu',
      },
      {
        '<leader>tl',
        function()
          require('termlet').list_scripts()
        end,
        desc = 'TermLet: List scripts',
      },
      {
        '<leader>tc',
        function()
          require('termlet').close_terminal()
        end,
        desc = 'TermLet: Close terminal',
      },
    },
  },
}
