return {
  {
    dir = '~/Projects/gitflow/',
    event = 'VeryLazy',

    keybindings = {
      help = '<leader>gh',
      open = '<leader>go',
      refresh = '<leader>gr',
      close = '<leader>gq',
    },
    ui = {
      default_layout = 'split',
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
}
