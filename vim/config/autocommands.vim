if has("autocmd")
    " No formatting on o key newlines
    autocmd BufNewFile,BufEnter * set formatoptions-=o

    " When editing a file, always jump to the last cursor position.
    " This must be after the uncompress commands.
    autocmd BufReadPost *
                \ if line("'\"") > 1 && line ("'\"") <= line("$") |
                \   exe "normal! g`\"" |
                \ endif

    au BufNewFile,BufRead *.markdown,*.md,*.txt,*.rst setlocal wrap linebreak

    " FileType 지정
    au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} set ft=markdown
    au BufNewFile,BufRead *.json set ft=javascript

    aut BufRead,BufNewFile *.html set ft=html
    "au FileType play2-html runtime! indent/html.vim
    "au FileType play2-html runtime! autoload/htmlcomplete.vim
    "au FileType play2-html let b:delimitMate_quotes = "\" "

    "set ofu=syntaxcomplete#Complete
    set completeopt=menu,menuone,longest
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown,play2-html setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    "autocmd FileType java setlocal omnifunc=javacomplete#Complete
    "autocmd Filetype java setlocal completefunc=javacomplete#CompleteParamsInfo

    autocmd FileType snippet setlocal noexpandtab

    "au BufWritePost *.coffee silent CoffeeMake! -b | cwindow

    autocmd FileType scala,jade,html,css,json,less setlocal sw=2 sts=2 ts=2

    " 외부에서 변경된 파일 자동 다시 읽기.
    " set autoread 에 의존한다. autoread는 키입력 다음 또는 checktime에 의해 
    " 실행된다.
    set updatetime=1000     " CursorHold,CursorHoldI의 대기 시간.
    au! CursorHold,CursorHoldI,BufEnter,WinEnter *.{java,scala,coffee,html,js} checktime

endif

function! PlayMake()
    silent make
    redraw!
    try
        cc
    catch
        echo "No Errors"
    endtry
endfunction
