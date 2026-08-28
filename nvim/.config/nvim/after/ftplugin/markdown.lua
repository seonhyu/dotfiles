-- Markdown filetype keymaps (Local Leader)
-- Local leader (,) for filetype-specific commands

local map = vim.keymap.set
local opts = { buffer = true, silent = true }

-- render-markdown이 **, _ 등 원본 마커를 숨기려면 conceal 필요
vim.opt_local.conceallevel = 2
vim.opt_local.concealcursor = ''

-- Markdown preview
-- 렌더링은 CLI(`mdpreview` -> `gh gfm-preview`)가 담당한다.
-- Neovim은 launcher일 뿐이라 종료해도 preview 서버는 유지된다.
map('n', '<localleader>p', function()
  local file = vim.fn.expand('%:p')
  if file == '' then
    vim.notify('저장되지 않은 버퍼는 preview할 수 없다.', vim.log.levels.WARN)
    return
  end
  if vim.bo.modified then
    vim.cmd('write')
  end
  vim.fn.jobstart({ 'mdpreview', file }, { detach = true })
  vim.notify('mdpreview: ' .. vim.fn.fnamemodify(file, ':t'))
end, vim.tbl_extend('force', opts, { desc = '[M]arkdown [P]review' }))

-- 버퍼 내 렌더링 토글
map('n', '<localleader>r', '<cmd>RenderMarkdown toggle<cr>', vim.tbl_extend('force', opts, { desc = '[M]arkdown [R]ender toggle' }))

-- Table mode
map('n', '<localleader>t', '<cmd>TableModeToggle<cr>', vim.tbl_extend('force', opts, { desc = '[M]arkdown [T]able mode toggle' }))

-- Table format
map('n', '<localleader>f', '<cmd>TableModeRealign<cr>', vim.tbl_extend('force', opts, { desc = '[M]arkdown table [F]ormat (realign)' }))

-- Table operations
map('n', '<localleader>ts', '<cmd>TableSort<cr>', vim.tbl_extend('force', opts, { desc = '[T]able [S]ort' }))
