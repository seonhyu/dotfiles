-- Uses the installed Neovim configuration and real Telescope/fd.
-- nvim --headless -i NONE -c 'luafile nvim/tests/file-picker.lua' -c 'qa!'
local directory = vim.fn.tempname() .. " 한글 dir"
vim.fn.mkdir(directory, "p")
local source_path = directory .. "/report.md"
local target_path = directory .. "/target.lua"
vim.fn.writefile({ "| Field |", "| --- |", "| sif_rpt_type |" }, source_path)
vim.fn.writefile({ "return true" }, target_path)

local ok, err = pcall(function()
  vim.cmd.edit(vim.fn.fnameescape(source_path))
  local reader = require("markdown-table-wrap.reader")
  assert(
    vim.wait(2000, function()
      return reader.is_reader(vim.api.nvim_get_current_buf())
    end),
    "Reader auto-open"
  )
  local reader_buf = vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local actions = require("telescope.actions")
  local state = require("telescope.actions.state")
  local function search()
    vim.fn.maparg(" fd", "n", false, true).callback()
    local prompt = vim.api.nvim_get_current_buf()
    local picker = state.get_current_picker(prompt)
    assert(
      vim.wait(2000, function()
        return picker.manager and picker.manager:num_results() == 2
      end),
      "Directory results"
    )
    assert(vim.uv.fs_realpath(picker.cwd) == vim.uv.fs_realpath(directory), "Picker cwd must be the source directory")
    return prompt, picker
  end
  local prompt = search()
  actions.close(prompt)
  assert(vim.api.nvim_get_current_buf() == reader_buf, "Cancel must return to Reader")
  assert(vim.deep_equal(vim.api.nvim_win_get_cursor(0), cursor), "Cancel must preserve cursor")
  local picker
  prompt, picker = search()
  picker:set_prompt("target")
  assert(
    vim.wait(2000, function()
      return picker.manager:num_results() == 1
    end),
    "Filter target"
  )
  picker:set_selection(0)
  actions.select_default(prompt)
  assert(
    vim.wait(2000, function()
      return vim.uv.fs_realpath(vim.api.nvim_buf_get_name(0)) == vim.uv.fs_realpath(target_path)
    end),
    "Open selected file"
  )
  print("PASS real Telescope Reader search, cancel, and file selection")
end)
vim.fn.delete(directory, "rf")
if not ok then
  vim.api.nvim_err_writeln(tostring(err))
  vim.cmd("cquit 1")
end
