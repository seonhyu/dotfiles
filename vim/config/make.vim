
"set makeprg=/Users/moomoo/Work/Dev/Play20/play\ -Dsbt.log.noformat=true\ compile
set makeprg=play-make

set efm=%E\ %#[error]\ %f:%l:\ %m,%C\ %#[error]\ %p^,%-C%.%#,%Z,
       \%W\ %#[warn]\ %f:%l:\ %m,%C\ %#[warn]\ %p^,%-C%.%#,%Z,
       \%-G%.%#

set shellpipe=>
