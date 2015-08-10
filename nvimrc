" ===========================================================
" Use Macvim as terminal vim
" alias vim='mvim -V'
" ===========================================================

" Default settings {{{
set nocompatible
let mapleader="\<Space>"

set wildignore+=.idea/**,.idea_modules/**,.settings/**
set wildignore+=_public/**,*/node_modules/**,logs/**,dist/**,target/**,.target/**
set wildignore+=.git/**,.DS_Store/**,tags
set wildignore+=*.log,*.zip,*.jpg,*.gif,*.png,*.jar,*.class
" }}}
" NeoBundle {{{
" Use Vundle plugin to manage all other plugins
if filereadable(expand("~/Dropbox/dotfiles/neobundle.vimrc"))
   source ~/Dropbox/dotfiles/neobundle.vimrc
endif
" }}}
" 기본설정 적용 {{{
runtime! plugin/sensible.vim
" }}}
" Set :: Indentation {{{
" Tab키 동작 설정
set tabstop=4       " 탭당 보여지는 스페이스 크기
set softtabstop=4   " 편집할 때 적용되는 스페이스 크기. 탭키/백스페이스에 영향
set shiftwidth=4    " autoindent에 영향. 이게 없으면 들여쓰기 내어쓰기 자동정렬 안됨
set expandtab       " 탭문자 대신 스페이스 사용

nnoremap <Leader>t2 :setlocal ts=2 sw=2 sts=2<CR>
nnoremap <Leader>t4 :setlocal ts=4 sw=4 sts=4<CR>
" }}}
" Set :: UI {{{
" set relativenumber
set number
set showmode		" show current mode
set nocursorline
set wildmode=full
" TODO Ubuntu에서 에러 발생함
set fillchars=vert:│,fold:┄,diff:╱
set listchars=tab:│\ ,trail:⌴,eol:·,precedes:◂,extends:▸
set showbreak=↪
"set showmatch       " Show matching brackets. insert mode에서 커서가 
"이동한다.
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
set timeoutlen=300  " 기본값은 1000(1초)
set ttimeoutlen=-1  " 100 -> -1 : neovim에서 <esc>j 입력하면 ê 입력되는 문제 때문.
set synmaxcol=200   " 200자 넘는 라인은 syntax highlight 하지 않는다.
" }}}
" Set :: Overwrite default {{{
set noerrorbells visualbell t_vb=  " Disable bells
set formatoptions=crqwnl1          " Help fo-table
set hidden              " Change buffer - without saving
set report=0
set scrolljump=5
set shortmess=atToOI

set autoread            " Automatically reload changes if detected
set autowrite           " Writes on make/shell commands
set cf                  " Enable error files & error jumping.
set complete=.,w,b,t    " Scan current buffer, other windows buffer, loaded buffer, tags
set completeopt=menuone,preview
set tags=tags;/
"}}}
" Mappings {{{
" nnoremap <space> za
nnoremap <leader>w :w<CR>
nnoremap <C-s> <ESC>:w<CR>
inoremap <C-s> <ESC>:w<CR>i
nnoremap <leader>mp :!tmux split-window -l 5 "livedown start %:p --verbose"<CR><CR>

" 마지막 pasted text 선택
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
nnoremap <leader>p :put<CR>`[v`]o<ESC>==

" Don't move to next
nnoremap * *N
" Indent
vnoremap > >gv
vnoremap < <gv

" Moving
nnoremap j gj
nnoremap k gk
"Go to last edit location
nnoremap <leader>. '.

" 각종 toggle
nnoremap <silent> <F1> :set number!<CR>
nnoremap <silent> <F2> :set paste!<CR>
nnoremap <silent> <F3> :set spell!<CR>
nmap <leader>ts :SyntasticToggleMode<CR>

" 마지막 입력한 부분을 선택
nnoremap gV `[V`]
nnoremap Y y$
imap ;; <ESC>A
imap ;;; <ESC>A;<ESC>
imap ,, <ESC>wa
" 이전 입력한 문자열 Complete
inoremap <C-l> <C-x><C-n>
inoremap <A-/> <C-x><C-n>

nnoremap <leader>a :Ag 

" Window Movement
nnoremap <A-TAB> <C-w>w
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
if has('nvim')
  nmap <bs> :TmuxNavigateLeft<cr>
endif

tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l

" Close window
nnoremap <leader>x :bw<cr>
nnoremap <leader>xx <C-w>j:bw<CR>
" Create window splits easier.
nnoremap <silent> vv <C-w>v
nnoremap <silent> ss <C-w>s

if has('gui_running')
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

" Tabular
" nmap <leader>a" :Tabularize /"/<CR>
" nmap <leader>a, :Tabularize /,\zs<CR>
" nmap <leader>a: :Tabularize /:\zs<CR>
" nmap <leader>a= :Tabularize /=<CR>
" nmap <leader>a> :Tabularize /=>\zs<CR>
"
" vmap <leader>a" :Tabularize /"/<CR>
" vmap <leader>a, :Tabularize /,\zs<CR>
" vmap <leader>a: :Tabularize /:\zs<CR>
" vmap <leader>a= :Tabularize /=<CR>
" vmap <leader>a> :Tabularize /=>\zs<CR>
" vmap <leader>as :Tabularize / [ ]*/l0l0l0<CR>
" vmap <leader>at :Tabularize /\|/<CR>
" vmap <leader>ac :Tabularize /\/\//<CR>

