if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

" Extend vim
"===========================================================
NeoBundle "tpope/vim-sensible"

" languages
"===========================================================
NeoBundle "pangloss/vim-javascript"
"NeoBundle "derekwyatt/vim-scala"
NeoBundle "davidhalter/jedi-vim"

" Html, Xml, Css, Markdown...
"===========================================================
NeoBundle "groenewege/vim-less.git"
NeoBundle "itspriddle/vim-jquery.git"
NeoBundle "kchmck/vim-coffee-script"
NeoBundle "jtratner/vim-flavored-markdown"
NeoBundle "suan/vim-instant-markdown"

" Git related...
"===========================================================
NeoBundle "tpope/vim-fugitive"

" General text editing improvements...
"===========================================================
NeoBundle "Raimondi/delimitMate"
NeoBundle "Shougo/neocomplete.git"
NeoBundle "Shougo/neosnippet.git"
"NeoBundle "Valloric/YouCompleteMe"
NeoBundle "godlygeek/tabular"
NeoBundle "skwp/vim-easymotion"
NeoBundle "scrooloose/nerdcommenter"

" General vim improvements
"===========================================================
NeoBundle "Shougo/unite.vim"
NeoBundle "MarcWeber/vim-addon-mw-utils.git"
NeoBundle "kien/ctrlp.vim"
NeoBundle "majutsushi/tagbar.git"
NeoBundle "rking/ag.vim"
NeoBundle "scrooloose/nerdtree.git"
NeoBundle "scrooloose/syntastic.git"
NeoBundle "tomtom/tlib_vim.git"
NeoBundle "tpope/vim-surround.git"
" repeat plugin은 surround 기능을 .으로 반복할 수 있게한다.
NeoBundle "tpope/vim-repeat.git"

" Cosmetics, color scheme, Powerline...
"===========================================================
NeoBundle "seonhyu/vim-colors-solarized"
NeoBundle "seonhyu/vim-hybrid"
NeoBundle "cocopon/iceberg.vim"
NeoBundle "nathanaelkane/vim-indent-guides"

"  Dev tools
"===========================================================
NeoBundle "rizzatti/dash.vim"
NeoBundle "Shougo/vimshell.vim"
NeoBundle "davidoc/taskpaper.vim"

NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }

call neobundle#end()
NeoBundleCheck
