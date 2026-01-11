-- Zen Mode - Distraction-free coding
return {
  {
    'folke/zen-mode.nvim',
    cmd = 'ZenMode',
    keys = {
      { '<leader>tz', '<cmd>ZenMode<cr>', desc = '[T]oggle [Z]en mode' },
    },
    opts = {
      window = {
        width = 120,
      },
      plugins = {
        options = {
          laststatus = 0,
        },
        twilight = {
          enabled = true,
        },
      },
    },
  },
  {
    'folke/twilight.nvim',
    cmd = 'Twilight',
    keys = {
      { '<leader>tt', '<cmd>Twilight<cr>', desc = '[T]oggle [T]wilight' },
    },
    opts = {
      context = 0,
      expand = {
        'function',
        'method',
        'table',
        'if_statement',
        'function_declaration',
        'method_declaration',
        'pair',
      },
    },
  },
}
