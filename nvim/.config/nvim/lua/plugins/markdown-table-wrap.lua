-- 긴 표 셀을 원본 수정 없이 시각적으로 줄바꿈 (render-markdown 보조)
-- 표 렌더링 소유권: pipe_table은 이 플러그인이 담당 (markdown.lua에서 render-markdown 쪽은 비활성화)
return {
  'ice345/markdown-table-wrap.nvim',
  ft = { 'markdown' },
  opts = {
    -- Markdown 파일을 열면 표를 원본 버퍼 위에 Inline으로 렌더링.
    auto_preview = true,
    preview_mode = 'inline',
    reader = {
      auto_open = 'never',
      wrap = true,
      breakindent = true,
      conceallevel = 2,
      concealcursor = 'nvc',
    },

    -- 창 너비에 맞춰 열 배분
    fit_to_window = true,
    max_width_ratio = 0.9,
    min_col_width = 8,
    max_col_width = 50,

    -- render-markdown의 round preset과 시각적으로 통일
    table_border = 'rounded',
    use_unicode_border = true,

    highlight_preset = 'catppuccin',

    -- gx 등 기존 매핑은 건드리지 않음
    map_gx = false,
  },
  keys = {
    { '<localleader>w', '<cmd>MarkdownTableToggleReader<cr>', ft = 'markdown', desc = 'Markdown table [W]rap reader toggle' },
    { '<localleader>i', '<cmd>MarkdownTableToggleInline<cr>', ft = 'markdown', desc = 'Markdown table [I]nline toggle' },
    { '<localleader>e', '<cmd>MarkdownTableEditSource<cr>', ft = 'markdown', desc = 'Markdown table [E]dit source' },
  },
}
