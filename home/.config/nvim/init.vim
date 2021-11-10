

set autochdir

syntax enable

set encoding=utf-8

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set number
set showcmd
set cursorline

set wildmenu
set showmatch

set hlsearch

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

set mouse=a

set autoindent


"_________________________________________________________________________
" AUTOMATIC BACKUP FILES
"
" Enable backup files - Every time you save a file, it will create a copy of the file
" called <filename>~ (e.g., file.txt~) in the directory ~/.vim_backup_files/.
" This is *NOT* a comphrehensive backup solution, but it can help sometimes.
"
let &backupdir=($HOME . '/.vim_backup_files')
if ! isdirectory(&backupdir)
	call mkdir(&backupdir, "", 0700)
endif
set backup


