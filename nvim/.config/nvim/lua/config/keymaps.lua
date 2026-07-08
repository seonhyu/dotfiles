-- Keymaps
-- Includes Spacemacs-style keybindings

local function map(mode, key, cmd, desc, opts)
  opts = opts or {}
  opts.desc = desc
  vim.keymap.set(mode, key, cmd, opts)
end

-- Basic keymaps
map('n', '<Esc>', '<cmd>nohlsearch<CR>', 'Clear search highlights')
map('n', '<leader>q', vim.diagnostic.setloclist, 'Open diagnostic [Q]uickfix list')
map('t', '<Esc><Esc>', '<C-\\><C-n>', 'Exit terminal mode')

-- ============================================================================
-- Spacemacs-style keymaps
-- ============================================================================

local utils = require('utils.nfc')

-- File operations (SPC f)
map('n', '<leader>ff', function()
  utils.find_files_nfc()
end, '[F]ind [F]iles (Korean NFD Fixed)')
map('n', '<leader>fd', function()
  local current_dir = vim.fn.expand '%:p:h'
  utils.find_files_nfc {
    cwd = current_dir,
    max_depth = 1,
  }
end, '[F]ind files in current [D]irectory')
map('n', '<leader>fD', function()
  utils.find_files_nfc {
    cwd = vim.fn.expand '%:p:h',
  }
end, '[F]ind files and [D]irs in current directory')
map('n', '<leader>fr', '<cmd>Telescope oldfiles<cr>', '[F]ind [R]ecent files')
map('n', '<leader>fs', '<cmd>w<cr>', '[F]ile [S]ave')
map('n', '<leader>fS', '<cmd>wa<cr>', '[F]ile [S]ave all')

-- Buffer operations (SPC b)
map('n', '<leader>bb', '<cmd>Telescope buffers<cr>', '[B]uffer list')
map('n', '<leader>bd', '<cmd>bprevious | bdelete #<cr>', '[B]uffer [D]elete')
map('n', '<leader>bD', '<cmd>bd!<cr>', '[B]uffer [D]elete force')
map('n', '<leader>bn', '<cmd>bnext<cr>', '[B]uffer [N]ext')
map('n', '<leader>bp', '<cmd>bprev<cr>', '[B]uffer [P]revious')
map('n', '<leader>br', '<cmd>e<cr>', '[B]uffer [R]eload')
map('n', '<leader>bO', function()
  local current_buf = vim.api.nvim_get_current_buf()
  local buffers = vim.api.nvim_list_bufs()
  for _, buf in ipairs(buffers) do
    if buf ~= current_buf and vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted then
      vim.api.nvim_buf_delete(buf, {})
    end
  end
end, '[B]uffer [O]thers (close others)')

-- Window operations (SPC w)
map('n', '<leader>wh', '<C-w>h', '[W]indow focus left')
map('n', '<leader>wj', '<C-w>j', '[W]indow focus down')
map('n', '<leader>wk', '<C-w>k', '[W]indow focus up')
map('n', '<leader>wl', '<C-w>l', '[W]indow focus right')
map('n', '<leader>ws', '<C-w>s', '[W]indow [S]plit horizontal')
map('n', '<leader>wv', '<C-w>v', '[W]indow split [V]ertical')
map('n', '<leader>wd', '<C-w>c', '[W]indow [D]elete')
map('n', '<leader>wo', '<C-w>o', '[W]indow [O]nly')
map('n', '<leader>w=', '<C-w>=', '[W]indow balance')

-- Project operations (SPC p)
map('n', '<leader>pf', function()
  utils.find_files_nfc()
end, '[P]roject [F]ind files')
map('n', '<leader>pg', '<cmd>Telescope live_grep<cr>', '[P]roject [G]rep')
map('n', '<leader>pr', '<cmd>Telescope oldfiles<cr>', '[P]roject [R]ecent files')
map('n', '<leader>ps', '<cmd>Telescope grep_string<cr>', '[P]roject [S]earch current word')

-- Search operations (SPC s)
map('n', '<leader>sf', '<cmd>Telescope live_grep<cr>', '[S]earch [F]ull text (grep)')
map('n', '<leader>sp', '<cmd>Telescope live_grep<cr>', '[S]earch [P]roject')
map('n', '<leader>sg', '<cmd>Telescope live_grep<cr>', '[S]earch [G]rep')
map('n', '<leader>ss', '<cmd>Telescope grep_string<cr>', '[S]earch [S]tring (current word)')
map('n', '<leader>sd', '<cmd>Telescope diagnostics<cr>', '[S]earch [D]iagnostics')
map('n', '<leader>sr', '<cmd>Telescope resume<cr>', '[S]earch [R]esume')
map('n', '<leader>sb', '<cmd>Telescope current_buffer_fuzzy_find<cr>', '[S]earch [B]uffer')

-- Help operations (SPC h)
map('n', '<leader>hh', '<cmd>Telescope help_tags<cr>', '[H]elp tags')
map('n', '<leader>hk', '<cmd>Telescope keymaps<cr>', '[H]elp [K]eymaps')
map('n', '<leader>hf', '<cmd>Telescope help_tags<cr>', '[H]elp [F]unction')
map('n', '<leader>hm', '<cmd>Telescope man_pages<cr>', '[H]elp [M]an pages')

