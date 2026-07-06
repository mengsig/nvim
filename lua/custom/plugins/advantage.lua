-- advantage.nvim — coding-agent harness (local development checkout)
return {
  {
    'mengsig/advantage.nvim',
    name = 'advantage.nvim',
    cmd = 'Advantage',
    keys = {
      {
        '<leader>cc',
        function()
          require('advantage').toggle()
        end,
        desc = 'advantage: toggle chat',
      },
      {
        '<leader>cs',
        function()
          require('advantage').add_selection()
        end,
        mode = 'x',
        desc = 'advantage: add selection',
      },
      {
        '<leader>cf',
        function()
          require('advantage').add_file()
        end,
        desc = 'advantage: add current file / netrw marks',
      },
      {
        '<leader>cl',
        function()
          require('advantage').add_location()
        end,
        desc = 'advantage: add cursor location',
      },
      {
        '<leader>cp',
        function()
          require('advantage').pick_files()
        end,
        desc = 'advantage: pick file',
      },
      {
        '<leader>cn',
        function()
          require('advantage').new_session()
        end,
        desc = 'advantage: new session',
      },
      {
        '<leader>cm',
        function()
          require('advantage').pick_model()
        end,
        desc = 'advantage: model',
      },
      {
        '<leader>ce',
        function()
          require('advantage').pick_effort()
        end,
        desc = 'advantage: effort / thinking',
      },
      {
        '<leader>cr',
        function()
          require('advantage').resume()
        end,
        desc = 'advantage: resume',
      },
      {
        '<leader>cu',
        function()
          require('advantage').usage()
        end,
        desc = 'advantage: usage',
      },
      {
        '<leader>cd',
        function()
          require('advantage').review()
        end,
        desc = 'advantage: review changes',
      },
      {
        '<leader>cy',
        function()
          require('advantage').toggle_yolo()
        end,
        desc = 'advantage: toggle yolo',
      },
      {
        '<leader>c?',
        function()
          require('advantage').help()
        end,
        desc = 'advantage: help',
      },
    },
    opts = {
      context = {
        -- '/compact' (manual) spends one call on summarizer_model for a real,
        -- structured summary. Auto-compact opts into the same LLM summary here;
        -- set auto_compact_mode = 'heuristic' to keep background compaction free.
        auto_compact_mode = 'llm',
        compact_mode = 'llm',
        summarizer_model = 'anthropic/claude-haiku-4-5',
        max_agent_turns = 1000,
      },
      -- keymaps are defined via lazy `keys` above so which-key/lazy can show
      -- the whole <leader>c group. Disable every built-in map to avoid shadows.
      keymaps = {
        toggle = '',
        new_session = '',
        models = '',
        resume = '',
        add_selection = '',
        add_file = '',
        add_location = '',
        pick_files = '',
        usage = '',
        review = '',
        yolo = '',
        effort = '',
        help = '',
      },
    },
  },
}
