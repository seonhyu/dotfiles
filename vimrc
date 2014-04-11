" ===========================================================
" Use Macvim as terminal vim
" alias vim='mvim -V'
" ===========================================================
" NeoBundle {{{
" Use Vundle plugin to manage all other plugins
if filereadable(expand("~/dotfiles/vimrc.neobundle"))
    source ~/dotfiles/vimrc.neobundle
endif

" 기본설정 적용
runtime! plugin/sensible.vim
" }}}
" Set :: Indentation {{{
" Tab키 동작 설정
set tabstop=4       " 탭당 보여지는 스페이스 크기
set softtabstop=4   " 편집할 때 적용되는 스페이스 크기. 탭키/백스페이스에 영향
set shiftwidth=4    " autoindent에 영향. 이게 없으면 들여쓰기 내어쓰기 자동정렬 안됨
set expandtab       " 탭문자 대신 스페이스 사용
" }}}
" Set :: UI {{{
set number
set showmode		" show current mode
set nocursorline
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
set cmdheight=1
set diffopt+=context:3  " 변경 주변 3줄 보여줌
" }}}
" Set :: Searching {{{
set hlsearch
set ignorecase      " Case insensitive search
set smartcase       " Non-case sensitive search
" }}}
" Set :: Folding {{{
set foldenable      " 폴딩 가능하게
set foldmethod=indent
set foldlevelstart=10   " 시작시 웬만치는 열려 보이도록함. 0이면 모두 감춤
set foldnestmax=10
set clipboard+=unnamed  " Yanks go on clipboard instead.
" }}}
" Set :: Backup {{{
set nobackup
set noswapfile
set nowritebackup

set backupdir=~/.vim/backup
set directory=~/.vim/tmp
set undodir=~/.vim/backups
set undofile
" }}}
" Set :: Peformance {{{
set lazyredraw
"set timeoutlen=300  " Mapping delay
"set ttimeoutlen=-1  " Key code delay
set synmaxcol=200   " 200자 넘는 라인은 syntax highlight 하지 않는다.
" }}}
" Set :: Overwrite default {{{
set noerrorbells visualbell t_vb=  " Disable bells
set formatoptions=crqwnl1          " Help fo-table
set hidden              " Change buffer - without saving
set report=0
set scrolljump=10
set shortmess=atToOI

set autoread            " Automatically reload changes if detected
set autowrite           " Writes on make/shell commands
set cf                  " Enable error files & error jumping.
"set complete=.,w,b,u,U  " Better complete options to speed it up
set tags=tags;/
"}}}
" Theme {{{
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

    let g:solarized_termtrans=1
    color solarized
    set background=dark
endif

if !has('gui_running')
    "모드에 따라 cursor 모양 바꾸기 {{{
    if exists('$TMUX')
        let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
        let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
    else
        let &t_SI = "\<Esc>]50;CursorShape=1\x7"
        let &t_EI = "\<Esc>]50;CursorShape=0\x7"
    endif
endif
" }}}
" Mappings {{{
let mapleader=","

" Don't move to next
nnoremap * *N
" Indent
vnoremap > >gv
vnoremap < <gv

" Moving
nnoremap j gj
nnoremap k gk
nnoremap B ^
nnoremap E $
"Go to last edit location
nnoremap ,. '.

" toggle
nnoremap <silent> <F1> :set number!<CR>
nnoremap <silent> <F2> :set paste!<CR>
nnoremap <silent> <F3> :set spell!<CR>

" 폴딩 toggle
nnoremap <Space> za

" 마지막 입력한 부분을 선택
nnoremap gV `[v`]
nnoremap Y y$
imap <S-Enter> <cr><esc>O
imap ;; <END>
imap ,, <ESC>wa,
" 이전 입력한 문자열 Complete
imap <C-l> <C-x><C-n>

nnoremap <Leader>a :Ag

" Window Movement
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-l> :wincmd l<CR>
" Close window
nnoremap Q :close<cr>
" Create window splits easier.
nnoremap <silent> vv <C-w>v
nnoremap <silent> ss <C-w>s

if has('gui_running')
    nmap <Leader>vr :RestartVim<CR>
    nmap <Leader>vo :OpenSession<CR>

    map  <D-1> :tabn 1<CR>
    imap <D-1> <Esc> :tabn 1<CR>
    map  <D-2> :tabn 2<CR>
    imap <D-2> <Esc> :tabn 2<CR>
    map  <D-3> :tabn 3<CR>
    imap <D-3> <Esc> :tabn 3<CR>
    map  <D-4> :tabn 4<CR>
    imap <D-4> <Esc> :tabn 4<CR>
    map  <D-5> :tabn 5<CR>
    imap <D-5> <Esc> :tabn 5<CR>
    map  <D-6> :tabn 6<CR>
    imap <D-6> <Esc> :tabn 6<CR>
    map  <D-7> :tabn 7<CR>
    imap <D-7> <Esc> :tabn 7<CR>
    map  <D-8> :tabn 8<CR>
    imap <D-8> <Esc> :tabn 8<CR>
endif

nmap <leader>1 :ZoomWin<CR>

" Tabular
nmap <Leader>a" :Tabularize /"/<CR>
nmap <Leader>a, :Tabularize /,\zs<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
nmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a> :Tabularize /=>\zs<CR>
vmap <Leader>a" :Tabularize /"/<CR>
vmap <Leader>a, :Tabularize /,\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a> :Tabularize /=>\zs<CR>
vmap <Leader>as :Tabularize / [ ]*/l0l0l0<CR>

