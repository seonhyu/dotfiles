# obsidian

Obsidian을 Neovim(LazyVim + Spacemacs 키맵)처럼 쓰기 위한 [Vim Motions](https://github.com/saberzero1/motions) 설정.

기존 Neovim 손버릇을 그대로 유지하면서, Obsidian에만 있는 개념(Daily Note, 주간 회고,
빠른 캡처, Dataview)을 충돌 없는 새 namespace에 얹는다.

## 무엇을 제공하는가

| 영역 | 내용 |
| --- | --- |
| **키맵** | Spacemacs 스타일 `SPC` 네임스페이스를 Obsidian에 이식 (`f` 파일 · `b` 버퍼 · `w` 윈도우 · `s` 검색 · `c` 내용 · `n` 노트) |
| **한글 지원** | Normal 모드 복귀 시 입력기 자동 전환 (`vim.obsidian.im`) — 한글 노트 작성의 핵심 |
| **주간 회고** | `SPC n w` 로 ISO 8601 주차(`2026-W35`) 노트를 Dataview 쿼리와 함께 자동 생성 |
| **빠른 캡처** | `SPC n a` 로 편집 흐름을 끊지 않고 인박스에 한 줄 추가 (QuickAdd 플러그인 불필요) |
| **위키링크 surround** | `ysiwl` → `[[단어]]`, `dsl` 로 해제 |
| **CSS 스니펫** | 한글 본문에서 EasyMotion 라벨·커서 가독성 보정 |

### 추가 플러그인을 쓰지 않는 이유

Neovim에서 쓰던 도구 대부분은 **Vim Motions에 이미 내장**되어 있다. 따로 설치하지 않는다.

| Neovim | Obsidian | 비고 |
| --- | --- | --- |
| Telescope | 내장 picker (14개 소스) | `SPC f f`, `SPC f g`, `SPC f b` … |
| Harpoon | 내장 harpoon | `SPC h a` 고정, `SPC 1`–`SPC 9` 점프 |
| Oil | 내장 oil 탐색기 | `\` 또는 `:Oil` — 버퍼를 편집해 파일 조작 |
| mini.surround | 내장 surround | `ys` / `ds` / `cs` 동일 |
| mini.ai | 내장 텍스트 오브젝트 | `i*` `i=` `` i` `` `il` `iD` 등 마크다운 인식 |
| which-key | 내장 which-key | `whichkey = "all"` |
| Neo-tree | 코어 파일 탐색기 + oil | — |

새로 설치하는 커뮤니티 플러그인은 **Vim Motions 하나뿐**이다.
(Dataview·Templater는 이미 vault에 설치되어 있다.)

---

## 설치

> **요약** — 4·5번은 이 저장소(stow)가 처리한다. 1·2·3·6번은 Obsidian UI에서 직접 해야 한다.
> `.obsidian/`의 설정 JSON은 Obsidian이 종료 시 덮어쓰므로 파일로 관리하지 않는다.

### 1. Vim Motions 플러그인 설치

Obsidian에서 직접 설치한다 (이 저장소는 설정만 관리한다).

1. **설정 → 커뮤니티 플러그인 → 탐색**
2. `Vim Motions` 검색 → **설치** → **활성화**

### 2. 내장 Vim 모드 끄기 (필수)

Vim Motions는 자체 vim 엔진(codemirror-vim 포크)을 쓴다. 내장 모드와 겹치면
커스텀 surround·연산자 대기 EasyMotion 등이 동작하지 않는다.

- **설정 → 편집기 → Vim 키 바인딩** → **끄기**

> `.obsidian/app.json`은 Obsidian이 종료할 때 메모리 내용으로 덮어쓴다.
> 그래서 이 저장소는 해당 파일을 관리하지 않는다. 반드시 **UI에서** 끈다.

### 3. Vimrc support 끄기

`.obsidian.vimrc`를 쓰지 않는다. 키맵의 단일 진실 원천은 `obsidian.init.lua` 하나다.

- **설정 → Vim Motions → Vimrc & key bindings → Configuration mode** → **`Lua only`**

> `Lua only`가 아니면 vimrc가 함께 로드되어 키맵이 이중으로 잡힐 수 있다.

### 4. 설정 연결 (stow)

```bash
cd ~/repos/personal/dotfiles
stow -t ~/WIKI obsidian
```

`obsidian.init.lua`는 **vault 루트**(`~/WIKI/`)에 놓여야 한다. `.obsidian/` 안이 아니다.
Vim Motions는 vault 루트에서 `init.lua` → `.init.lua` → `obsidian.init.lua` 순으로 찾는다.

```bash
# 미리보기
stow -t ~/WIKI -n -v obsidian

# 해제
stow -t ~/WIKI -D obsidian
```

### 5. CSS 스니펫 켜기 (선택)

**설정 → 모양 → CSS 스니펫** → `vim-motions-cjk` 활성화

### 6. 적용

**설정 → Vim Motions → Reload configuration**, 또는 `SPC q r`(Obsidian 재시작).

---

## vault에서 함께 설정할 것

### daily-notes 코어 플러그인

`SPC n n`(오늘 일지)과 `SPC n p`/`SPC n x`(이전/다음)가 이 플러그인을 쓴다.

- **설정 → 코어 플러그인 → 일일 노트** → **켜기**
- **새 파일 위치**: `raw/journal`
- **템플릿 파일 위치**: `templates/journal.md`
- **날짜 형식**: `YYYY-MM-DD` (기존 `templates/journal.md`의 파일명 규칙과 일치)

> 코어 **템플릿** 플러그인은 계속 꺼 둔다. Templater의 폴더 템플릿이 이미
> `raw/journal` → `templates/journal.md` 연결을 담당하므로 중복이다.

### 주간 회고 폴더

`SPC n w`는 `raw/journal/reviews/`에 노트를 만든다. 폴더는 자동 생성되지 않으므로 미리 만든다.

```bash
mkdir -p ~/WIKI/raw/journal/reviews
```

### 인박스 파일

`SPC n a`(빠른 캡처)는 `raw/todos/inbox.md`에 추가한다. 파일이 없으면 자동 생성된다.

---

## 키맵

### 그대로 유지 — Neovim과 동일

플러그인 기본값이 이미 Neovim과 같아 **재정의하지 않은** 것들. 손이 이미 알고 있다.

| 키 | 동작 |
| --- | --- |
| `ys{motion}{char}` / `ds{char}` / `cs{old}{new}` | surround (mini.surround와 동일) |
| `iw` `aw` `i"` `ip` … | 표준 텍스트 오브젝트 |
| `i*` `i=` `` i` `` `il` `iD` `iC` `iB` | 마크다운 텍스트 오브젝트 (mini.ai 상위 호환) |
| `<C-w>h/j/k/l` | 페인 포커스 이동 |
| `<C-w>v` / `<C-w>s` | 세로/가로 분할 |
| `gt` / `gT` | 다음/이전 탭 |
| `<C-o>` / `<C-i>` | 점프 리스트 뒤로/앞으로 |
| `zo` `zc` `za` `zR` `zM` | 접기 |
| `]h` `[h` / `]l` `[l` / `]n` `[n` | 제목/목록/링크 이동 |
| `:sp` `:vs` `:e` `:w` `:q` `:grep` | Ex 명령 |
| `SPC h a` / `SPC h t` / `SPC 1`–`SPC 9` | Harpoon 고정·토글·점프 |
| `SPC f f` `SPC f g` `SPC f b` `SPC f r` | picker (Telescope 대응) |
| `SPC t m` `SPC t o` `SPC t d d` | 표 편집 |
| `SPC SPC w` / `SPC SPC f{char}` | EasyMotion |

### Obsidian용으로 변경한 키맵

Vim Motions 기본값과 Neovim 습관이 **충돌**해 자리를 옮긴 것들.

| Neovim | Obsidian | 이유 |
| --- | --- | --- |
| `SPC h` (Help) | **`SPC H`** | `SPC h`는 Harpoon 기본값 — 매일 쓰므로 기본값을 살렸다 |
| `SPC t` (Toggle) | **`SPC T`** | `SPC t`는 표(Table) 기본값 — 마크다운에서 더 자주 쓴다 |
| `SPC SPC` (버퍼 전환) | **`SPC b b`** / `<C-6>` | `SPC SPC`는 EasyMotion 기본값 |
| `SPC f r` (rename) | **`SPC c r`** | `SPC f r`은 picker의 recent files와 충돌 |
| `SPC c f` (conform 포맷) | `SPC c f` → `gqap` | Obsidian에 문서 포맷 명령이 없다. hardwrap 연산자로 대체 |
| `SPC o e` (Emacs로 열기) | `SPC o e` → Oil | Obsidian에서는 의미가 없어 Oil 탐색기로 재배치 |
| `\` (Neo-tree reveal) | `\` → Oil | 같은 자리, 같은 목적 |

### 새로 추가한 키맵 — `SPC n` (Note)

Neovim에 대응물이 없는 Obsidian 전용 기능. 충돌하지 않는 `n`을 새로 할당했다.

| 키 | 동작 |
| --- | --- |
| `SPC n n` / `SPC n d` | 오늘 일지 (Daily Note) |
| `SPC n p` / `SPC n x` | 이전 / 다음 일지 |
| `SPC n w` | **주간 회고** — ISO 주차 노트를 Dataview 쿼리와 함께 생성 |
| `SPC n a` | **빠른 캡처** — 인박스에 한 줄 추가 (QuickAdd 대응) |
| `SPC n c` | 새 노트 |
| `SPC n i` | 템플릿 삽입 (Templater) |
| `SPC n t` | 인박스 열기 |
| `SPC n v` | Dataview 페이지 picker |
| `SPC n q` / `SPC n r` / `SPC n D` | Dataview 갱신 / 뷰 재빌드 / 캐시 삭제 |
| `SPC n h` / `SPC n I` / `SPC n l` | 대시보드 / 색인 / 로그 |

그 밖에 마크다운 편집용으로 추가한 것:

| 키 | 동작 |
| --- | --- |
| `ysiwl` | 위키링크로 감싸기 → `[[단어]]` |
| `ysiwm` | 수식 블록 `$$…$$` |
| `ysiwh` / `ysiwk` | 하이라이트 `==…==` / 취소선 `~~…~~` |
| `SPC c i` / `SPC c l` / `SPC c e` | 위키링크 / 링크 / 임베드 삽입 |
| `SPC c k` / `SPC c m` / `SPC c C` | 콜아웃 / 수식 블록 / 코드 블록 |
| `SPC c d` / `SPC c R` | 링크 따라가기(정의) / 백링크(참조) |
| `SPC c c` | 체크박스 토글 |
| `,p` `,r` `,t` `,f` | 미리보기 / 소스 토글 / 표 삽입 / 문단 정렬 |

---

## 설계 원칙

1. **기본값이 이미 Neovim과 같으면 재정의하지 않는다.** 재정의는 유지보수 부담이자 버그 표면이다.
2. **충돌할 때만 옮긴다.** 그리고 어느 쪽이 더 자주 쓰이는지로 결정한다 —
   Harpoon과 표 편집이 Help·Toggle보다 손이 자주 간다.
3. **Obsidian 고유 개념은 새 namespace로.** 기존 muscle memory를 건드리지 않는다.
4. **플러그인은 최소로.** 내장 기능으로 되는 일에 플러그인을 더하지 않는다.

## 검증 상태

이 설정의 모든 식별자는 추측이 아니라 실제 소스에 대조해 확인했다.

- Obsidian 코어 명령 ID 34개 → `Obsidian.app`의 `obsidian.asar` 바이너리에 대조
- Dataview 명령 ID 3개 → 설치된 `dataview/main.js`(v0.5.68)에 대조
- Vim Motions Lua API 21개 → [플러그인 소스](https://github.com/saberzero1/motions)의 `src/lua/`에 대조
- `vim.opt` 옵션 24개 → `src/vimrc/loader.ts`의 `KNOWN_SET_OPTIONS`에 대조 (이름·타입 모두)
- Lua 문법 → `luac -p` 통과

## 문제 해결

**키맵이 하나도 안 먹는다**
`obsidian.init.lua`가 `.obsidian/`이 아니라 **vault 루트**에 있는지 확인한다.
`ls -l ~/WIKI/obsidian.init.lua`

**일부 키맵만 안 먹는다**
Configuration mode가 `Lua only`인지 확인한다. `lua-vimrc`면 vimrc가 덮어쓸 수 있다.

**한글 입력 중 Esc가 이상하다**
설정 → Vim Motions → Input method에서 입력기 전환 바이너리 경로를 지정해야
`vim.obsidian.im`이 동작한다 (macOS: [im-select](https://github.com/daipeihust/im-select)).

**설정 오류 확인**
`:violations` — 설정 UI와 충돌하는 지시문을 보여준다.
