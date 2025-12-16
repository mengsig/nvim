return {
  {
    'tpope/vim-fugitive',
    -- lazy‑load on any of these commands:
    cmd = { 'Git', 'Gstatus', 'Gblame', 'Gdiffsplit', 'Gread', 'Gwrite' },
    keys = {
      { '<leader>gs', ':Git<CR>', desc = 'Fugitive: status' },
      { '<leader>gd', ':Gvdiffsplit<CR>', desc = 'Fugitive: vertical diff' },
      { '<leader>gb', ':Gblame<CR>', desc = 'Fugitive: blame' },
    },
    -- you can also pass opts if you want to call setup():
    -- opts = {},
  },
}
