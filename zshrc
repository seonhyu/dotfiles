autoload -U compinit

# Prompt {{{
# https://github.com/wellle/dotfiles/blob/master/zshrc

zstyle ':vcs_info:*' formats '[%F{blue}%s%f:%F{yellow}%.16b%f] '
zstyle ':vcs_info:*' actionformats '%F{blue}%s%f:%F{yeow}%.16b%f:%F{magenta}%a%f '
zstyle ':vcs_info:*' enable git hg

setopt prompt_subst
autoload -Uz vcs_info
precmd() { vcs_info }
#PROMPT=$'%f${vcs_info_msg_0_}%f%F{cyan}%3~%F{magenta}$%f ' # %F{green}❱
PROMPT=$'%f%F{cyan}%3~ $(git_super_status)%F{magenta}$ '
PROMPT2='%F{yellow}%_ %f%f '                               # %F{green}❭
# }}}
# Key bindings {{{
bindkey -v                                          # Use vi key bindings
bindkey '^r' history-incremental-search-backward    # [Ctrl-r] - Search backward incrementally for a specified string. The string may begin with ^ to anchor the search to the beginning of the line.

# emacs style
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
# }}}
# vi mode {{{
set -o vi
export EDITOR=vim
export VISUAL=vim
# }}}
# Env {{{
export PATH=~/bin:/usr/local/bin:/usr/local/share/npm/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH
# Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
# }}}
# Java {{{
# Play Version Manager(PVM) 활성화
. /usr/local/pvm/pvm.sh

export M2_HOME="/usr/local/Cellar/maven/3.2.1"

alias setjdk16='export JAVA_HOME=$(/usr/libexec/java_home -v 1.6)'
alias setjdk17='export JAVA_HOME=$(/usr/libexec/java_home -v 1.7)'
alias setjdk18='export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)'
# }}}
# Aliases {{{
alias ll='ls -alGh'
alias l='ls -lGh'
alias du='du -h -d 2'

alias vi='mvim -v'
alias vim='mvim -v'

alias gs='git status'
alias gl='git l'
alias ga='git add -A'

alias pg='ps -ef | grep'
alias vg='vagrant'
# }}}
# Help {{{
unalias run-help
autoload run-help
HELPDIR=/usr/local/share/zsh/helpfiles
#}}}
# External modules {{{
# brew install zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)

if [ -d $HOME/.zsh/ ]; then
    if [ "$(ls -A $HOME/.zsh/)" ]; then
        for config_file ($HOME/.zsh/*.zsh) source $config_file
    fi
fi

source $HOME/.zsh/git-prompt/zshrc.sh
source $HOME/.zsh/syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/.zsh/history-substring-search/zsh-history-substring-search.zsh
# bind UP and DOWN arrow keys
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
# bind k and j for VI mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
# }}}

# vim:foldmethod=marker:foldlevel=0