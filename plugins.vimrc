"-------------------------------------------------- Syntastic {{{
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_mode_map = { 'passive_filetypes': ['java'] }

nmap ,ln :lnext<CR>
nmap ,lp :lprevious<CR>
nmap ,sr :SyntasticReset<CR>
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
" }}}
"-------------------------------------------------- youcompleteme {{{
let g:ycm_server_keep_logfiles = 0
let g:ycm_server_log_level = 'debug'
let g:ycm_path_to_python_interpreter = '/usr/bin/python'
" tab을 ultisnips에 양보
let g:ycm_key_list_select_completion=['<C-j>', '<CR>']
let g:ycm_key_list_previous_completion=['<C-k>']
" }}}
"-------------------------------------------------- UltiSnips {{{
" emmet과 tab키 충돌 해결
function! Smart_tab()
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
autocmd BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=Smart_tab()<cr>"

nnoremap ,se :UltiSnipsEdit<CR>
" }}}
"-------------------------------------------------- MatchTagAlways {{{
let g:mta_use_matchparen_group = 1
let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'jinja' : 1,
    \}
" }}}

" vim:foldmethod=marker:foldlevel=0
"