" Tabular 대신에 vim-easy-plugin 사용
vmap <Enter> <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

nmap f- :s/ /\-/g \| :nohlsearch<CR>

" Select a buffer
function! BufferToggle()
    let next = bufnr("#")
    if(next > -1)
        execute ":buffer ".next
    else
        execute ":bprev"
    endif
endfunction
nnoremap ,, :call BufferToggle()<CR>
nnoremap <leader>bp :bprev<CR>
nnoremap <leader>bn :bnext<CR>

nnoremap <leader>co :copen<CR>
nnoremap <leader>cc :cc<CR>
nnoremap <leader>cp :cprev<CR>
nnoremap <leader>cn :cnext<CR>

" 마지막 변경 선택
nnoremap gp `[v`]

" Hide search highlight
nnoremap <leader>h :nohlsearch<CR>

" fugitive
nmap <leader>gs :Gstatus<cr><c-w>20+
nmap <leader>gm :Gcommit<cr>

" 인코딩 전환
nnoremap <leader>k <Esc>:e ++enc=euc-kr<CR>

" Refresh project
" play project
"nnoremap <leader>pr :!/usr/local/bin/ctags --exclude=.git --exclude=app/static --exclude=app/_static --extra=+f -R app/<CR><CR>
" flask project
nnoremap <leader>pr :!/usr/local/bin/ctags<CR><CR>

" Use Q for formatting the current paragraph (or selection)
vmap <leader>q gq
nmap <leader>q gqap

" surround with double quatation
nmap <leader>qq ysiw"

" 화면꺠졌을 때 다시 그림
nnoremap <leader>r :redraw!<CR>

" Move between tabs with t/T
nmap  <leader>1 :tabn 1<CR>
nmap  <leader>2 :tabn 2<CR>
nmap  <leader>3 :tabn 3<CR>
nmap  <leader>4 :tabn 4<CR>
nmap  <leader>5 :tabn 5<CR>
nmap  <leader>6 :tabn 6<CR>
nmap  <leader>7 :tabn 7<CR>
nmap  <leader>8 :tabn 8<CR>

" W as sudo write
command! -bar -nargs=0 W silent! exec "write !sudo tee % >/dev/null" | silent! edit!

" Remove trailing white space
map <leader>ws <ESC>:%s/\s\+$//e<CR>

"(v)im (c)ommand - execute current line as a vim command
nmap <silent> <leader>vc yy:<C-f>p<C-c><CR>

