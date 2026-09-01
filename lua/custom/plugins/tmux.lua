-- Makes C-h/j/k/l treat nvim splits and tmux panes as one grid: at the edge of
-- a split, focus crosses into the neighbouring tmux pane instead of stopping.
-- The tmux half of this lives in ~/.config/tmux/tmux.conf.
return {
  {
    'christoomey/vim-tmux-navigator',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatorProcessList',
    },
    keys = {
      { '<C-h>', '<cmd><C-U>TmuxNavigateLeft<CR>', desc = 'Move focus to the left window/pane' },
      { '<C-j>', '<cmd><C-U>TmuxNavigateDown<CR>', desc = 'Move focus to the lower window/pane' },
      { '<C-k>', '<cmd><C-U>TmuxNavigateUp<CR>', desc = 'Move focus to the upper window/pane' },
      { '<C-l>', '<cmd><C-U>TmuxNavigateRight<CR>', desc = 'Move focus to the right window/pane' },
    },
    init = function()
      -- A zoomed tmux pane stays zoomed; navigation is confined to nvim.
      vim.g.tmux_navigator_disable_when_zoomed = 1
    end,
  },
}
