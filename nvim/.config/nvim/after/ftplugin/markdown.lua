-- Markdown filetype keymaps (Local Leader)
-- Local leader (,) for filetype-specific commands

local map = vim.keymap.set
local opts = { buffer = true, silent = true }

-- Markdown preview
map('n', '<localleader>p', '<cmd>MarkdownPreview<cr>', vim.tbl_extend('force', opts, { desc = '[M]arkdown [P]review toggle' }))

-- Table mode
map('n', '<localleader>t', '<cmd>TableModeToggle<cr>', vim.tbl_extend('force', opts, { desc = '[M]arkdown [T]able mode toggle' }))

-- Table format
map('n', '<localleader>f', '<cmd>TableModeRealign<cr>', vim.tbl_extend('force', opts, { desc = '[M]arkdown table [F]ormat (realign)' }))

-- Table operations
map('n', '<localleader>tr', '<cmd>TableModeRealign<cr>', vim.tbl_extend('force', opts, { desc = '[T]able [R]ealign' }))
map('n', '<localleader>ts', '<cmd>TableSort<cr>', vim.tbl_extend('force', opts, { desc = '[T]able [S]ort' }))
