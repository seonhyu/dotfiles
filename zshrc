# =========================================
#   oh-my-zsh
# =========================================
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="af-magic"
#ZSH_THEME="gentoo"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to disable command auto-correction.
# DISABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git git-flow-avh brew autojump vi-mode zsh-syntax-highlighting zsh-history-substring-search)

export LANG="en_US.UTF-8"
source $ZSH/oh-my-zsh.sh

# User configuration

export PATH=.:$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH:/usr/texbin
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"
# Lines configured by zsh-newuser-install

# =========================================
#   It's mine
# =========================================
# Env {{{
    export M3_HOME="/usr/local/Cellar/maven/3.2.1"
    # play build with NodeJS
    export SBT_OPTS="$SBT_OPTS -Dsbt.jse.engineType=Node"
    export EDITOR='vim'
# }}}
# Aliases {{{
    alias ll='ls -lGh'
    alias l='ls -AlGh'
    alias du='du -h -d 2'

    alias vi='mvim -v'
    alias vim='mvim -v'

    alias gs='git status'
    alias gl='git l'
    alias ga='git add -A'
    alias gac='git add -A; git commit -v'
    alias gd='git difftool'

    alias pg='ps -ef | grep'
    alias vg='vagrant'
    alias tmux='tmux -2'

    # Java
    alias act='activator'
    alias setjdk16='export JAVA_HOME=$(/usr/libexec/java_home -v 1.6)'
    alias setjdk17='export JAVA_HOME=$(/usr/libexec/java_home -v 1.7)'
    alias setjdk18='export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)'

    alias ssh='TERM=xterm ssh'

    alias pgrep='pgrep -ilf'
    alias pkill='pkill -ilf'

    #alias pip='pip --cert ~/work/snnc/SNNC.pem'
# }}}
# Bind keys {{{
    zmodload zsh/terminfo
    bindkey "$terminfo[kcuu1]" history-substring-search-up
    bindkey "$terminfo[kcud1]" history-substring-search-down
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down
    # bind k and j for VI mode
    bindkey -M vicmd 'k' history-substring-search-up
    bindkey -M vicmd 'j' history-substring-search-down
# }}}

setjdk17
eval "$(rbenv init -)"

# vim:foldmethod=marker:foldlevel=0
