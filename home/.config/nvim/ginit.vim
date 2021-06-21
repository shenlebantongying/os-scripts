" additional settings for nvim-qt

" include terminal config
runtime init.vim

set bg=light

nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
vnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>

if exists(':GuiFont')
    GuiFont Hack:h13
endif

if exists(':GuiScrollBar')
    GuiScrollBar 1
endif

if exists(':GuiTreeviewShow')
    GuiTreeviewShow
endif

