if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
"===========================================================

" 필수
"--------------------------------
NeoBundle "tpope/vim-sensible"
NeoBundle "tpope/vim-fugitive"
NeoBundle "scrooloose/nerdtree.git"
NeoBundle "kien/ctrlp.vim"
"NeoBundle "Shougo/neocomplete.git"
"NeoBundle "Shougo/neosnippet.git"
NeoBundle "mattn/emmet-vim"

NeoBundle "SirVer/ultisnips"
NeoBundle "Valloric/YouCompleteMe"

" 개발지원
"--------------------------------
NeoBundle "scrooloose/syntastic.git"
NeoBundle "mitsuhiko/vim-jinja"

" Vim 확장
"--------------------------------
NeoBundle 'bling/vim-airline'

" Cosmetics, color scheme, Powerline...
NeoBundle 'chriskempson/base16-vim'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'cocopon/iceberg.vim'

"===========================================================
call neobundle#end()
filetype plugin indent on
NeoBundleCheck
