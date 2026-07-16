
#==================================================================
# 1. PATH 설정 (중복 제거 함수)
#==================================================================
path_append() {
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    PATH="${PATH:+"$PATH:"}$1"
  fi
}

path_prepend() {
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    PATH="$1${PATH:+":$PATH"}"
  fi
}

# PATH 설정 (조건부 및 중복 방지)
if command -v brew &> /dev/null; then
  path_prepend "$(brew --prefix coreutils)/libexec/gnubin"
  path_prepend "$(brew --prefix)/opt/postgresql@16/bin"
fi

path_prepend "$HOME/.asdf/shims"
path_prepend "/Applications/Emacs.app/Contents/MacOS"
path_prepend "$HOME/.local/bin"
path_append "~/.lmstudio/bin"

export PATH

#==================================================================
# 2. Zsh 성능 최적화를 위한 캐시 디렉토리
#==================================================================
ZSH_CACHE_DIR="${HOME}/.cache/zsh"
[[ ! -d "$ZSH_CACHE_DIR" ]] && mkdir -p "$ZSH_CACHE_DIR"

#==================================================================
# 3. Homebrew 환경 로드 (macOS 전용)
#==================================================================
if [[ -f "/opt/homebrew/bin/brew" ]]; then
  # brew shellenv 캐싱으로 성능 개선
  BREW_CACHE="$ZSH_CACHE_DIR/brew_shellenv"
  if [[ ! -f "$BREW_CACHE" ]] || [[ "/opt/homebrew/bin/brew" -nt "$BREW_CACHE" ]]; then
    /opt/homebrew/bin/brew shellenv > "$BREW_CACHE"
  fi
  source "$BREW_CACHE"
fi

#==================================================================
# 4. Prompt 초기화 (Starship)
#==================================================================
eval "$(starship init zsh)"               # Starship 프롬프트 활성화

#==================================================================
# Zinit: zsh plugin manager
# Zinit 설치/로드 설정
#==================================================================
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# zinit이 없으면 자동 설치
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-syntax-highlighting

# ===== Oh-My-Zsh 스니펫
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::command-not-found

# Zsh Completion (캐싱으로 성능 개선)
# Completion 덤프 파일 캐싱
COMPDUMP="$ZSH_CACHE_DIR/zcompdump-${ZSH_VERSION}"
autoload -Uz compinit
if [[ $COMPDUMP -nt /usr/share/zsh ]] && [[ ! $COMPDUMP.zwc -ot $COMPDUMP ]]; then
  compinit -C -d "$COMPDUMP"
else
  compinit -d "$COMPDUMP"
  [[ -f "$COMPDUMP" && ! -f "$COMPDUMP.zwc" ]] && zcompile "$COMPDUMP"
fi

# ===== zinit cdreplay
zinit cdreplay -q

#==================================================================
# 키 바인딩
#==================================================================
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

#==================================================================
# 히스토리 설정
#==================================================================
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

#==================================================================
# Completion/FZF-Tab 스타일링
#==================================================================
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

#==================================================================
# NFD/NFC 한글 처리 함수
# macOS에서 한글 파일명 검색/처리를 위한 헬퍼 함수들
#==================================================================

# NFC로 변환 (파이프에서 사용)
nfc() {
  iconv -c -f UTF-8-MAC -t UTF-8 2>/dev/null || cat
}

# NFD로 변환 (파이프에서 사용)
nfd() {
  iconv -c -f UTF-8 -t UTF-8-MAC 2>/dev/null || cat
}

# ls 명령 래퍼 - NFD를 NFC로 자동 변환
ls() {
  if [ -t 1 ]; then
    # 터미널 출력일 때만 변환
    command ls --color "$@" | nfc
  else
    # 파이프나 리다이렉션일 때는 원본 유지
    command ls "$@" | nfc
  fi
}

# 한글 grep - NFC 입력을 NFD로 변환하여 검색
grepk() {
  local pattern="$1"
  shift
  local nfd_pattern=$(echo "$pattern" | nfd)
  command grep "$nfd_pattern" "$@"
}

