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
NeoBundle "mattn/emmet-vim"

NeoBundle "SirVer/ultisnips"
NeoBundle "Valloric/YouCompleteMe"

" 개발지원
"--------------------------------
NeoBundle "scrooloose/syntastic.git"
NeoBundle "mitsuhiko/vim-jinja"
NeoBundle "groenewege/vim-less"
NeoBundle "Valloric/MatchTagAlways"
NeoBundle "tomtom/tcomment_vim"
NeoBundle "majutsushi/tagbar"

" Vim 확장
"--------------------------------
NeoBundle 'bling/vim-airline'
NeoBundle 'rking/ag.vim'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'christoomey/vim-tmux-navigator'

" Cosmetics, color scheme, Powerline...
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'cocopon/iceberg.vim'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'freeo/vim-kalisi'

"===========================================================
call neobundle#end()
filetype plugin indent on
NeoBundleCheck
