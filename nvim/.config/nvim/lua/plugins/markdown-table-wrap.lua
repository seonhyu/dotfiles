-- 긴 표 셀을 원본 수정 없이 시각적으로 줄바꿈 (render-markdown 보조)
-- 표 렌더링 소유권: pipe_table은 이 플러그인이 담당 (markdown.lua에서 render-markdown 쪽은 비활성화)
--
-- 기본 뷰는 Reader. 플러그인 문서가 "native wrap 문서에는 Reader가 가장 견고하다"고 권고한다.
-- Inline은 원본 줄 위에 conceal/virtual text를 덮고, 셀 줄바꿈으로 늘어난 행은 가상 줄로 붙이므로
-- 줄 번호가 표 앞부분에만 붙고 커서가 표를 벗어나는 것처럼 보인다. 필요할 때만 ,i 로 켠다.
return {
  'ice345/markdown-table-wrap.nvim',
  ft = { 'markdown' },
  opts = {
    -- 표가 있는 Markdown 버퍼는 자동으로 Reader(별도 보호 버퍼)로 진입.
    -- Reader에서 i/a/o 는 원본 줄로 이동해 편집하고, :w 는 원본 파일을 저장한다.
    auto_preview = true,
    preview_mode = 'reader',
    reader = {
      auto_open = 'has_table',
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
    -- 셀 이동 (README 권장 키). 원본 `|` 를 기준으로 하므로 Source/Inline 뷰에서 동작한다.
    { ']c', '<cmd>MarkdownTableNextCell<cr>', ft = 'markdown', desc = 'Markdown table next cell' },
    { '[c', '<cmd>MarkdownTablePrevCell<cr>', ft = 'markdown', desc = 'Markdown table previous cell' },
  },
}
