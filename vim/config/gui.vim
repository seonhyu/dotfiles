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
        set guicursor=n-v-c:block-Cursor-blinkon0,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-Cursor,r-cr:hor20-Cursor,sm:block-Cursor-blinkwait175-blinkoff150-blinkon175

		set guifont=Source\ Code\ Pro\ Light:h13
		set linespace=0

		" Hide Toolbar in MacVim
		set guioptions=egmrt
		set guioptions-=r

        set background=dark
        " color solarized
        color jellybeans

		" color smyck
		" hi ColorColumn guibg=#333333
		" hi LineNr guibg=#1c1c1c
		" hi VertSplit guifg=#1c1c1c guibg=#999999
	endif
endif
