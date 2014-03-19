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
    " set autoread 에 의존한다. autoread는 키입력 다음 또는 checktime에 의해
    " 실행된다.
    set updatetime=1000     " CursorHold,CursorHoldI의 대기 시간.
    autocmd! CursorHold,CursorHoldI,BufEnter,WinEnter *.{java,scala,coffee,html,js} checktime
augroup END

function! StripTrailingWhitespaces()
    " save last cusor postion
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction
