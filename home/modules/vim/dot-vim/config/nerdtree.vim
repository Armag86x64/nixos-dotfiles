" ~/.vim/config/nerdtree.vim

nnoremap <C-r> :NERDTreeRefreshRoot<CR>

" при открытии директории в Vim
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter *
    \ if argc() == 1
    \ && isdirectory(argv()[0])
    \ && !exists("s:std_in")
    \ | exe 'NERDTree' argv()[0]
    \ | wincmd p | ene
    \ | exe 'cd '.argv()[0]
    \ | endif

" Автозакрытие окна NERDTree,
" если сам Vim уже закрыли
autocmd BufEnter *
    \ if (winnr("$") == 1
    \ && exists("b:NERDTree")
    \ && b:NERDTree.isTabTree())
    \ | q | endif

" Открыть/закрыть окно NERDTree
" по нажатию , в режиме NORMAL
nmap <silent> , :NERDTreeToggle<CR>
" Показываем скрытые файлы (.что-то)
let g:NERDTreeShowHidden = 1

" Показываем нумерацию папок и файлов
let g:NERDTreeShowLineNumbers = 1
