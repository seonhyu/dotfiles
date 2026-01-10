-- Markdown plugins
return {
  -- Table mode (org-mode style)
  {
    'dhruvasagar/vim-table-mode',
    ft = { 'markdown' },
    config = function()
      vim.g.table_mode_corner = '|'
      vim.g.table_mode_corner_corner = '|'
      vim.g.table_mode_header_fillchar = '-'

      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'markdown',
        callback = function()
          vim.cmd('TableModeEnable')

          local opts = { buffer = true, silent = true, noremap = false }
          vim.keymap.set('n', '<Tab>', '<Plug>(table-mode-motion-right)', vim.tbl_extend('force', opts, { desc = 'Table: next cell' }))
          vim.keymap.set('n', '<S-Tab>', '<Plug>(table-mode-motion-left)', vim.tbl_extend('force', opts, { desc = 'Table: previous cell' }))
        end,
      })
    end,
  },

  -- Markdown preview
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = function()
      vim.fn['mkdp#util#install']()
    end,
    init = function()
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 0
      vim.g.mkdp_refresh_slow = 0
      vim.g.mkdp_command_for_global = 0
      vim.g.mkdp_open_to_the_world = 0
      vim.g.mkdp_open_ip = ''
      vim.g.mkdp_port = ''
      vim.g.mkdp_browser = ''
      vim.g.mkdp_echo_preview_url = 1
      vim.g.mkdp_browserfunc = ''
      vim.g.mkdp_theme = 'light'
      vim.g.mkdp_highlight_css = ''
      vim.g.mkdp_page_title = '「${name}」'

      vim.g.mkdp_preview_options = {
        mkit = { breaks = true },
        katex = {},
        uml = {},
        maid = {
          theme = 'neutral',
          themeCSS = [[
.node {font-size: 14px;}
.edgeLabel {font-size: 12px;}
.label foreignObject { overflow: visible !important; }
.cluster foreignObject { overflow: visible !important; }
.edgeLabel foreignObject { overflow: visible !important; }
]],
          startOnLoad = true,
          flowchart = {
            useMaxWidth = true,
            curve = 'basis',
            htmlLabels = true,
            wrap = true,
            nodeSpacing = 30,
            rankSpacing = 30,
          },
          sequence = {
            useMaxWidth = true,
            mirrorActors = false,
          },
          state = {
            useMaxWidth = true,
          },
          gantt = {
            useMaxWidth = false,
          },
        },
        disable_sync_scroll = 0,
        sync_scroll_type = 'middle',
        hide_yaml_meta = 1,
        sequence_diagrams = {},
        flowchart_diagrams = {},
        content_editable = false,
        disable_filename = 0,
        toc = {},
      }
    end,
  },
}
