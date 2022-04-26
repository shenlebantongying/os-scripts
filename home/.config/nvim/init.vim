set mouse=a

set expandtab

set tabstop=4
set shiftwidth=4

: hi MatchParen ctermbg=lightblue

if has("autocmd")
    au BufReadPost *.rkt,*.rktl set filetype=racket
    au filetype racket set autoindent
    au filetype racket syntax off
endif

set completeopt=menu,menuone,noselect
