set t_Co=256

if ! has('gui_running')
    set background=dark

    " let g:solarized_visibility="low"
    " color solarized

    color jellybeans

    " 모드에 따라 cursor 모양 바꾸기 {{{
    if exists('$TMUX')
        let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
        let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
    else
        let &t_SI = "\<Esc>]50;CursorShape=1\x7"
        let &t_EI = "\<Esc>]50;CursorShape=0\x7"
    endif
    " }}}
endif


