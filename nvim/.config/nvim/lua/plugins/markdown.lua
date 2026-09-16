-- Markdown plugins
return {
  -- 버퍼 내 마크다운 렌더링 (제목/목록/코드블록 시각화)
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { 'markdown' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    opts = {
      file_types = { 'markdown' },
      -- 커서가 있는 줄은 원본 문법 그대로 보여 편집이 쉽도록
      render_modes = { 'n', 'c', 't' },
      anti_conceal = { enabled = true },
      heading = {
        icons = { '# ', '## ', '### ', '#### ', '##### ', '###### ' },
        sign = false,
      },
      code = {
        sign = false,
        width = 'block',
        right_pad = 2,
      },
      bullet = {
        icons = { '●', '○', '◆', '◇' },
      },
      checkbox = {
        unchecked = { icon = '󰄱 ' },
        checked = { icon = '󰱒 ' },
      },
      -- 표는 markdown-table-wrap.nvim이 담당 (긴 셀 줄바꿈 지원, Reader 뷰).
      -- 제작자 권장대로 render-markdown 쪽 표 렌더러는 끈다.
      -- 표 편집용 vim-table-mode는 제거했다: 전역 <leader>tt/<leader>tm 을 덮어쓰고
      -- 활성화 시 <leader>tr/<leader>ts 를 가리며, <Tab> 매핑이 <C-i> 점프를 막았다.
      pipe_table = { enabled = false },
    },
  },

  -- Markdown preview
  -- 렌더링은 Neovim이 아니라 CLI(`mdpreview` -> `gh gfm-preview`)가 담당한다.
  -- Neovim은 launcher 역할만 하므로 preview용 플러그인을 두지 않는다.
  -- 키맵은 after/ftplugin/markdown.lua 참고.
}