" Select a buffer
nnoremap <leader><leader> <c-^>
nnoremap <leader>bp :bprev<CR>
nnoremap <leader>bn :bnext<CR>

nnoremap <Leader>co :copen<CR>
nnoremap <Leader>cc :cc<CR>
nnoremap <Leader>cp :cprev<CR>
nnoremap <Leader>cn :cnext<CR>

" 마지막 변경 선택
nnoremap gp `[v`]

" Hide search highlight
nnoremap <Leader>h :nohlsearch<CR>

map ,jm :CloseSingleConque<CR>:CtrlP app/models<CR>
map ,jc :CloseSingleConque<CR>:CtrlP app/controllers<CR>
map ,jv :CloseSingleConque<CR>:CtrlP app/views<CR>
map ,jp :CloseSingleConque<CR>:CtrlP public<CR>
map ,jC :CloseSingleConque<CR>:CtrlP config<CR>
map ,jT :CloseSingleConque<CR>:CtrlP test<CR>

" fugitive
nmap <leader>gs :Gstatus<cr><c-w>20+
nmap <leader>gm :Gcommit<cr>

" markdown
nnoremap <leader>h1 o<Esc>70i=<Esc>
nnoremap <leader>h2 o<Esc>70i-<Esc>
nnoremap <leader>h3 3I#<Esc>a <Esc>

" 인코딩 전환
nnoremap <leader>k <Esc>:e ++enc=euc-kr<CR>

" Refresh project
nnoremap <leader>pr :!/usr/local/bin/ctags --extra=+f -R app/<CR><CR>:CtrlPClearAllCaches<CR>

" Use Q for formatting the current paragraph (or selection)
vmap <leader>q gq
nmap <leader>q gqap

" surround with double quatation
nmap <leader>qq ysiw"

" 화면꺠졌을 때 다시 그림
nnoremap <leader>r :redraw!<CR>

" Move between tabs with t/T
nnoremap t gt
nnoremap T gT
map  <leader>t1 :tabn 1<CR>
imap <leader>t1 <Esc> :tabn 1<CR>
map  <leader>t2 :tabn 2<CR>
imap <leader>t2 <Esc> :tabn 2<CR>
map  <leader>t3 :tabn 3<CR>
imap <leader>t3 <Esc> :tabn 3<CR>
map  <leader>t4 :tabn 4<CR>
imap <leader>t4 <Esc> :tabn 4<CR>
map  <leader>t5 :tabn 5<CR>
imap <leader>t5 <Esc> :tabn 5<CR>
map  <leader>t6 :tabn 6<CR>
imap <leader>t6 <Esc> :tabn 6<CR>
map  <leader>t7 :tabn 7<CR>
imap <leader>t7 <Esc> :tabn 7<CR>
map  <leader>t8 :tabn 8<CR>
imap <leader>t8 <Esc> :tabn 8<CR>

" W as sudo write
command! -bar -nargs=0 W silent! exec "write !sudo tee % >/dev/null" | silent! edit!

" Remove trailing white space
map <leader>ws <ESC>:%s/\s\+$//e<CR>

"(v)im (c)ommand - execute current line as a vim command
nmap <silent> ,vc yy:<C-f>p<C-c><CR>

nmap ,cl :set cul<cr>
nmap ,cc :set cuc<cr>

cmap <Up> <C-p>
"}}}
" autocommands {{{
augroup configgroup
    " 그룹내 모든 autocmd 지우기
    autocmd!

    " No formatting on o key newlines
    autocmd BufNewFile,BufEnter * set formatoptions-=o

    " When editing a file, always jump to the last cursor position.
    " This must be after the uncompress commands.
    autocmd BufReadPost *
                \ if line("'\"") > 1 && line ("'\"") <= line("$") |
                \   exe "normal! g`\"" |
                \ endif

    " 파일 저장 직전에 줄끝 공백 지우기
    autocmd BufWritePre *.{java,js,txt,md,mardkwon,css} :call StripTrailingWhitespaces()

    autocmd BufNewFile,BufRead *.markdown,*.md,*.txt,*.rst setlocal wrap linebreak

    " FileType 지정
    autocmd BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} set ft=markdown
    autocmd BufNewFile,BufRead *.json set ft=javascript

    set completeopt=menu,menuone,longest
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown,play2-html setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

    autocmd FileType snippet setlocal noexpandtab
    autocmd FileType scala,jade,html,css,json,less setlocal sw=2 sts=2 ts=2

    " 외부에서 변경된 파일 자동 다시 읽기.
    " set autoread 에 의존한다. autoread는 키입력 다음 또는 checktime에의해 실행된다.
    set updatetime=1000     " CursorHold,CursorHoldI의 대기 시간.
    autocmd! CursorHold,CursorHoldI,BufEnter,WinEnter * checktime
augroup END
" }}}
" functions {{{
function! StripTrailingWhitespaces()
    " save last cusor postion
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction
" }}}
" Vimrc files {{{
if filereadable(expand("~/dotfiles/vimrc.plugins"))
    source ~/dotfiles/vimrc.plugins
endif

" Parse local vimrc (useful for per-settings)
if filereadable(".lvimrc")
    source .lvimrc
endif
" }}}


" vim:foldmethod=marker:foldlevel=0