# 한글 ripgrep - NFC 입력을 NFD로 변환하여 검색
rgk() {
  local pattern="$1"
  shift
  local nfd_pattern=$(echo "$pattern" | nfd)
  rg "$nfd_pattern" "$@"
}

#==================================================================
# claude code
#==================================================================
export BASH_MAX_OUTPUT_LENGTH=30000
export CLAUDE_CODE_FILE_READ_MAX_OUTPUT_TOKENS=25000
export CLAUDE_CODE_GLOB_NO_IGNORE=false
export CLAUDE_CODE_FORK_SUBAGENT=1

#==================================================================
# Aliases (편의 명령)
#==================================================================
alias python='python3'

alias ll='ls -alGh --color'
alias la='ls -A --color'
alias l='ls -CF --color'
alias cc='CLAUDE_CODE_NO_FLICKER=1 claude'
alias ccy='cc --allow-dangerously-skip-permissions'

# 에디터
if command -v nvim &> /dev/null; then
  alias vim='nvim'
  alias vi='nvim'
  export EDITOR='nvim'
fi

# 유틸리티
alias c='clear'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# ripgrep을 grep 기본값으로 (존재하는 경우만)
if command -v rg &> /dev/null; then
  alias grep='rg'
fi


# Git 단축어
alias lg='lazygit'
# (OMZ git 플러그인과 중복되지 않는 것만)
alias gs='git status'
alias gl='git log --graph --decorate --date=short --pretty=format:"%C(auto)%h%d %s %C(cyan)(%an, %ad)"'
alias gv='git msg'
alias gd='git difftool'
alias gcm='git commit -m'
alias gf='git flow'

# emacs: 실행 중인 Emacs.app에 열기 (서버 없으면 앱 실행)
emacs() {
  if (( $# == 0 )); then
    open -a Emacs
    return
  fi
  if command emacsclient -n "$@" 2>/dev/null; then
    osascript -e 'tell application "Emacs" to activate' >/dev/null
  else
    open -a Emacs "$@"
  fi
}

#==================================================================
# FZF 유용한 함수들
#==================================================================
if command -v fzf &> /dev/null; then
  # 파일 검색 후 편집
  ze() {
    local files
    files=$(fzf --multi --preview 'cat {}') && ${EDITOR:-vim} $files
  }

  # 디렉토리 검색 후 이동
  zd() {
    local dir
    dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
  }

  # 히스토리 검색
  zh() {
    print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')
  }

  # 프로세스 종료
  zkill() {
    local pid
    pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    if [ "x$pid" != "x" ]; then
      echo $pid | xargs kill -${1:-9}
    fi
  }
fi

#==================================================================
# Shell integration (조건부 로딩)
#==================================================================
if command -v fzf &> /dev/null; then
  eval "$(fzf --zsh)"
fi

if command -v zoxide &> /dev/null; then
  eval "$(zoxide init --cmd z zsh --hook prompt)"
  # zi 명령은 Zinit과 충돌하여 사용할 수 없으므로 `zf`로 사용해야한다.
  alias zz='zoxide query -i'
fi

#==================================================================
# 추가 유용한 함수들
#==================================================================

# 디렉토리 생성 후 이동
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# 파일/디렉토리 백업
backup() {
  cp -r "$1" "$1.backup.$(date +%Y%m%d_%H%M%S)"
}

# 압축 해제 (자동 감지)
extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2) tar xjf "$1" ;;
      *.tar.gz) tar xzf "$1" ;;
      *.bz2) bunzip2 "$1" ;;
      *.rar) unrar e "$1" ;;
      *.gz) gunzip "$1" ;;
      *.tar) tar xf "$1" ;;
      *.tbz2) tar xjf "$1" ;;
      *.tgz) tar xzf "$1" ;;
      *.zip) unzip "$1" ;;
      *.Z) uncompress "$1" ;;
      *.7z) 7z x "$1" ;;
      *) echo "'$1' cannot be extracted" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

#==================================================================
# 로컬 설정 (민감한 정보나 머신별 설정)
#==================================================================
if [[ -f "$HOME/.zshrc.local" ]]; then
  source "$HOME/.zshrc.local"
fi
