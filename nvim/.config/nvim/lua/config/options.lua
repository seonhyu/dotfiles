-- Vim Options
-- See `:help vim.o`

-- Line numbers
vim.o.number = true

-- Mouse mode
vim.o.mouse = 'a'

-- Don't show mode (status line shows it)
vim.o.showmode = false

-- Sync clipboard with OS
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching unless \C or capital letters
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Configure splits
vim.o.splitright = true
vim.o.splitbelow = true

-- Whitespace characters
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live
vim.o.inccommand = 'split'

-- Cursor line
vim.o.cursorline = true

-- Scroll offset
vim.o.scrolloff = 10

-- Confirm dialog for unsaved changes
vim.o.confirm = true

-- Tab settings (2 spaces)
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2

-- Code folding (Treesitter based)
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

-- vim: ts=2 sts=2 sw=2 et
