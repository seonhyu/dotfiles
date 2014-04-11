" ===========================================================
" Use Macvim as terminal vim
" alias vim='mvim -V'
" ===========================================================
set nocompatible
syntax on

" NeoBundle {{{
" Use Vundle plugin to manage all other plugins
if filereadable(expand("~/dotfiles/vimrc.neobundle"))
    source ~/dotfiles/vimrc.neobundle
endif
" }}}

" Environment {{{
filetype plugin on
" }}}

" Indentation {{{
" Tab키 동작 설정
set tabstop=4       " 탭당 보여지는 스페이스 크기
set softtabstop=4   " 편집할 때 적용되는 스페이스 크기. 탭키/백스페이스에 영향
set shiftwidth=4    " autoindent에 영향. 이게 없으면 들여쓰기 내어쓰기 자동정렬 안됨
set expandtab       " 탭문자 대신 스페이스 사용
set autoindent      " 새줄 추가할 때 이전 들여쓰기 따라감
set smartindent
filetype indent on  " 파일 유형별 들여쓰기 파일 사용
" 삭제 예정 14.2.7 -->
" set smartindent
" set smarttab
" }}}

" UI {{{
set number
set showcmd	        " 마지막줄 오른쪽 끝에 입력한 명령을 보여준다
set showmode		" show current mode
set nocursorline
set wildmenu        " Command line에서 선택가능한 목록을 보여주는 형태로 자동완성
set wildmode=full
set wildignore+=.git,target,.DS_Store,.settings,*.class,*.jar,dist,logs,img,*.log,*.zip,*.jpg,*.gif,*.png
set wildignore+=*/.target/*,.target,.idea,tags,*/node-modules/*
" TODO Ubuntu에서 에러 발생함
set fillchars=vert:│,fold:┄,diff:╱
set listchars=tab:│\ ,trail:⌴,eol:·,precedes:◂,extends:▸
set showbreak=↪
set showmatch       " Show matching brackets.
set mousehide       " Hide mouse after chars typed
set mouse=a         " Mouse in all modes
set nowrap          " Line wrapping off
set splitbelow
set splitright
set laststatus=2    " Always show the statusline
set cmdheight=1
set backspace=2     " Delete everything with backspace
set diffopt+=context:3  " 변경 주변 3줄 보여줌
" }}}

" Searching {{{
set hlsearch
set incsearch
set ignorecase      " Case insensitive search
set smartcase       " Non-case sensitive search
" }}}

" Folding {{{
set foldenable      " 폴딩 가능하게
set foldmethod=indent
set foldlevelstart=10   " 시작시 웬만치는 열려 보이도록함. 0이면 모두 감춤
set foldnestmax=10
set clipboard+=unnamed  " Yanks go on clipboard instead.
" }}}


" Backup {{{
set nobackup
set noswapfile
set nowritebackup

set backupdir=~/.vim/backup
set directory=~/.vim/tmp
set undodir=~/.vim/backups
set undofile
" }}}

" Peformance {{{
set lazyredraw
set timeoutlen=300  " Mapping delay
set ttimeoutlen=-1  " Key code delay
set synmaxcol=200   " 200자 넘는 라인은 syntax highlight 하지 않는다.
" }}}

set noerrorbells visualbell t_vb=  " Disable bells
set formatoptions=crqwnl1          " Help fo-table
set hidden              " Change buffer - without saving
set history=768         " Number of things to remember in history.
set report=0
set scrolloff=6         " minimum lines to keep above and below cursor
set scrolljump=10
set shortmess=atToOI

set autoread            " Automatically reload changes if detected
set autowrite           " Writes on make/shell commands
set cf                  " Enable error files & error jumping.
set complete=.,w,b,u,U  " Better complete options to speed it up

set tags=tags;/

" Source vim config files {{{
runtime! config/plugins.vim
runtime! config/autocommands.vim
runtime! config/commands.vim
runtime! config/foldtext.vim
runtime! config/make.vim
runtime! config/mappings.vim
runtime! config/gui.vim
runtime! config/terminal.vim
runtime! config/highlight.vim

if filereadable("~/.vimrc.local")
    source ~/.vimrc.local
endif

" Parse local vimrc (useful for per-settings)
if filereadable(".lvimrc")
    source .lvimrc
endif
" }}}

" IME. MacVim에서만 동작 {{{
"set imak=S-space
"set noimdisable    " normal mode로 돌아갈 때 ime 끔
"set imi=1          " insert mode 들어갈 때 ime 전환하지 않음
"set ims=-1         " search imi 설정 따름
" }}}

" vim:foldmethod=marker:foldlevel=0