nmap <leader>cl :set cul<cr>
nmap <leader>cc :set cuc<cr>

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
    autocmd BufWritePre *.{java,js,txt,md,mardkwon,css,py} :call StripTrailingWhitespaces()

    autocmd BufNewFile,BufRead *.markdown,*.md,*.txt,*.rst setlocal wrap linebreak
    autocmd BufNewFile,BufRead *.xfdl setlocal noexpandtab
    autocmd BufNewFile,BufRead *.xfdl setlocal ft=javascript
    autocmd BufNewFile,BufRead *.html setlocal ft=htmljinja

    " FileType 지정
    autocmd BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} set ft=ghmarkdown
    autocmd BufNewFile,BufRead *.json set ft=javascript
    "autocmd BufNewFile,BufRead *.html set ft=htmldjango

    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown,play2-html setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=jedi#completions
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    autocmd Filetype java setlocal omnifunc=javacomplete#Complete

    autocmd FileType snippet,neosnippet setlocal noexpandtab
    autocmd FileType scala,jade,html,htmldjango,json,css,less,javascript,javascript.jsx setlocal sw=2 sts=2 ts=2

    autocmd BufWritePost *.mmd,*.mermaid !mermaid -t /usr/local/lib/node_modules/mermaid/dist/mermaid.forest.css -p '%:t' -v

    " 외부에서 변경된 파일 자동 다시 읽기.
    " set autoread 에 의존한다. autoread는 키입력 다음 또는 checktime에의해 실행된다.
    set updatetime=500     " CursorHold,CursorHoldI의 대기 시간.
    autocmd! CursorHold,CursorHoldI,BufEnter,WinEnter * checktime
augroup END
" }}}
" functions {{{
" 줄끝의 공백제거
function! StripTrailingWhitespaces()
python << endpython
import vim
row, col = vim.current.window.cursor
vim.command('%s/\s\+$//e')
vim.current.window.cursor = (row, col)
endpython
endfunction
" }}}
" Status line {{{
set statusline=
set statusline+=%<
set statusline+=%{strlen(fugitive#head())?fugitive#head():''}
set statusline+=%{strlen(fugitive#head())?'\ ⚡︎\ ':''}
set statusline+=%f
set statusline+=\ %h%m%r%w
set statusline+=%=      " right align
set statusline+=[%{strlen(&filetype)?&filetype:'unknown'}]
set statusline+=[%{strlen(&fileencoding)?&fileencoding:&encoding}:%{strlen(&fileformat)?&fileformat:'unknown'}]
set statusline+=\ %-14.(%l,%c%V%)\ %<%P
" }}}
" Vimrc files {{{
if filereadable(expand("~/Dropbox/dotfiles/plugins.vimrc"))
    source ~/Dropbox/dotfiles/plugins.vimrc
endif

" Parse local vimrc (useful for per-settings)
if filereadable(".lvimrc")
    source .lvimrc
endif
" }}}
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
    if has('gui_running')
        " Hide Toolbar in MacVim
        set guioptions=egmrt
        set guioptions-=r
        set guifont=Source\ Code\ Pro\ Light:h13

        set background=light
        color solarized
    else
        set background=dark

        let g:indent_guides_auto_colors = 0
        color solarized
        autocmd VimEnter * :color solarized
        autocmd VimEnter * :hi! Folded gui=bold
        autocmd VimEnter * :hi MatchParen guibg=None
        autocmd VimEnter,Colorscheme * :hi! IndentGuidesOdd  guibg=#002b36 ctermbg=darkgray
        "autocmd VimEnter,Colorscheme * :hi! IndentGuidesEven guibg=#002731 ctermbg=black
        autocmd VimEnter,Colorscheme * :hi! IndentGuidesEven guibg=#073642 ctermbg=black

        "let g:indent_guides_auto_colors = 0
        "autocmd VimEnter,Colorscheme * :hi! IndentGuidesOdd  guibg=#404042   ctermbg=black
        "autocmd VimEnter,Colorscheme * :hi! IndentGuidesEven guibg=#373739   ctermbg=darkgray
        "colorscheme kalisi
        
        " let g:indent_guides_auto_colors = 0
        " autocmd VimEnter,Colorscheme * :hi! IndentGuidesEven  guibg=#22262e   ctermbg=black
        " colorscheme spacegray
        " hi! Normal guibg=#262b34

        " color iceberg
        "let g:indent_guides_auto_colors = 0
        " hi IndentGuidesEven   guibg=#1e2132   ctermbg=black
        " hi IndentGuidesOdd  guibg=#161821   ctermbg=darkgray
    endif
endif

"if !has('gui_running')
"    "모드에 따라 cursor 모양 바꾸기
"    if exists('$TMUX')
"        let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
"        let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
"    else
"        let &t_SI = "\<Esc>]50;CursorShape=1\x7"
"        let &t_EI = "\<Esc>]50;CursorShape=0\x7"
"    endif
"endif

" }}}

let g:python_host_prog='/usr/bin/python'

" vim:foldmethod=marker:foldlevel=0
