return {
  {
    'devArchOverclocked/termlet',
    event = 'VeryLazy',
    opts = {
      root_dir = '~/Projects/zig/ziglings/',
      terminal = {
        height_ratio = 0.50,
        width_ratio = 1,
        border = 'rounded', -- "none", "single", "double", "rounded", etc.
        position = 'bottom', -- "bottom", "center", "top"
      },
      scripts = {
        { name = 'build_project', filename = 'zbr.sh' },
        { name = 'start_server', filename = 'server_test.py', cmd = 'python3 server_test.py' },
      },
      debug = false,
    },
    keys = {
      {
        '<leader>tb',
        function()
          require('termlet').run_build_project()
        end,
        desc = 'TermLet: Build project',
      },
      {
        '<leader>ts',
        function()
          require('termlet').run_start_server()
        end,
        desc = 'TermLet: Start server',
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
