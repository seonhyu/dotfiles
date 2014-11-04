"-------------------------------------------------- Syntastic {{{
let g:syntastic_mode_map = { 'mode': 'active',
                        \ 'active_filetypes': [],
                        \ 'passive_filetypes': ['java', 'scala', 'html'] }
" }}}
"-------------------------------------------------- CtrlP {{{
let g:ctrlp_working_path_mode = 0
let g:ctrlp_match_window_reversed = 0
" user command를 사용하면 적용되지 않는다
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$|tags$|\.target|\.idea$'
" 속도 빠르게
let g:ctrlp_user_command='ag %s -l --nocolor --hidden -g ""'

nnoremap <silent> <Leader>t   :CtrlP<CR>
"nnoremap <silent> <Leader>f   :CtrlP<CR>
"nnoremap <silent> <Leader>b  :CtrlPBuffer<CR>
"nnoremap <silent> <Leader>m  :CtrlPMRUFiles<CR>
" }}}
"-------------------------------------------------- Unite {{{
nnoremap <leader>f :Unite -start-insert file_rec<CR>
nnoremap <leader>b :Unite buffer<CR>
let g:unite_source_history_yank_enable = 1
nnoremap <leader>y :Unite history/yank<CR>
nnoremap <leader>um :Unite mapping<CR>
call unite#custom#source('buffer,file_rec', 'sorters', 'sorter_rank')
call unite#custom#source('file_rec', 'ignore_globs', split(&wildignore, ','))
" }}}
"-------------------------------------------------- DelimitMate {{{
let delimitMate_expand_cr = 0
let delimitMate_smart_quotes = 0
let delimitMate_smart_matchpairs = 0
let delimitMate_matchpairs= "(:),[:],<:>,<%:%>,<%=:%>"

" 적용하지 않을 filetype. ,로 구분.
let delimitMate_excluded_ft = "vim"

au FileType python let b:delimitMate_matchpairs = "(:),[:],{:}"
" }}}
"-------------------------------------------------- Session {{{
let g:session_autosave=0
let g:session_autoload=0
" }}}
"-------------------------------------------------- Screen {{{
let g:ScreenImpl = 'Tmux'
" }}}
"-------------------------------------------------- Neocomplete {{{
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

let g:neocomplete#enable_auto_select = 1

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
    \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> "\<BS>"

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif

if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'

"let g:neocomplete#fallback_mappings = ["\<C-x>\<C-o>","\<C-x>\<C-p>","\<C-x>\<C-n>"]

"inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" }}}
"-------------------------------------------------- jedi-vim {{{
let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 1
"let g:jedi#auto_vim_configuration = 0
" }}}
"-------------------------------------------------- Neosnippet {{{
" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

" enter 키 동작을 단순 선택에서 끝내기.
imap <expr><CR> neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? neocomplete#close_popup() : "\<CR>"

imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

if has('conceal')
    set conceallevel=2 concealcursor=i
endif
" }}}
"-------------------------------------------------- Tagbar {{{
if executable('coffeetags')
    let g:tagbar_type_coffee = {
            \ 'ctagsbin' : 'coffeetags',
            \ 'ctagsargs' : '',
            \ 'kinds' : [
            \ 'f:functions',
            \ 'o:object',
            \ ],
            \ 'sro' : ".",
            \ 'kind2scope' : {
            \ 'f' : 'object',
            \ 'o' : 'object',
            \ }
            \ }
endif

map <leader>t :TagbarToggle<CR>
" }}}
"-------------------------------------------------- NERDTree {{{
let NERDTreeHighlightCursorline=0

" NerdTree
nnoremap <leader>n :NERDTreeToggle<CR>
"}}}
"-------------------------------------------------- SnipMate {{{
nnoremap ,se :SnipMateOpenSnippetFilescr>
" }}}
"-------------------------------------------------- ZenCoding {{{
let g:user_zen_expandabbr_key="<c-e>"
let g:user_zen_mode='inv'
" }}}
"-------------------------------------------------- ShowMarks {{{
let g:showmarks_enable=0
let g:showmarks_textlower="\t"
let g:showmarks_textother="\t"
"}}}
"-------------------------------------------------- javascript-libraries-syntax {{{
let g:used_javascript_libs = 'underscore,backbone'
"}}}--
"-------------------------------------------------- airline {{{
let g:airline_powerline_fonts = 1
"}}}
"-------------------------------------------------- vim-instant-markdown {{{
let g:instant_markdown_autostart = 0
let g:instant_markdown_slow = 0
" }}}
"-------------------------------------------------- taskpaper {{{
function! s:taskpaper_setup()
    let g:task_paper_styles={'started': 'ctermbg=Red ctermfg=White guibg=Red', 'FAIL':'ctermbg=Red guibg=Red'}
endfunction

augroup vimrc-taskpaper
    autocmd!
    autocmd FileType taskpaper call s:taskpaper_setup()
augroup END

hi link taskpaperDone       Comment
hi link taskpaperComment    SpecialComment
" }}}

" vim:foldmethod=marker:foldlevel=0
