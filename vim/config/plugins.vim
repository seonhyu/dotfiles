" Syntastic {{{
let g:syntastic_mode_map = { 'mode': 'active',
                        \ 'active_filetypes': ['coffee'],
                        \ 'passive_filetypes': ['java', 'scala'] }
" }}}

" CtrlP {{{
let g:ctrlp_working_path_mode = 0
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$|tags$|\.target|\.idea$'
" }}}

" Eclim {{{
imap <C-Space> <C-x><C-u>
" ,i imports whatever is needed for current line
nnoremap <silent> <leader>ji :JavaImportMissing<cr>
" ,d opens javadoc for statement in browser
nnoremap <silent> <leader>jd :JavaDocSearch -x declarations<cr>
" ,<enter> searches context for statement
nnoremap <silent> <leader>jc :JavaSearchContext<cr>
" ,jv validates current java file
nnoremap <silent> <leader>jv :Validate<cr>
" ,jc shows corrections for the current line of java
nnoremap <silent> <leader>jc :JavaCorrect<cr>
" 'open' on OSX will open the url in the default browser without issue
let g:EclimBrowser='open'
" }}}

" DelimitMate {{{
let delimitMate_expand_cr = 0
let delimitMate_smart_quotes = 0
let delimitMate_smart_matchpairs = 0
let delimitMate_matchpairs= "(:),[:],<:>,<%:%>,<%=:%>"

" 적용하지 않을 filetype. ,로 구분.
let delimitMate_excluded_ft = "vim"
" }}}

" Indent Guides {{{
" let g:indent_guides_start_level=1
let g:indent_guides_auto_colors=0
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_color_change_percent=3

if has('unix') && !has('gui_running')
    if $TERM == 'xterm-256color'
        " Make the guides smaller since they will be crazy visible in 256color mode
        let g:indent_guides_guide_size=1
    else
        " Turn off the guides when 256color mode isn't available
        let g:indent_guides_enable_on_vim_startup=0
    endif
endif
" }}}

" Session {{{
let g:session_autosave=0
let g:session_autoload=0
" }}}

" Screen {{{
let g:ScreenImpl = 'Tmux'
" }}}

" Neocomplcache {{{
let g:acp_enableAtStartup = 0
let g:neocomplcache_enable_auto_select = 1
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
"let g:neocomplcache_force_overwrite_completefunc = 1

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
    \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" default 100
let g:neocomplcache_max_list = 10

inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
"inoremap <expr><CR>  pumvisible() ? "\<C-y>" : "\<CR>"

" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd Filetype java setlocal omnifunc=javacomplete#Complete

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
endif
" }}}

" PowerLine {{{
let g:Powerline_colorscheme = 'default'
let g:Powerline_theme = 'default'
let g:Powerline_symbols = 'fancy'
" }}}

" Tagbar {{{
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
" }}}

" NERDTree {{{
let NERDTreeHighlightCursorline=0
"}}}

" Startify - Vim 시작화면 {{{
let g:startify_enable_special=0
" }}}

" SnipMate {{{
nnoremap ,se :SnipMateOpenSnippetFilescr>
" }}}

" ZenCoding {{{
let g:user_zen_expandabbr_key="<c-e>"
let g:user_zen_mode='inv'
" }}}

" vim-multiple-cursors {{{
let g:multi_cursor_next_key='<C-]>'
let g:multi_cursor_prev_key='<C-[>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'
" }}}

" ShowMarks {{{
let g:showmarks_enable=0
let g:showmarks_textlower="\t"
let g:showmarks_textother="\t"
"}}}

" javascript-libraries-syntax {{{
let g:used_javascript_libs = 'underscore,backbone'
"}}}--

" Unite.vim {{{
" call unite#custom#source('file,file/new,buffer,file_rec', 'matchers', 'matcher_fuzzy')
"call unite#custom#source('file_rec', 'matchers', 'matcher_fuzzy')
"call unite#custom#source('file_rec', 'ignore_pattern', '\.class$')
"let g:unite_source_rec_max_cache_files=3000
"nmap ,uc <Plug>(unite_redraw)
" }}}

" airline {{{
let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'
let g:airline_branch_prefix = '⭠ '
let g:airline_readonly_symbol = '⭤'
let g:airline_linecolumn_prefix = '⭡'
"}}}

" ConqueTerm {{{
let g:ConqueTerm_InsertOnEnter = 0
let g:ConqueTerm_CWInsert = 1
let g:ConqueTerm_Color = 2
let g:ConqueTerm_ReadUnfocused = 1 " update conqueterm buffer while we're not looking (for running tests)

" Open up a variety of commands in the ConqueTerm
"nmap <silent> <Leader>pp :execute 'ConqueTermSplit pry'<CR>

let g:ConqueTerm_SendVisKey = '<Leader>e'
"}}}

" gh-markdown {{{
" Support for github flavored markdown
" via https://github.com/jtratner/vim-flavored-markdown
augroup markdown
    au!
    au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END
"}}}

" Gundo {{{
nmap ,u :GundoToggle<CR>

" open on the right so as not to compete with the nerdtree
let g:gundo_right = 1

" a little wider for wider screens
let g:gundo_width = 60
" }}}
