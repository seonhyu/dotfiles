set t_Co=256

if ! has('gui_running')
    set background=dark

	"let g:solarized_visibility="low"
    color solarized

    " color jellybeans

	" let g:molokai_original = 0
    " color molokai
    
    " Solarized
    " let g:indent_guides_guide_size=0
    " hi IndentGuidesEven ctermbg=0
    " hi IndentGuidesOdd ctermbg=8

    " 어두운 회색
    " hi IndentGuidesEven ctermbg=233
    " hi IndentGuidesOdd ctermbg=234

	" Instantly leave insert mode when pressing <Esc> {{{
		"set ttimeoutlen=10
		"augroup FastEscape
			"autocmd!

			"au InsertEnter * set timeoutlen=0
			"au InsertLeave * set timeoutlen=1000
		"augroup END
	" }}}
	" Change cursor color in insert mode {{{
		" if $TMUX != ''
		" 	" tmux
		" 	let &t_SI = 'Ptmux;]12;#89b6e2\'
		" 	let &t_EI = 'Ptmux;]12;#dd4010\'
		" else
		" 	" urxvt
		" 	let &t_SI = ']12;#89b6e2'
		" 	let &t_EI = ']12;#dd4010'
		" endif
	" }}}

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