-- Code operations (SPC c)
map('n', '<leader>cf', function()
  require('conform').format { async = true, lsp_format = 'fallback' }
end, '[C]ode [F]ormat')
map('n', '<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
map('n', '<leader>cr', vim.lsp.buf.rename, '[C]ode [R]ename')
map('n', '<leader>cd', vim.lsp.buf.definition, '[C]ode [D]efinition')
map('n', '<leader>cD', vim.lsp.buf.declaration, '[C]ode [D]eclaration')
map('n', '<leader>ci', vim.lsp.buf.implementation, '[C]ode [I]mplementation')
map('n', '<leader>ct', vim.lsp.buf.type_definition, '[C]ode [T]ype definition')
map('n', '<leader>cR', vim.lsp.buf.references, '[C]ode [R]eferences')

-- Toggle operations (SPC t)
map('n', '<leader>tn', '<cmd>set number!<cr>', '[T]oggle line [N]umbers')
map('n', '<leader>tr', '<cmd>set relativenumber!<cr>', '[T]oggle [R]elative numbers')
map('n', '<leader>tw', '<cmd>set wrap!<cr>', '[T]oggle [W]rap')
map('n', '<leader>ts', '<cmd>set spell!<cr>', '[T]oggle [S]pell check')
map('n', '<leader>th', function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, '[T]oggle inlay [H]ints')

-- Git operations (SPC g) - Magit-style with lazygit
map('n', '<leader>gg', '<cmd>LazyGit<cr>', '[G]it status (lazygit)')
map('n', '<leader>gs', '<cmd>LazyGit<cr>', '[G]it [S]tatus')
map('n', '<leader>gl', '<cmd>LazyGitFilter<cr>', '[G]it [L]og')
map('n', '<leader>gf', '<cmd>LazyGitCurrentFile<cr>', '[G]it current [F]ile history')
map('n', '<leader>gc', '<cmd>LazyGit<cr>', '[G]it [C]ommit')
map('n', '<leader>gp', '<cmd>LazyGit<cr>', '[G]it [P]ush/Pull')
map('n', '<leader>gb', '<cmd>LazyGit<cr>', '[G]it [B]ranch')
map('n', '<leader>gd', '<cmd>LazyGit<cr>', '[G]it [D]iff')
map('n', '<leader>gm', '<cmd>LazyGit<cr>', '[G]it [M]erge')
map('n', '<leader>gr', '<cmd>LazyGit<cr>', '[G]it [R]ebase')
map('n', '<leader>gt', '<cmd>LazyGit<cr>', '[G]it s[T]ash')
-- Buffer-level git operations using gitsigns
map('n', '<leader>ghs', '<cmd>Gitsigns stage_hunk<cr>', '[G]it [H]unk [S]tage')
map('n', '<leader>ghr', '<cmd>Gitsigns reset_hunk<cr>', '[G]it [H]unk [R]eset')
map('n', '<leader>ghp', '<cmd>Gitsigns preview_hunk<cr>', '[G]it [H]unk [P]review')
map('n', '<leader>ghu', '<cmd>Gitsigns undo_stage_hunk<cr>', '[G]it [H]unk [U]ndo stage')
map('n', '<leader>ghb', '<cmd>Gitsigns blame_line<cr>', '[G]it [H]unk [B]lame line')

-- Open operations (SPC o)
map('n', '<leader>oP', '<cmd>Neotree toggle<cr>', '[O]pen [P]roject tree')
map('n', '<leader>op', '<cmd>Neotree reveal<cr>', '[O]pen tree at current buffer [P]ath')
map('n', '<leader>oe', function()
  local file = vim.fn.expand '%:p'
  if file == '' then
    vim.notify('No file in current buffer', vim.log.levels.WARN)
    return
  end
  vim.fn.system('emacsclient -n "' .. file .. '"')
  vim.notify('Opened in Emacs: ' .. vim.fn.expand '%:t', vim.log.levels.INFO)
end, '[O]pen [E]macs')

-- Error operations (SPC e)
map('n', '<leader>en', vim.diagnostic.goto_next, '[E]rror [N]ext')
map('n', '<leader>ep', vim.diagnostic.goto_prev, '[E]rror [P]revious')
map('n', '<leader>el', '<cmd>Telescope diagnostics<cr>', '[E]rror [L]ist')
map('n', '<leader>ee', vim.diagnostic.open_float, '[E]rror 상세 보기')

-- Quick access
map('n', '<leader><leader>', '<cmd>Telescope buffers<cr>', 'Switch buffer')
map('n', '<leader><tab>', function()
  local cur = vim.api.nvim_get_current_buf()
  local bufs = vim.fn.getbufinfo { buflisted = 1 }
  local best = nil
  for _, b in ipairs(bufs) do
    if b.bufnr ~= cur and (not best or b.lastused > best.lastused) then
      best = b
    end
  end
  if best then
    vim.api.nvim_set_current_buf(best.bufnr)
  else
    vim.notify('No other buffer', vim.log.levels.INFO)
  end
end, 'Switch to last used buffer')
map('n', '<leader>/', '<cmd>Telescope current_buffer_fuzzy_find<cr>', 'Search in current buffer')

-- Quit operations (SPC q)
map('n', '<leader>qq', '<cmd>qa<cr>', '[Q]uit all')
map('n', '<leader>qQ', '<cmd>qa!<cr>', '[Q]uit all force')
map('n', '<leader>qr', '<cmd>source %<cr>', '[Q]uick [R]eload config')

-- vim: ts=2 sts=2 sw=2 et
