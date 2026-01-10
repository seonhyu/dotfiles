-- NFC Utility functions for Korean filename handling
-- NFD (macOS) → NFC normalization

local M = {}

-- Batch normalize NFD → NFC
function M.normalize_batch_nfd_to_nfc(texts)
  if not texts or #texts == 0 then
    return texts
  end

  local input_lines = table.concat(texts, '\n')
  local escaped_input = input_lines:gsub("'", "'\\''")

  local cmd = string.format(
    [[python3 -c "
import sys
import unicodedata

lines = '''%s'''.split('\n')
for line in lines:
    print(unicodedata.normalize('NFC', line))
"]],
    escaped_input
  )

  local handle = io.popen(cmd)
  if not handle then
    return texts
  end

  local results = {}
  for line in handle:lines() do
    table.insert(results, line)
  end
  handle:close()

  if #results ~= #texts then
    return texts
  end

  return results
end

-- Get normalized file list (using fd, respects .gitignore)
function M.get_normalized_files(opts)
  opts = opts or {}
  local cwd = opts.cwd or vim.fn.getcwd()

  local fd_cmd = string.format("cd '%s' && fd --type f --hidden --exclude .git --absolute-path", cwd:gsub("'", "\\'"))
  if opts.max_depth then
    fd_cmd = fd_cmd .. string.format(' --max-depth %d', opts.max_depth)
  end

  local handle = io.popen(fd_cmd)
  if not handle then
    return {}
  end

  local file_paths = {}
  local relative_paths = {}
  for line in handle:lines() do
    table.insert(file_paths, line)
    local relative_path = line:gsub('^' .. cwd:gsub('([%^%$%(%)%%%.%[%]%*%+%-%?])', '%%%1') .. '/', '')
    table.insert(relative_paths, relative_path)
  end
  handle:close()

  local normalized_paths = M.normalize_batch_nfd_to_nfc(relative_paths)

  local files = {}
  for i, path in ipairs(file_paths) do
    table.insert(files, {
      path = path,
      display = normalized_paths[i],
      ordinal = normalized_paths[i],
    })
  end

  return files
end

-- Telescope find_files with NFD fix
function M.find_files_nfc(opts)
  opts = opts or {}
  local pickers = require('telescope.pickers')
  local finders = require('telescope.finders')
  local sorters = require('telescope.sorters')
  local actions = require('telescope.actions')
  local action_state = require('telescope.actions.state')

  local files = M.get_normalized_files(opts)

  pickers
    .new(opts, {
      prompt_title = 'Find Files (Korean NFD Fixed)',
      finder = finders.new_table({
        results = files,
        entry_maker = function(entry)
          return {
            value = entry.path,
            display = entry.display,
            ordinal = entry.ordinal,
            path = entry.path,
          }
        end,
      }),
      sorter = sorters.get_generic_fuzzy_sorter(opts),
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          if selection then
            vim.cmd('edit ' .. vim.fn.fnameescape(selection.path))
          end
        end)

        return true
      end,
    })
    :find()
end

return M
