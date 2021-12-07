set number
set mouse=a
set cursorline
syntax off

set expandtab

colorscheme dichromatic

hi MatchParen ctermbg=blue

if has("autocmd")
    au BufReadPost *.rkt,*.rktl set filetype=racket
    au filetype racket set autoindent
    au filetype racket set tabstop=4
    au filetype racket set shiftwidth=4
endif
