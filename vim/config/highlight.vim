hi Header      ctermfg=162 guifg=#ff99ff
hi Folded      cterm=bold

hi CursorLineNr cterm=none ctermfg=226 gui=none guifg=Yellow

hi ShowMarksHLl cterm=none ctermfg=9
hi ShowMarksHLo cterm=none ctermfg=11

" Java links {{{
	"hi link javaAnnotation Normal
	hi link JavaDocTags Comment
	"hi link JavaCommentTitle Comment
" }}}

" Coffee links {{{
	hi link coffeeSpecialIdent Normal
" }}}

" HTML links {{{
	hi link htmlLink Type
" }}}

" Markdown links {{{
	hi link markdownDelimiter          NonText
	hi link markdownCode               Title
	hi link markdownCodeBlock          Statement
	hi link markdownBold               String
	hi link markdownListMarker         Constant
	hi link markdownHeadingDelimiter   NonText
	hi link markdownH1                 Header
	hi link markdownH2                 Header
	hi link markdownRule               Header
	hi link markdownLinkText           Type
	hi link markdownLinkDelimiter      NonText
	hi link markdownUrl                Comment
	hi link markdownUrlDelimiter       NonText
" }}}

" play2 {{{
	hi link routesAction  Type
" }}}

" Tabbar {{{
hi! TabLineFill ctermbg=DarkGreen
hi! TabLine     ctermbg=DarkGreen
hi! TabLineSel  ctermbg=Yellow    ctermfg=Black
" }}}

" Startify {{{
hi StartifyPath ctermfg=238
hi StartifySlash ctermfg=238
" }}}
