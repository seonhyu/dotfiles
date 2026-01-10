-- Tmux Navigator - Seamless tmux/vim navigation
return {
  'christoomey/vim-tmux-navigator',
  cmd = {
    'TmuxNavigateLeft',
    'TmuxNavigateDown',
    'TmuxNavigateUp',
    'TmuxNavigateRight',
    'TmuxNavigatePrevious',
  },
  keys = {
    { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
    { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
    { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
    { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
    { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
  },
  config = function()
    vim.g.tmux_navigator_no_mappings = 1
    vim.g.tmux_navigator_save_on_switch = 2
    vim.g.tmux_navigator_disable_when_zoomed = 1

    vim.keymap.set('n', '<C-h>', '<cmd>TmuxNavigateLeft<cr>', { desc = 'Tmux/Window left' })
    vim.keymap.set('n', '<C-j>', '<cmd>TmuxNavigateDown<cr>', { desc = 'Tmux/Window down' })
    vim.keymap.set('n', '<C-k>', '<cmd>TmuxNavigateUp<cr>', { desc = 'Tmux/Window up' })
    vim.keymap.set('n', '<C-l>', '<cmd>TmuxNavigateRight<cr>', { desc = 'Tmux/Window right' })
    vim.keymap.set('n', '<C-\\>', '<cmd>TmuxNavigatePrevious<cr>', { desc = 'Tmux/Window previous' })
  end,
}
