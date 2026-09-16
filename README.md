# my-dotfiles

GNU Stow를 사용한 dotfiles 관리 저장소

## 패키지

- `doom/` - Doom Emacs 설정 (Elixir, TypeScript, Web-mode snippets 포함)
- `git/` - Git 글로벌 설정 (gitignore)
- `herdr/` - Herdr 터미널 워크스페이스 설정 (tmux 설정에서 이관). `local-plugins/`에 직전 workspace 토글 플러그인 포함
- `karabiner/` - Karabiner-Elements 키보드 커스터마이징
- `nvim/` - Neovim 설정 (LazyVim 스타일 모듈화, Spacemacs 키맵, 한글 NFD 지원)
- `obsidian/` - Obsidian Vim Motions 설정 (Neovim 키맵 이식, ~/WIKI vault 대상)
- `tmux/` - Tmux 터미널 멀티플렉서 설정
- `wezterm/` - WezTerm 터미널 설정
- `zsh/` - Zsh 설정 (Zinit, Starship, FZF 등)

## 사용법

```bash
# 저장소 클론
git clone <repo-url> ~/repos/personal/dotfiles
cd ~/repos/personal/dotfiles

# 특정 패키지 설치 (홈 디렉토리에 심볼릭 링크 생성)
stow -t ~ wezterm

# 모든 패키지 설치 (obsidian 제외 — 대상 디렉터리가 다르다)
stow -t ~ $(ls -d */ | grep -v '^obsidian/')

# obsidian은 홈이 아니라 vault를 대상으로 설치한다
stow -t ~/WIKI obsidian

# 패키지 제거
stow -t ~ -D wezterm

# 변경사항 미리보기 (dry-run)
stow -t ~ -n -v wezterm
```

### herdr 로컬 플러그인 등록

`stow -t ~ herdr` 뒤에 한 번만 실행한다. `prefix+tab` 의 직전 workspace 토글이 이 플러그인에 의존한다.

```bash
herdr plugin link ~/.config/herdr/local-plugins/last-workspace --enabled
herdr server reload-config
```

## 의존성 설치

```bash
# Homebrew 패키지 설치
brew bundle
```

## 요구사항

- [Homebrew](https://brew.sh/)
- [GNU Stow](https://www.gnu.org/software/stow/)
