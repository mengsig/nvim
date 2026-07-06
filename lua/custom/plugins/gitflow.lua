return {
  {
    'devGunnin/gitflow',
    event = 'VeryLazy',
    init = function()
      vim.g.loaded_gitflow = 1
    end,
    opts = {
      keybindings = {
        help = '<leader>gh',
        open = '<leader>go',
        close = '<leader>gq',
      },
      ui = {
        default_layout = 'float',
        split = {
          orientation = 'vertical',
          size = 50,
        },
        float = {
          width = 0.8,
          height = 0.7,
          border = 'rounded',
          title = 'Gitflow',
        },
      },
      behavior = {
        reuse_named_buffers = true,
        close_windows_on_buffer_wipe = true,
      },
    },
    config = function(_, opts)
      require('gitflow').setup(opts)
    end,
  },
}
