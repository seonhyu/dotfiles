" Tmux panel에서 play compile 실행 {{{
	command! Play ScreenShell play -Dsbt.log.noformat=true "~compile" 2>&1 | tee /tmp/play-compile.out
" }}}
