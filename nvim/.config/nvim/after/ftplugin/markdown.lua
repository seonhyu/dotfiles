-- Markdown filetype keymaps (Local Leader)
-- Local leader (,) for filetype-specific commands
--
-- markdown-table-wrap의 Reader 버퍼도 filetype=markdown 이라 이 파일이 함께 적용된다.
-- Reader 버퍼 이름은 markdown-table-wrap://reader/... 이므로 파일 경로가 필요한 명령은
-- 원본(Source) 버퍼를 먼저 찾는다.

local map = vim.keymap.set
local opts = { buffer = true, silent = true }

-- render-markdown이 **, _ 등 원본 마커를 숨기려면 conceal 필요
vim.opt_local.conceallevel = 2
vim.opt_local.concealcursor = ''

-- 현재 버퍼가 Reader면 원본 버퍼로 해석한다. 아니면 현재 버퍼 그대로.
local function source_buffer()
  local bufnr = vim.api.nvim_get_current_buf()
  local ok, mtw = pcall(require, 'markdown-table-wrap')
  if ok and type(mtw.resolve_source_buffer) == 'function' then
    bufnr = mtw.resolve_source_buffer(bufnr) or bufnr
  end
  return bufnr
end

-- Markdown preview
-- 렌더링은 CLI(`mdpreview` -> `gh gfm-preview`)가 담당한다.
-- Neovim은 launcher일 뿐이라 종료해도 preview 서버는 유지된다.
map('n', '<localleader>p', function()
  local bufnr = source_buffer()
  local file = vim.api.nvim_buf_get_name(bufnr)
  if file == '' or file:match('^markdown%-table%-wrap://') then
    vim.notify('저장되지 않은 버퍼는 preview할 수 없다.', vim.log.levels.WARN)
    return
  end
  if vim.bo[bufnr].modified then
    vim.api.nvim_buf_call(bufnr, function()
      vim.cmd('write')
    end)
  end
  vim.fn.jobstart({ 'mdpreview', file }, { detach = true })
  vim.notify('mdpreview: ' .. vim.fn.fnamemodify(file, ':t'))
end, vim.tbl_extend('force', opts, { desc = '[M]arkdown [P]review' }))

-- 버퍼 내 렌더링 토글
map('n', '<localleader>r', '<cmd>RenderMarkdown toggle<cr>', vim.tbl_extend('force', opts, { desc = '[M]arkdown [R]ender toggle' }))

-- 표 관련 키맵(,w ,i ,e ]c [c)은 lua/plugins/markdown-table-wrap.lua 참고.
