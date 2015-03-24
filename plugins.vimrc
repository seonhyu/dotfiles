"-------------------------------------------------- Syntastic {{{
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

nmap ,ln :lnext<CR>
nmap ,lp :lprevious<CR>
" }}}
"-------------------------------------------------- CtrlP {{{
let g:ctrlp_working_path_mode = 0
let g:ctrlp_match_window_reversed = 0
" user command를 사용하면 적용되지 않는다
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$|tags$|\.target|\.idea$'
" 속도 빠르게
"let g:ctrlp_user_command='ag %s -l --nocolor --hidden -g ""'

unlet g:ctrlp_custom_ignore
let g:ctrlp_custom_ignore = {
  \ 'hiddendir':  '\v[\/]\.(git|hg|svn|bower_components)$',
  \ 'dir':  '\v[\/](bower_components|webassets-external|__pycache__)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

nnoremap <silent> <Leader>f  :CtrlP<CR>
nnoremap <silent> <Leader>b  :CtrlPBuffer<CR>
nnoremap <silent> <Leader>m  :CtrlPMRUFiles<CR>
" }}}
"-------------------------------------------------- Unite {{{
"let g:unite_source_history_yank_enable = 1
"call unite#custom#source('buffer,file_rec', 'sorters', 'sorter_rank')
"call unite#custom#source('file_rec', 'ignore_globs', split(&wildignore, ','))
"nnoremap <leader>f :Unite -start-insert file_rec<CR>
"nnoremap <leader>b :Unite buffer<CR>
"nnoremap <leader>y :Unite history/yank<CR>
"nnoremap <leader>um :Unite mapping<CR>
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
"let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'

"let g:neocomplete#fallback_mappings = ["\<C-x>\<C-o>","\<C-x>\<C-p>","\<C-x>\<C-n>"]

"inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" }}}
"-------------------------------------------------- jedi-vim {{{
let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 1
"let g:jedi#auto_vim_configuration = 0
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
"-------------------------------------------------- ShowMarks {{{
let g:showmarks_enable=0
let g:showmarks_textlower="\t"
let g:showmarks_textother="\t"
"}}}
"-------------------------------------------------- javascript-libraries-syntax {{{
let g:used_javascript_libs = 'underscore,backbone'
"}}}--
"-------------------------------------------------- airline {{{
"let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_left_sep = '»'
let g:airline_left_sep = ''
let g:airline_right_sep = '«'
let g:airline_right_sep = ''
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'
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
"-------------------------------------------------- Emmet {{{
" neosnippet 참조
" }}}
"-------------------------------------------------- youcompleteme {{{
let g:ycm_server_keep_logfiles = 0
let g:ycm_server_log_level = 'debug'

" tab을 ultisnips에 양보
let g:ycm_key_list_select_completion=['<C-j>', '<CR>']
let g:ycm_key_list_previous_completion=['<C-k>']
" }}}
"-------------------------------------------------- UltiSnips {{{
" emmet과 tab키 충돌 해결
function! g:smart_tab()
  if (matchstr(getline("."), '^\s*#') != "") || (matchstr(getline("."), '^\s*\.') != "")
    call emmet#expandAbbr(3, "")
    return "\<esc>cit\<cr>\<esc>O"
  else
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
      if pumvisible()
        return "\<C-n>"
      else
        call UltiSnips#JumpForwards()
        if g:ulti_jump_forwards_res == 0
          return "\<tab>"
        endif
      endif
    endif
    return ""
  endif
endfunction
let g:UltiSnipsJumpForwardTrigger="<tab>"
autocmd BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:smart_tab()<cr>"

nnoremap ,se :UltiSnipsEdit<CR>
" }}}

" vim:foldmethod=marker:foldlevel=0
"
