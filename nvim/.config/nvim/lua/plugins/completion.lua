-- Autocompletion
return {
  'saghen/blink.cmp',
  event = 'VimEnter',
  version = '1.*',
  dependencies = {
    {
      'L3MON4D3/LuaSnip',
      version = '2.*',
      build = (function()
        if vim.fn.has('win32') == 1 or vim.fn.executable('make') == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
      opts = {},
    },
    'folke/lazydev.nvim',
  },
  opts = {
    keymap = {
      preset = 'super-tab',
      ['<CR>'] = { 'accept', 'fallback' },
    },
    appearance = {
      nerd_font_variant = 'mono',
    },
    completion = {
      documentation = { auto_show = false, auto_show_delay_ms = 500 },
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev' },
      providers = {
        lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
        buffer = {
          name = 'Buffer',
          module = 'blink.cmp.sources.buffer',
          score_offset = -3,
          opts = {
            get_bufnrs = function()
              local bufs = {}
              for _, win in ipairs(vim.api.nvim_list_wins()) do
                local buf = vim.api.nvim_win_get_buf(win)
                local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
                if byte_size <= 1024 * 1024 then
                  bufs[buf] = true
                end
              end
              return vim.tbl_keys(bufs)
            end,
          },
        },
      },
    },
    snippets = { preset = 'luasnip' },
    fuzzy = { implementation = 'lua' },
    signature = { enabled = true },
  },
}
