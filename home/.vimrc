" barebone vimrc <- this is a comment

" syntax enable

set encoding=utf-8

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set number
set showcmd

set wildmenu
set showmatch
: hi MatchParen ctermbg=lightblue

set hlsearch

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

set mouse=a

set autoindent

if has("autocmd")
    au BufReadPost *.rkt,*.rktl set filetype=racket
    au filetype racket set autoindent
    au filetype racket syntax off
endif

set completeopt=menu,menuone,noselect
