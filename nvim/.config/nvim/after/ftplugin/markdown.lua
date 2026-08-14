-- Markdown filetype keymaps (Local Leader)
-- Local leader (,) for filetype-specific commands

local map = vim.keymap.set
local opts = { buffer = true, silent = true }

-- render-markdown이 **, _ 등 원본 마커를 숨기려면 conceal 필요
vim.opt_local.conceallevel = 2
vim.opt_local.concealcursor = ''

-- Markdown preview
map('n', '<localleader>p', '<cmd>MarkdownPreview<cr>', vim.tbl_extend('force', opts, { desc = '[M]arkdown [P]review toggle' }))

-- 버퍼 내 렌더링 토글
map('n', '<localleader>r', '<cmd>RenderMarkdown toggle<cr>', vim.tbl_extend('force', opts, { desc = '[M]arkdown [R]ender toggle' }))

-- Table mode
map('n', '<localleader>t', '<cmd>TableModeToggle<cr>', vim.tbl_extend('force', opts, { desc = '[M]arkdown [T]able mode toggle' }))

-- Table format
map('n', '<localleader>f', '<cmd>TableModeRealign<cr>', vim.tbl_extend('force', opts, { desc = '[M]arkdown table [F]ormat (realign)' }))

-- Table operations
map('n', '<localleader>ts', '<cmd>TableSort<cr>', vim.tbl_extend('force', opts, { desc = '[T]able [S]ort' }))
