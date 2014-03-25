if has('gui_running')
	if has('win32') || has('win64')
		" Windows
		source $VIMRUNTIME/mswin.vim
		set guifont=Consolas:h10:cANSI
		set guioptions-=T " Toolbar
		set guioptions-=m " Menubar

		" Set height and width on Windows
		set lines=60
		set columns=120

		" Windows has a nasty habit of launching gVim in the wrong working directory
		cd ~
	else
		set linespace=0
		set guifont=Sauce\ Code\ Powerline:h12

		" Hide Toolbar in MacVim
		set guioptions=egmrt
		set guioptions-=r

        set background=dark
        color hybrid
	endif
endif
