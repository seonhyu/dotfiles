let mapleader=","

" Overwrite {{{
" Don't move to next
nnoremap * *N
" Indent
vnoremap > >gv
vnoremap < <gv
" Fixes common typos
command! W w
nmap K k
vmap K k
" }}}

" Moving {{{
nnoremap j gj
nnoremap k gk
nnoremap B ^
nnoremap E $
"Go to last edit location
nnoremap ,. '.
"}}}

" UI {{{
" 줄번호 toggle
nnoremap <silent> <F1> :set number!<CR>
" 폴딩 toggle
nnoremap <Space> za
" }}}

" Editing {{{
nnoremap <silent> <F2> :set paste!<CR>
nnoremap <silent> <F3> :set spell!<CR>
" 마지막 입력한 부분을 선택
nnoremap gV `[v`]
nnoremap Y y$
imap {<Enter> {<Enter>}<ESC>O
imap <S-Enter> <cr><esc>O
imap jj <esc>o
imap kk <esc>O
imap ;; <END>
imap ,, <ESC>wa,
imap jk <ESC>
" Normal mode에서 백스페이스는 단어단위 지우기
nnoremap <bs> bdw
" 이전 입력한 문자열 Complete
imap <C-l> <C-x><C-n>
" }}}

" Searching {{{
nnoremap <Leader>a :Ag 
" }}}

" Window {{{
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
" }}}

" Command key {{{
if has('gui_running')
    " Cmt-w로 창 닫을 때 버퍼 종료
    "map <D-w> ""
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
" }}}


" Leader {{{
    " Zoomwin
    nmap <leader>1 :ZoomWin<CR>

    " Change color scheme
    nmap <leader>9 <ESC>:set background=light<CR>
    nmap <leader>0 <ESC>:set background=dark<CR>

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

    " Browser reload
    map <leader>br :!osascript ~/.vim/refresh.scpt<CR><CR>

    " C
    nnoremap <Leader>cp :cprev<CR>
    nnoremap <Leader>cc :cc<CR>
    nnoremap <Leader>co :copen<CR>
    nnoremap <Leader>cn :cnext<CR>

    " a 마지막 변경 선택
    nnoremap gp `[v`]

    " Hide search highlight
    nnoremap <Leader>h :nohlsearch<CR>

    " 파일 Navigation
    "nnoremap ,u :Unite
    " nnoremap <silent> <Leader>f   :Unite -start-insert file_rec<cr>
"    nnoremap <silent> <Leader>fc  :Unite file<cr>
    "nnoremap ,fw :exe 'Unite -input=' . expand('<cword>') . ' file_rec'<cr>j
    "nnoremap ,pv :exe 'Unite -input=' . expand('<cword>') . '.scala.html file_rec'<cr>j
    " nnoremap <silent> <Leader>b  :Unite -start-insert buffer<CR>

    nnoremap <silent> <Leader>t   :CtrlP<CR>
    nnoremap <silent> <Leader>f   :CtrlP<CR>
    nnoremap <silent> <Leader>b  :CtrlPBuffer<CR>
    nnoremap <silent> <Leader>m  :CtrlPMRUFiles<CR>

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

    " NerdTree
    nnoremap <leader>n :NERDTreeToggle<CR>

    " OpenBrowser
    nmap <leader>o <Plug>(openbrowser-smart-search)
    vmap <leader>o <Plug>(openbrowser-smart-search)

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

    "quickfix window open/close
    nmap ,qo :copen<cr>
    nmap ,qc :cclose<cr>

    nmap ,cl :set cul<cr>
    nmap ,cc :set cuc<cr>
" }}}


cmap <Up> <C-p>

map T :TagbarToggle<CR>

" vim:foldmethod=marker:foldlevel=0
