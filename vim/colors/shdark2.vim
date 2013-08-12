" Vim color scheme
"
" Name:         blackboard.vim
" Maintainer:   Ben Wyrosdick <ben.wyrosdick@gmail.com>
" Last Change:  20 August 2009
" License:      public domain
" Version:      1.4

set background=dark
hi clear
if exists("syntax_on")
   syntax reset
endif

let g:colors_name = "shdark2"

" Colours in use
" --------------

if has("gui_running")
  "hi Normal       guifg=#839496 guibg=#002833 
  hi Normal       guifg=#8c9c9e guibg=#002833 
  hi VertSplit    guifg=#000000 guibg=#002833 

  hi Comment      guifg=#525f61
  hi Constant     guifg=#B455A2
  hi Cursor       guifg=black   guibg=white   
  hi CursorLine                 guibg=#003540
  hi Folded       guifg=#525f61 guibg=#1c1c1c 
  hi Function     guifg=#c94c22               gui=NONE
  hi Identifier   guifg=#50BA6E               gui=NONE    
  hi Keyword      guifg=#2e8ccf               gui=NONE
  hi LineNr       guifg=#586e75 guibg=#003540
  "hi NonText      guifg=#001b22
  hi NonText      guifg=#3b4445
  hi MatchParen   guifg=#C6EA82 guibg=#3b4d5e 
  hi Pmenu        guifg=#84a2c6 guibg=#495c7f 
  hi PmenuSel     guifg=#ecebeb guibg=#7AAD4C 
  hi PreProc      guifg=#a83b2a
  hi Search       guibg=#566D52 guifg=#C6EA82 gui=NONE
  hi Special      guifg=#b4881d               gui=NONE 
  hi SpecialChar  guifg=#ea577b               gui=bold
  hi SpecialKey   guifg=#4a4a59
  hi Statement    guifg=#859b1c               gui=NONE 
  hi StatusLine   guifg=#000000 guibg=#FAF1C2 gui=italic
  hi StatusLineNC guifg=#000000 guibg=#ECEBEB gui=NONE
  hi String       guifg=#32a198
  hi Title        guifg=#B455A2 gui=NONE
  hi Type         guifg=#86BCE3               gui=NONE
  "hi Visual                     guibg=#003540
  hi Visual                     guibg=#3b4d5e
  hi WarningMsg   guifg=#F4DC4A               

  " HTML colors
  hi link htmlTag           Type
  hi link htmlEndTag        htmlTag
  hi link htmlTagName       Keyword
  hi link htmlArg           htmlTag
  hi htmlH1 gui=Bold guifg=#a83b2a
  hi htmlH2 gui=None guifg=#a83b2a

  " Markdown
  hi link markdownCodeBlock Statement
  hi link markdownCode      Statement
  hi link markdownBold      String

  "Java Colors
  hi link javaExternal Keyword
  hi javaAnnotation guifg=#d6dbdc

  " Vim syntax
  hi link vimCommand Keyword

  "Ruby Colors
  hi link rubyClass            Keyword
  hi link rubyDefine           Keyword
  hi link rubyConstant         Type
  hi link rubySymbol           Constant
  hi link rubyStringDelimiter  rubyString
  hi link rubyInclude          Keyword
  hi link rubyAttribute        Keyword
  hi link rubyInstanceVariable Normal

  "Rails Colors
  hi link railsMethod Type

  "Sass colors
  hi link sassMixin Keyword
  hi link sassMixing Constant

  "Outliner colors
  hi OL1 guifg=#FFA34B
  hi OL2 guifg=#50BA6E
  hi OL3 guifg=#84A7C1
  hi OL4 guifg=#C6EA82
  hi BT1 guifg=#AEAEAE
  hi link BT2 BT1
  hi link BT3 BT1
  hi link BT4 BT1

  "Git colors
  hi gitcommitSelectedFile  guifg=#61CE3C
  hi gitcommitDiscardedFile guifg=#C23621
  hi gitcommitWarning       guifg=#C23621
  hi gitcommitBranch        guifg=#FFDE00
  hi gitcommitHeader        guifg=#84A7C1

  " Taskpaper
  hi link taskpaperDone Comment
  hi link taskpaperCancelled Comment
end
