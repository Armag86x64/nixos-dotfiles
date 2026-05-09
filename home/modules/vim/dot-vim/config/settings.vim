" ~/.vim/config/settings.vim

" Основные настройки
set nocompatible
set number
set encoding=utf-8
set clipboard=unnamedplus

" Автодополнение скобок
"inoremap ( ()<Left>
"inoremap { {}<Left>
"inoremap {<CR> {<CR>}<Esc>O

" Настройки табуляции
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab

" SENSIBLE настройки
set updatetime=2000
set autoread
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * checktime
set listchars

" История
set undolevels=1000
set history=1000
