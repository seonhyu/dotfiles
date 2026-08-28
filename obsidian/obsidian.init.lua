-- ============================================================================
-- obsidian.init.lua — Vim Motions 설정
--
-- Neovim(LazyVim + Spacemacs 키맵)의 muscle memory를 Obsidian으로 이식한다.
--
-- 정본: ~/repos/personal/dotfiles/obsidian/config/obsidian.init.lua
-- 적용: ~/WIKI/obsidian.init.lua (stow 심볼릭 링크, vault 루트에 위치)
--
-- 전제 조건:
--   설정 > 편집기 > Vim 키 바인딩         : OFF (플러그인 fork 엔진 사용)
--   설정 > Vim Motions > Configuration mode : Lua only
--
-- 설계 원칙:
--   1. Vim Motions 기본값이 이미 Neovim과 같으면 재정의하지 않는다.
--      (surround ys/ds/cs, 텍스트 오브젝트, <C-w>hjkl, gt/gT, zc/zo, <C-o>/<C-i>)
--   2. 기본값이 Neovim 습관과 충돌할 때만 재배치한다.
--   3. Obsidian에만 있는 개념은 새 namespace(n)에 모은다.
--
-- ⚠ 충돌 해소 요약 (Vim Motions 기본값 vs 내 Neovim 설정)
--   <leader>h : 기본=Harpoon    / Neovim=Help    → Help를 <leader>H로 이동
--   <leader>t : 기본=Table      / Neovim=Toggle  → Toggle을 <leader>T로 이동
--   <leader><leader> : 기본=EasyMotion / Neovim=버퍼 전환 → EasyMotion 유지
--                      (버퍼 전환은 <leader>bb / <C-6>)
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 1. Leader — Neovim(init.lua)과 동일
-- ----------------------------------------------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- ----------------------------------------------------------------------------
-- 2. 옵션 — Neovim options.lua에서 의미가 통하는 것만 이식
-- ----------------------------------------------------------------------------
vim.opt.scrolloff = 10          -- options.lua와 동일
vim.opt.clipboard = "unnamedplus"  -- options.lua와 동일
vim.opt.number = true           -- 줄 번호 표시
vim.opt.relativenumber = true   -- 상대 줄 번호 (hybrid)
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.tabstop = 2             -- options.lua: 2칸
vim.opt.shiftwidth = 2
vim.opt.textwidth = 80          -- gq/gw 줄바꿈 폭

-- which-key — Neovim의 which-key.nvim(delay = 0)에 대응
vim.opt.whichkey = "all"        -- 'off' | 'leader' | 'all' (boolean 아님)
vim.opt.whichkeydelay = 300     -- options.lua의 timeoutlen = 300
vim.opt.whichkeyicons = true

-- 기능 토글 (Neovim 대응물이 있는 것들을 명시적으로 켠다)
vim.opt.textobjects = true      -- mini.ai 대응 (마크다운 인식 텍스트 오브젝트)
vim.opt.navigation = true       -- ]h [h ]l ]n 구조 이동
vim.opt.harpoon = true          -- Harpoon 대응
vim.opt.oil = true              -- Oil 대응 (설정 키는 oilexplorer가 아니라 oil)
vim.opt.picker = true           -- 내장 telescope 스타일 picker (Telescope 대응)
vim.opt.workspacenav = true     -- 페인/탭/사이드바 키보드 제어
vim.opt.jumplist = true         -- <C-o>/<C-i>
vim.opt.undotree = true
vim.opt.hardwrap = true         -- gq/gw
vim.opt.tablenav = true
vim.opt.flash = true
vim.opt.easymotion = true
vim.opt.hintmode = true
vim.opt.signcolumn = "auto"
-- 접기(fold)는 기본 활성이며 vim.opt로 토글할 수 없다 (설정 UI에서만 변경).

-- 한글(CJK) 입력기 자동 전환 — Normal 모드 복귀 시 영문으로.
-- Neovim에는 없지만 Obsidian에서 한글 노트를 쓸 때 반드시 필요하다.
vim.obsidian.im.enabled = true
vim.obsidian.im.auto = true

