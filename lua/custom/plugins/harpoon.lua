return {
  {
    'ThePrimeagen/harpoon',
    keys = {
      {
        '<leader>a',
        function()
          require('harpoon.mark').add_file()
        end,
        desc = 'Harpoon: add file',
      },
      {
        '<C-e>',
        function()
          require('harpoon.ui').toggle_quick_menu()
        end,
        desc = 'Harpoon: quick menu',
      },
      {
        '<leader>hn',
        function()
          require('harpoon.ui').nav_next()
        end,
        desc = 'Harpoon: next file',
      },
      {
        '<leader>hp',
        function()
          require('harpoon.ui').nav_prev()
        end,
        desc = 'Harpoon: previous file',
      },
    },
  },
}
