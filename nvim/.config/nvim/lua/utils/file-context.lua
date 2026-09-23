-- Resolve file paths without switching away from a Markdown table Reader.
local M = {}

function M.is_reader()
  return vim.api.nvim_buf_get_name(0):match("^markdown%-table%-wrap://reader/") ~= nil
end

function M.source_buffer()
  if not M.is_reader() then
    return nil
  end
  -- A Reader already has the plugin loaded. Do not load it for ordinary files.
  local plugin = package.loaded["markdown-table-wrap"]
  local source = plugin and plugin.resolve_source_buffer(vim.api.nvim_get_current_buf())
  if source and vim.api.nvim_buf_is_valid(source) then
    return source
  end
end

function M.path()
  if not M.is_reader() then
    return vim.fn.expand("%:p")
  end
  local source = M.source_buffer()
  if source then
    local path = vim.api.nvim_buf_get_name(source)
    if path ~= "" and not path:match("^%a[%w+.-]*://") then
      return path
    end
  end
  vim.notify("Reader의 원본 파일 경로를 찾을 수 없습니다.", vim.log.levels.WARN)
end

function M.directory()
  if not M.is_reader() then
    return vim.fn.expand("%:p:h")
  end
  local path = M.path()
  return path and vim.fn.fnamemodify(path, ":h")
end

function M.reveal()
  if not M.is_reader() then
    vim.cmd("Neotree reveal")
    return
  end
  local path = M.path()
  if path then
    require("neo-tree.command").execute({ action = "focus", source = "filesystem", reveal_file = path })
  end
end

function M.git_current_file()
  if not M.is_reader() then
    vim.cmd("LazyGitCurrentFile")
    return
  end
  local directory = M.directory()
  if directory then
    local lazygit = require("lazygit")
    lazygit.lazygit(require("lazygit.utils").get_root(directory))
  end
end

return M