-- ----------------------------------------------------------------------------
-- 3. 헬퍼
-- ----------------------------------------------------------------------------
local leader = vim.obsidian.leader
local wk = vim.obsidian.whichkey

--- Lua 콜백 키맵 (desc 필수 — which-key가 함수를 introspect하지 못한다)
local function map(mode, key, fn, desc)
  vim.keymap.set(mode, key, fn, { desc = desc })
end

-- ============================================================================
-- 4. 그대로 유지 — Vim Motions 기본값이 이미 Neovim과 같다
-- ============================================================================
--
--   Surround (mini.surround와 동일)
--     ys{motion}{char} / ds{char} / cs{old}{new} / yss / S(visual)
--
--   텍스트 오브젝트 (mini.ai 상위 호환)
--     iw aw i" a" ip ap  +  i* a* (bold) i` a` (code) i= a= (highlight)
--     il al (link) iD aD (wikilink) iC aC (code block) iB aB (blockquote)
--
--   윈도우/탭 (Neovim <C-w> 계열과 동일)
--     <C-w>h/j/k/l  포커스 이동      <C-w>v / <C-w>s  분할
--     <C-w>c        탭 닫기          gt / gT          탭 순환
--
--   점프 (Neovim과 동일)
--     <C-o> 뒤로   <C-i> 앞으로   '' 직전 위치
--
--   접기 (Neovim treesitter fold와 동일)
--     zo zc za zR zM zj zk
--
--   구조 이동 (Neovim treesitter 이동에 대응)
--     ]h [h 제목   ]1..]6 제목 레벨   ]l [l 목록   ]n [n 링크
--
--   Ex 명령 (Neovim과 동일한 감각)
--     :sp :vs :e :w :q :grep
--
-- → 위 항목은 재정의하지 않는다. 손이 이미 알고 있다.
-- ============================================================================

-- ============================================================================
-- 5. SPC f — 파일/찾기 (File / Find)
--    Vim Motions 기본 picker가 이미 <leader>ff, <leader>fr을 Neovim과
--    똑같이 쓴다. 기본값을 살리고 Neovim에만 있던 것을 채운다.
--
--    기본 제공: ff(files) fg(grep) fb(buffers) fh(headings) fo(outline)
--               fk(backlinks) ft(tags) fr(recent) fm(marks) fR(registers)
--               fp(resume picker)
-- ============================================================================

wk.set_group("<leader>f", "Find/File")

-- Neovim의 <leader>fd / fD — 현재 노트가 있는 폴더를 Oil로 연다.
map("n", "<leader>fd", function()
  vim.cmd("Oil")
end, "[F]ind in current [D]irectory (Oil)")

map("n", "<leader>fD", function()
  vim.cmd("Oil .")
end, "[F]ind from vault root (Oil)")

-- Neovim의 <leader>fs / fS — Obsidian은 자동 저장이지만 손버릇을 살린다.
map("n", "<leader>fs", function()
  vim.cmd("w")
end, "[F]ile [S]ave")

map("n", "<leader>fS", function()
  vim.cmd("wa")
end, "[F]ile [S]ave all")

leader.add({
  { "fn", "file-explorer:new-file", desc = "[F]ile [N]ew" },
  { "fy", "workspace:copy-path", desc = "[F]ile path [Y]ank" },
  { "fY", "workspace:copy-url", desc = "[F]ile [Y]ank Obsidian URL" },
})

-- Neovim의 <leader>fr(rename)은 picker의 fr(recent)과 충돌하므로 SPC c로.

-- ============================================================================
-- 6. SPC b — 버퍼(탭)
--    Neovim: bb/bd/bD/bn/bp/br/bO
-- ============================================================================

wk.set_group("<leader>b", "Buffer")

-- 플러그인이 등록한 실제 Obsidian 명령 ID를 직접 실행한다.
-- 문자열 RHS(":buffers<CR>")는 키 시퀀스를 재생하므로 빠르게 입력하면
-- ex 명령줄이 열리기 전에 키가 앞질러 가고 <CR>가 새 탭을 연다.
map("n", "<leader>bb", function()
  vim.obsidian.run_command("vim-motions:picker-buffers")
end, "[B]uffer list")

leader.add({
  { "bd", "workspace:close", desc = "[B]uffer [D]elete" },
  { "bD", "workspace:close", desc = "[B]uffer [D]elete force" },
  { "bn", "workspace:next-tab", desc = "[B]uffer [N]ext" },
  { "bp", "workspace:previous-tab", desc = "[B]uffer [P]revious" },
  { "bO", "workspace:close-others", desc = "[B]uffer [O]thers 닫기" },
})

map("n", "<leader>br", function()
  vim.obsidian.run_command("app:reload")
end, "[B]uffer [R]eload")

-- ============================================================================
-- 7. SPC w — 윈도우(페인)
--    Neovim: wh/wj/wk/wl/ws/wv/wd/wo
--    <C-w>hjkl은 기본 제공되므로 SPC w 계열만 보강한다.
-- ============================================================================

wk.set_group("<leader>w", "Window")

-- ⚠ vim.ob.focus 유효 방향: left / right / top / bottom (up/down 아님)
map("n", "<leader>wh", function() vim.ob.focus("left") end, "[W]indow focus left")
map("n", "<leader>wj", function() vim.ob.focus("bottom") end, "[W]indow focus down")
map("n", "<leader>wk", function() vim.ob.focus("top") end, "[W]indow focus up")
map("n", "<leader>wl", function() vim.ob.focus("right") end, "[W]indow focus right")
map("n", "<leader>ws", function() vim.ob.split("horizontal") end, "[W]indow [S]plit horizontal")
map("n", "<leader>wv", function() vim.ob.split("vertical") end, "[W]indow split [V]ertical")
map("n", "<leader>wd", function() vim.ob.close_leaf() end, "[W]indow [D]elete")

leader.set("wo", "workspace:close-others", { desc = "[W]indow [O]nly" })

-- ============================================================================
-- 8. SPC p — 프로젝트(저장소) / SPC s — 검색
--    Neovim: pf/pg/pr/ps, sf/sp/sg/ss/sb/sr
-- ============================================================================

wk.set_group("<leader>p", "Project")
wk.set_group("<leader>s", "Search")

map("n", "<leader>pf", function() vim.obsidian.pick("files") end, "[P]roject [F]ind files")
map("n", "<leader>pg", function() vim.obsidian.pick("grep") end, "[P]roject [G]rep")
map("n", "<leader>pr", function() vim.obsidian.pick("recent") end, "[P]roject [R]ecent")

map("n", "<leader>sf", function() vim.obsidian.pick("grep") end, "[S]earch [F]ull text")
map("n", "<leader>sp", function() vim.obsidian.pick("grep") end, "[S]earch [P]roject")
map("n", "<leader>sg", function() vim.obsidian.pick("grep") end, "[S]earch [G]rep")
map("n", "<leader>sr", function() vim.obsidian.pick("resume") end, "[S]earch [R]esume")
map("n", "<leader>st", function() vim.obsidian.pick("tags") end, "[S]earch [T]ags")
map("n", "<leader>so", function() vim.obsidian.pick("outline") end, "[S]earch [O]utline")

-- 현재 단어로 검색 (Neovim의 grep_string)
map("n", "<leader>ss", function()
  local word = vim.fn.expand("<cword>")
  vim.obsidian.pick("grep", { query = word })
end, "[S]earch [S]tring (현재 단어)")

-- 문서 내 검색 (Neovim의 <leader>/ = current_buffer_fuzzy_find)
map("n", "<leader>/", function()
  vim.obsidian.pick("headings")
end, "Search in current note")

map("n", "<leader>sb", function()
  vim.obsidian.pick("headings")
end, "[S]earch [B]uffer")

-- ============================================================================
-- 9. SPC o — 열기(Open)
--    Neovim: oP(트리 토글) op(현재 위치) oe(Emacs)
-- ============================================================================

wk.set_group("<leader>o", "Open")

leader.add({
  { "oP", "file-explorer:open", desc = "[O]pen [P]roject tree" },
  { "op", "file-explorer:reveal-active-file", desc = "[O]pen tree at [P]ath" },
  { "og", "graph:open", desc = "[O]pen [G]raph" },
  { "oG", "graph:open-local", desc = "[O]pen local [G]raph" },
  { "ob", "backlink:open", desc = "[O]pen [B]acklinks" },
  { "oo", "outgoing-links:open", desc = "[O]pen [O]utgoing links" },
  { "oc", "canvas:new-file", desc = "[O]pen new [C]anvas" },
})

-- Oil 탐색기 (Neovim의 Neo-tree \ 에 대응)
map("n", "<leader>oe", function()
  vim.cmd("Oil")
end, "[O]pen [E]xplorer (Oil)")

map("n", "\\", function()
  vim.cmd("Oil")
end, "Oil explorer")

-- ============================================================================
-- 10. SPC T — 토글(Toggle)
--     ⚠ Neovim은 <leader>t였지만 Vim Motions 기본 <leader>t는 표(Table)다.
--       표 편집이 마크다운에서 더 자주 쓰이므로 기본값을 살리고
--       Toggle을 대문자 T로 옮긴다.
-- ============================================================================

wk.set_group("<leader>T", "Toggle")
wk.set_group("<leader>t", "Table")   -- Vim Motions 기본값 유지

-- vim.opt.<key>는 __index 메타메서드로 값을 바로 돌려준다 (:get() 없음)
map("n", "<leader>Tn", function()
  vim.opt.number = not vim.opt.number
end, "[T]oggle line [N]umbers")

map("n", "<leader>Tr", function()
  vim.opt.relativenumber = not vim.opt.relativenumber
end, "[T]oggle [R]elative numbers")

leader.add({
  { "Tw", "editor:toggle-readable-line-length", desc = "[T]oggle [W]rap width" },
  { "Ts", "editor:toggle-source", desc = "[T]oggle [S]ource mode" },
  { "Tp", "markdown:toggle-preview", desc = "[T]oggle [P]review" },
  { "Tf", "workspace:toggle-pin", desc = "[T]oggle pin" },
})

map("n", "<leader>Tl", function() vim.ob.ui.sidebar("left") end, "[T]oggle [L]eft sidebar")
map("n", "<leader>TR", function() vim.ob.ui.sidebar("right") end, "[T]oggle [R]ight sidebar")

-- ============================================================================
-- 11. SPC c — 내용(Content) — Neovim의 SPC c(Code)에 대응
--     LSP 개념을 Obsidian 개념으로 옮긴다:
--       definition → 링크 따라가기 / references → 백링크
-- ============================================================================

wk.set_group("<leader>c", "Content")

map("n", "<leader>cd", function() vim.ob.follow_link() end, "[C]ontent [D]efinition (링크)")
map("n", "<leader>cR", function() vim.ob.backlinks() end, "[C]ontent [R]eferences (백링크)")
map("n", "<leader>cr", function() vim.ob.rename() end, "[C]ontent [R]ename")
map("n", "<leader>cc", function() vim.ob.toggle_checkbox() end, "[C]ontent toggle [C]heckbox")
map("n", "<leader>ca", function() vim.ob.ui.command_palette() end, "[C]ontent [A]ction (팔레트)")

leader.add({
  { "ci", "editor:insert-wikilink", desc = "[C]ontent [I]nsert wikilink" },
  { "cl", "editor:insert-link", desc = "[C]ontent insert [L]ink" },
  { "ce", "editor:insert-embed", desc = "[C]ontent [E]mbed" },
  { "ct", "editor:insert-tag", desc = "[C]ontent insert [T]ag" },
  { "ck", "editor:insert-callout", desc = "[C]ontent insert callout" },
  { "cm", "editor:insert-mathblock", desc = "[C]ontent insert [M]ath block" },
  { "cC", "editor:insert-codeblock", desc = "[C]ontent insert [C]ode block" },
  { "cs", "editor:set-heading", desc = "[C]ontent [S]et heading" },
  { "cx", "editor:clear-formatting", desc = "[C]ontent clear formatting" },
})

-- Obsidian에는 문서 포맷 명령이 없다. Vim Motions의 hardwrap 연산자(gq)가
-- conform.nvim 포맷의 실질적 대응물이므로 문단 전체를 textwidth로 정렬한다.
map("n", "<leader>cf", function()
  vim.cmd("normal gqap")
end, "[C]ontent [F]ormat (문단 정렬)")

leader.add({
  { "cb", "editor:toggle-bullet-list", desc = "[C]ontent toggle [B]ullet" },
  { "cn", "editor:toggle-numbered-list", desc = "[C]ontent toggle [N]umbered" },
  { "cq", "editor:toggle-blockquote", desc = "[C]ontent toggle blockquote" },
})

-- ============================================================================
-- 12. SPC H — 도움말(Help)
--     ⚠ Neovim은 <leader>h였지만 Vim Motions 기본 <leader>h는 Harpoon이다.
--       Harpoon은 매일 쓰는 기능이므로 기본값을 살리고 Help를 H로 옮긴다.
-- ============================================================================

wk.set_group("<leader>H", "Help")
wk.set_group("<leader>h", "Harpoon")  -- Vim Motions 기본값 유지

map("n", "<leader>Hh", function() vim.ob.ui.command_palette() end, "[H]elp (명령 팔레트)")
-- :map 은 등록된 ex 명령이 아니다. which-key 팝업(SPC 누르고 대기)이
-- 실질적인 키맵 목록이며, 전체 목록은 설정 UI에서 본다.
map("n", "<leader>Hk", function()
  vim.obsidian.run_command("app:open-settings")
end, "[H]elp [K]eymaps (설정)")
map("n", "<leader>Hc", function() vim.ob.ui.command_palette() end, "[H]elp [C]ommands")

-- ============================================================================
-- 13. Harpoon — Neovim의 Harpoon 습관 그대로
--     기본 제공: <leader>ha 고정 / <leader>ht 토글 / <leader>hp 목록
--                <leader>1..9 슬롯 점프 / <leader>hn <leader>hN 순회
--     → 재정의 없음. 기본값이 이미 Harpoon 관례와 같다.
-- ============================================================================

-- ============================================================================
-- 14. SPC q — 종료(Quit)
-- ============================================================================

wk.set_group("<leader>q", "Quit")

map("n", "<leader>qq", function() vim.ob.close_leaf() end, "[Q]uit (탭 닫기)")
leader.set("qr", "app:reload", { desc = "[Q]uick [R]eload" })

-- ============================================================================
-- 15. SPC n — 노트(Note) : Obsidian 전용 신규 namespace
--     Daily Note / Weekly Review / QuickAdd / Dataview
--     Neovim에 대응물이 없어 충돌하지 않는 n을 새로 쓴다.
-- ============================================================================

wk.set_group("<leader>n", "Note")

-- --- Daily Note ------------------------------------------------------------
-- 코어 daily-notes 플러그인 + templates/journal.md (Templater 폴더 템플릿)
map("n", "<leader>nn", function() vim.ob.daily() end, "[N]ote: 오늘 일지")
map("n", "<leader>nd", function() vim.ob.daily() end, "[N]ote [D]aily")

leader.add({
  { "np", "daily-notes:goto-prev", desc = "[N]ote daily [P]rev" },
  { "nx", "daily-notes:goto-next", desc = "[N]ote daily ne[X]t" },
})

-- --- Weekly Review ---------------------------------------------------------
-- ISO 8601 주차(YYYY-Www) 노트를 raw/journal/reviews/ 아래에 만든다.
-- 이미 있으면 열고, 없으면 Dataview 쿼리가 박힌 템플릿으로 생성한다.
map("n", "<leader>nw", function()
  -- ISO 8601: 그 주의 목요일이 속한 해가 주차의 기준 연도다.
  local now = os.date("*t")
  local today = os.time({ year = now.year, month = now.month, day = now.day, hour = 12 })
  local wday = tonumber(os.date("%w", today))
  local iso_wday = (wday == 0) and 7 or wday
  local thursday = today + (4 - iso_wday) * 86400
  local iso_year = tonumber(os.date("%Y", thursday))
  local jan4 = os.time({ year = iso_year, month = 1, day = 4, hour = 12 })
  local jan4_wday = tonumber(os.date("%w", jan4))
  local jan4_iso = (jan4_wday == 0) and 7 or jan4_wday
  local week1_monday = jan4 - (jan4_iso - 1) * 86400
  local week = math.floor((thursday - week1_monday) / (7 * 86400)) + 1

  local name = string.format("%04d-W%02d", iso_year, week)
  local path = "raw/journal/reviews/" .. name .. ".md"

  if vim.ob.fs.exists(path) then
    vim.cmd("e " .. path)
    return
  end

  local body = table.concat({
    "---",
    "type: weekly-review",
    "week: " .. name,
    "created: " .. os.date("%Y-%m-%d"),
    "tags: [review/weekly]",
    "---",
    "",
    "# 주간 회고 " .. name,
    "",
    "## 이번 주 작성한 노트",
    "",
    "```dataview",
    'TABLE file.ctime AS "작성일", file.folder AS "위치"',
    'FROM "raw"',
    "WHERE file.ctime >= date(today) - dur(7 days)",
    "SORT file.ctime DESC",
    "```",
    "",
    "## 미완료 작업",
    "",
    "```dataview",
    "TASK",
    'FROM "raw"',
    "WHERE !completed",
    "SORT file.ctime DESC",
    "LIMIT 30",
    "```",
    "",
    "## 이번 주 일지",
    "",
    "```dataview",
    "LIST",
    'FROM "raw/journal"',
    "WHERE file.day >= date(today) - dur(7 days)",
    "SORT file.day DESC",
    "```",
    "",
    "## 배운 것",
    "",
    "- ",
    "",
    "## 다음 주 초점",
    "",
    "- ",
    "",
  }, "\n")

  vim.ob.fs.create(path, body)
  vim.cmd("e " .. path)
  vim.notify("주간 회고 생성: " .. name)
end, "[N]ote [W]eekly review (주간 회고)")

-- --- QuickAdd 대응 ---------------------------------------------------------
-- 별도 QuickAdd 플러그인 없이 이미 설치된 Templater + 내장 picker로 해결한다.
map("n", "<leader>nc", function() vim.ob.new_note() end, "[N]ote [C]apture (새 노트)")
map("n", "<leader>ni", function() vim.ob.template() end, "[N]ote [I]nsert template")

-- 인박스에 한 줄 즉시 추가 — QuickAdd의 capture에 해당한다.
map("n", "<leader>na", function()
  local text = vim.fn.input("Inbox에 추가: ")
  if text == nil or text == "" then
    return
  end
  local path = "raw/todos/inbox.md"
  if not vim.ob.fs.exists(path) then
    vim.ob.fs.create(path, "---\ntype: inbox\n---\n\n# Inbox\n")
  end
  vim.ob.fs.append(path, "\n- [ ] " .. text .. " ^" .. os.date("%Y%m%d%H%M"))
  vim.notify("Inbox에 추가했습니다")
end, "[N]ote [A]dd to inbox (빠른 캡처)")

map("n", "<leader>nt", function()
  vim.cmd("e raw/todos/inbox.md")
end, "[N]ote [T]odo inbox 열기")

-- --- Dataview --------------------------------------------------------------
-- 내장 picker의 dataview 소스 — 설치된 Dataview 플러그인의 페이지를 그대로 훑는다.
map("n", "<leader>nv", function()
  vim.obsidian.pick("dataview")
end, "[N]ote data[V]iew pages (picker)")

leader.add({
  { "nq", "dataview:dataview-force-refresh-views", desc = "[N]ote dataview re-[Q]uery" },
  { "nD", "dataview:dataview-drop-cache", desc = "[N]ote [D]ataview drop cache" },
  { "nr", "dataview:dataview-rebuild-current-view", desc = "[N]ote dataview [R]ebuild view" },
})

-- --- 대시보드 / 색인 --------------------------------------------------------
map("n", "<leader>nh", function() vim.cmd("e wiki/dashboard.md") end, "[N]ote [H]ome (대시보드)")
map("n", "<leader>nI", function() vim.cmd("e wiki/index.md") end, "[N]ote [I]ndex (색인)")
map("n", "<leader>nl", function() vim.cmd("e wiki/log.md") end, "[N]ote [L]og")

-- ============================================================================
-- 16. 마크다운 전용 surround — 기존 ys/ds/cs 문법을 그대로 확장
--     Neovim에는 없지만 Obsidian에서 매일 쓰는 위키링크/수식을 추가한다.
--     사용: ysiwl → [[word]] / dsl → 링크 제거 / csl m → [[..]] → $$..$$
-- ============================================================================

vim.obsidian.surround.add({
  { "l", left = "[[", right = "]]" },      -- 위키링크
  { "m", left = "$$", right = "$$" },      -- 수식 블록
  { "h", left = "==", right = "==" },      -- 하이라이트
  { "k", left = "~~", right = "~~" },      -- 취소선
})

-- ============================================================================
-- 17. localleader(,) — Neovim after/ftplugin/markdown.lua와 대칭
-- ============================================================================

map("n", "<localleader>p", function()
  vim.obsidian.run_command("markdown:toggle-preview")
end, "Markdown [P]review toggle")

map("n", "<localleader>r", function()
  vim.obsidian.run_command("editor:toggle-source")
end, "[R]ender toggle (source/live)")

map("n", "<localleader>f", function()
  vim.cmd("normal gqap")
end, "[F]ormat paragraph (hardwrap)")

-- <localleader>t 는 표 — Neovim의 vim-table-mode 습관과 같은 자리.
map("n", "<localleader>t", function()
  vim.obsidian.run_command("editor:insert-table")
end, "Insert [T]able")

-- ============================================================================
-- 18. 편의 (Neovim 관용구)
-- ============================================================================

-- 검색 하이라이트 해제
map("n", "<Esc>", function() vim.cmd("nohlsearch") end, "Clear search highlights")

-- 시각 모드 들여쓰기 후 선택 유지
vim.keymap.set("v", "<", "<gv", { desc = "Indent left, keep selection" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right, keep selection" })

-- 직전 파일로 전환 (Neovim의 <C-6>)
map("n", "<C-6>", function()
  vim.obsidian.run_command("workspace:previous-tab")
end, "Previous file")

-- ============================================================================
-- 19. 비-편집기 컨텍스트 전역 키맵
--     그래프 뷰, 캔버스, 파일 탐색기 등 편집기가 아닐 때도 동작한다.
--     ⚠ 문자열 RHS만 지원 (Lua 콜백 불가)
-- ============================================================================

vim.obsidian.keymap.set("<leader>ff", ":obcommand switcher:open", { desc = "Find file" })
vim.obsidian.keymap.set("<leader>fg", ":obcommand global-search:open", { desc = "Grep" })
vim.obsidian.keymap.set("<leader>nn", ":obcommand daily-notes", { desc = "Daily note" })
vim.obsidian.keymap.set("<leader>oP", ":obcommand file-explorer:open", { desc = "File explorer" })

wk.set_group("<leader>", "+leader", { context = "global" })

-- vim: ts=2 sts=2 sw=2 et
