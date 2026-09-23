-- From dotfiles: nvim --headless -u NONE -i NONE -l nvim/tests/file-keymaps.lua
vim.opt.rtp:prepend("nvim/.config/nvim")
vim.opt.rtp:append(vim.fn.stdpath("data") .. "/lazy/markdown-table-wrap.nvim")
vim.g.mapleader = " "
local captured
package.loaded["utils.nfc"] = {
  find_files_nfc = function(opts)
    captured = opts
  end,
}
require("config.keymaps")
local function invoke(key)
  local mapping = vim.fn.maparg(key, "n", false, true)
  assert(type(mapping.callback) == "function", key .. " must have a callback")
  mapping.callback()
end
local plugin = require("markdown-table-wrap")
plugin.setup({ auto_preview = false })
local source = vim.api.nvim_get_current_buf()
local path = vim.fn.tempname() .. " 한글 dir/report.md"
vim.api.nvim_buf_set_name(source, path)
vim.api.nvim_buf_set_lines(source, 0, -1, false, { "| Field |", "| --- |", "| sif_rpt_type |" })
vim.bo[source].filetype = "markdown"
-- The previous file must win over the Reader's own source on <leader><tab>.
local other = vim.api.nvim_create_buf(true, false)
vim.api.nvim_buf_set_name(other, vim.fn.tempname() .. "/other.md")
vim.api.nvim_set_current_buf(other)
vim.api.nvim_set_current_buf(source)
local reader = assert(plugin.reader_preview())
local cursor = vim.api.nvim_win_get_cursor(0)
invoke(" fd")
assert(captured.cwd == vim.fn.fnamemodify(path, ":h"), "Reader fd must use the source directory: " .. captured.cwd)
assert(captured.max_depth == 1)
invoke(" fD")
assert(captured.cwd == vim.fn.fnamemodify(path, ":h") and captured.max_depth == nil)
assert(vim.api.nvim_get_current_buf() == reader, "Path commands must keep Reader active")
assert(vim.deep_equal(cursor, vim.api.nvim_win_get_cursor(0)))
local tree, git_directory, git_root, emacs
package.loaded["neo-tree.command"] = {
  execute = function(opts)
    tree = opts
  end,
}
package.loaded["lazygit.utils"] = {
  get_root = function(dir)
    git_directory = dir
    return "/git-root"
  end,
}
package.loaded["lazygit"] = {
  lazygit = function(root)
    git_root = root
  end,
}
local system = vim.fn.system
vim.fn.system = function(argv)
  emacs = argv
  return ""
end
invoke(" op")
assert(tree.reveal_file == path and tree.source == "filesystem")
tree = nil
require("plugins.neo-tree").keys[1][2]()
assert(tree.reveal_file == path)
invoke(" gf")
assert(git_directory == vim.fn.fnamemodify(path, ":h") and git_root == "/git-root")
invoke(" oe")
assert(vim.deep_equal(emacs, { "emacsclient", "-n", path }))
assert(vim.api.nvim_get_current_buf() == reader)
assert(vim.deep_equal(cursor, vim.api.nvim_win_get_cursor(0)))
invoke(" \t")
assert(vim.api.nvim_get_current_buf() == other, "Reader <leader><tab> must skip its source buffer")
vim.api.nvim_set_current_buf(source)
plugin.close_reader()
local command
vim.api.nvim_create_user_command("Neotree", function(opts)
  command = "Neotree " .. opts.args
end, { nargs = "*" })
vim.api.nvim_create_user_command("LazyGitCurrentFile", function()
  command = "LazyGitCurrentFile"
end, {})
for _, name in ipairs({ path, (path:gsub("%.md$", ".lua")) }) do
  vim.api.nvim_buf_set_name(source, name)
  invoke(" fd")
  assert(captured.cwd == vim.fn.expand("%:p:h") and captured.max_depth == 1)
  invoke(" fD")
  assert(captured.cwd == vim.fn.expand("%:p:h") and captured.max_depth == nil)
  invoke(" op")
  assert(command == "Neotree reveal")
  invoke(" gf")
  assert(command == "LazyGitCurrentFile")
  invoke(" oe")
  assert(vim.deep_equal(emacs, { "emacsclient", "-n", name }))
end
vim.fn.system = system
-- Ordinary and unnamed files must not depend on loading the Markdown plugin.
package.loaded["markdown-table-wrap"] = nil
vim.api.nvim_buf_set_name(source, "")
invoke(" fd")
assert(captured.cwd == vim.fn.expand("%:p:h"))
assert(package.loaded["markdown-table-wrap"] == nil)
print("PASS Reader buffer toggle, Reader, ordinary Markdown, Lua, and unnamed file path keymaps")
