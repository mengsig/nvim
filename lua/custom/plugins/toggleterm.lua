local term = nil

local function get_term()
  if term then
    return term
  end
  term = require('toggleterm.terminal').Terminal:new {
    direction = 'float',
    hidden = true,
    close_on_exit = false,
    float_opts = {
      border = 'rounded',
      width = function()
        return math.floor(vim.o.columns * 0.85)
      end,
      height = function()
        return math.floor(vim.o.lines * 0.85)
      end,
    },
  }
  return term
end

local function toggle()
  get_term():toggle()
end

local function hide()
  local t = get_term()
  if t:is_open() then
    t:close()
  end
end

return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    cmd = { 'ToggleTerm', 'TermExec' },
    keys = {
      {
        '<leader>t',
        function()
          toggle()
        end,
        mode = 'n',
        desc = 'Toggle persistent terminal',
      },
    },
    opts = {
      shade_terminals = true,
      start_in_insert = true,
      persist_mode = false,
      direction = 'float',
      close_on_exit = false,
      auto_scroll = true,
      float_opts = {
        border = 'rounded',
        winblend = 0,
      },
    },
    config = function(_, opts)
      require('toggleterm').setup(opts)

      vim.api.nvim_create_autocmd('TermOpen', {
        pattern = 'term://*toggleterm#*',
        callback = function(args)
          local buf = args.buf
          vim.keymap.set('n', 'q', function()
            hide()
          end, { buffer = buf, desc = 'Hide toggleterm' })
        end,
      })

      vim.api.nvim_create_autocmd({ 'BufEnter', 'WinEnter' }, {
        pattern = 'term://*toggleterm#*',
        callback = function()
          vim.cmd.startinsert()
        end,
      })
    end,
  },
}
