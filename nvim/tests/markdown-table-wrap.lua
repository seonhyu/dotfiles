-- Run from dotfiles: nvim --headless -u NONE -i NONE -l nvim/tests/markdown-table-wrap.lua
vim.opt.rtp:prepend("nvim/.config/nvim")
local markdown = require("vendor.markdown-table-wrap.markdown")
local cases = {
  { "sif_rpt_type", "sif_rpt_type", {} },
  { "foo__bar__baz", "foo__bar__baz", {} },
  { "한글_보고서_유형", "한글_보고서_유형", {} },
  { "_강조_ __굵게__", "강조 굵게", { "italic", "bold" } },
  { "(_word_)", "(word)", { "italic" } },
  { "_ bad_ _bad _", "_ bad_ _bad _", {} },
  { "sif_rpt_type _good_ __bold__", "sif_rpt_type good bold", { "italic", "bold" } },
  { "foo__bar__baz __good__", "foo__bar__baz good", { "bold" } },
  { "`sif_rpt_type` **bold** *italic*", "sif_rpt_type bold italic", { "code", "bold", "italic" } },
  { [[\_literal\_ _good_]], [[\_literal\_ good]], { "italic" } },
  { "[sif_rpt_type](url)", "sif_rpt_type", { "link" } },
}
for _, case in ipairs(cases) do
  local parsed = markdown.parse_inline(case[1])
  assert(parsed.text == case[2], vim.inspect({ input = case[1], expected = case[2], actual = parsed }))
  local kinds = {}
  for _, span in ipairs(parsed.spans) do
    kinds[#kinds + 1] = span.kind
  end
  assert(vim.deep_equal(kinds, case[3]), vim.inspect({ input = case[1], kinds = kinds }))
end
print(("Passed %d markdown table regression cases"):format(#cases))

-- Exercise the same preload and plugin startup order as lazy.nvim.
vim.opt.rtp:append(vim.fn.stdpath("data") .. "/lazy/markdown-table-wrap.nvim")
local spec = require("plugins.markdown-table-wrap")
spec.init()
vim.cmd("runtime plugin/markdown-table-wrap.lua")
local plugin = require("markdown-table-wrap")
plugin.setup(vim.tbl_deep_extend("force", spec.opts, { auto_preview = false }))
assert(require("markdown-table-wrap.markdown") == markdown, "Plugin must use the patched parser")
local source = vim.api.nvim_get_current_buf()
local lines = { "| Field | Description |", "| --- | --- |", "| sif_rpt_type | _강조_ |" }
vim.api.nvim_buf_set_lines(source, 0, -1, false, lines)
vim.bo[source].filetype = "markdown"
local reader = assert(plugin.reader_preview())
local rendered = vim.api.nvim_buf_get_lines(reader, 0, -1, false)
assert(table.concat(rendered, "\n"):find("sif_rpt_type", 1, true), "Reader must preserve the identifier")
local width
for _, line in ipairs(rendered) do
  if line:match("^[╭├╰│]") then
    local current = vim.api.nvim_strwidth(line)
    width = width or current
    assert(current == width, "Table borders must stay aligned")
  end
end
assert(vim.deep_equal(vim.api.nvim_buf_get_lines(source, 0, -1, false), lines), "Source must stay unchanged")
plugin.close_reader()
print("Passed Reader integration and table alignment checks")
