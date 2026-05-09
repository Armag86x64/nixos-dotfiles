nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>
vnoremap <C-s> <Esc>:w<CR>

nnoremap <C-q> :q<CR>

nnoremap <silent> <C-S-Up> :m .-2<CR>
nnoremap <silent> <C-S-Down> :m .+1<CR>

vnoremap <silent> <C-S-Up> :m '<-2<CR>gv
vnoremap <silent> <C-S-Down> :m '>+1<CR>gv

" === Основные настройки ===
set nocompatible
filetype plugin on

" 1. d в Normal mode -> в начало строки и Insert mode
nnoremap d ^i

" Ctrl+d в Insert mode -> в начало строки
inoremap <C-d> <Esc>^i

" Ctrl+a в Insert mode -> в конец строки
inoremap <C-a> <Esc>A
nnoremap <C-a> <Esc>A

" W в Normal mode -> вверх (аналог стрелки вверх)
nnoremap W k

" S в Normal mode -> вниз (аналог стрелки вниз)
nnoremap S j

" Ctrl+Space в Normal mode -> до первого отступа
nnoremap <C-Space> ^

" Ctrl+Space в Insert mode -> до первого отступа
inoremap <C-Space> <Esc>^

" Ctrl+e в Normal mode -> в середину строки
nnoremap <C-e> gM

" Ctrl+e в Insert mode -> в середину строки
inoremap <C-e> <Esc>gMi

nnoremap <C-g> :call cursor(line('$')/2, 0)<CR>
inoremap <C-g> <Esc>:call cursor(line('$')/2, 0)<CR>i

" Ctrl+r - обновление NERDTree и перезагрузка
nnoremap <C-r> :NERDTreeRefresh<CR>:e<CR>
inoremap <C-r> <Esc>:NERDTreeRefresh<CR>:e<CR>

" Ctrl+z - откат изменений (undo)
nnoremap <C-z> u
inoremap <C-z> <Esc>ui

" Ctrl+x - отмена отката (redo)
nnoremap <C-x> <C-r>
inoremap <C-x> <Esc><C-r>i

" Ctrl+C - копирование (только в visual mode)
vnoremap <C-c> y

" Ctrl+V - вставка
nnoremap <C-v> p
inoremap <C-v> <Esc>pi

" nnoremap <expr> <C-S> SearchCharMap()
" inoremap <expr> <C-S> SearchCharMap()

function! SearchCharMap()
    " Сохраняем текущий режим
    let l:mode = mode()

    " Получаем следующую нажатую клавишу (символ)
    let l:char = getchar()

    " Преобразуем код символа в строку
    let l:char_str = nr2char(l:char)

    " Если это буква, цифра или специальный символ
    if l:char_str =~# '[[:print:]]'
        " Вызываем функцию поиска
        call SearchCharInFollowingLines(l:char_str)
    endif

    " Возвращаемся в соответствующий режим
    if l:mode ==# 'i'
        return 'i'
    else
        return ''
    endif
endfunction

function! SearchCharInFollowingLines(char)
    let l:current_line = line('.')
    let l:total_lines = line('$')

    " Сначала ищем в текущей строке, начиная с текущей позиции
    let l:start_col = col('.') - 1
    let l:line_text = getline(l:current_line)
    let l:col = stridx(l:line_text, a:char, l:start_col)

    if l:col != -1
        call cursor(l:current_line, l:col + 1)
        return
    endif

    " Ищем в следующих строках
    for l:line_num in range(l:current_line + 1, l:total_lines)
        let l:line_text = getline(l:line_num)
        let l:col = stridx(l:line_text, a:char)

        if l:col != -1
            call cursor(l:line_num, l:col + 1)
            return
        endif
    endfor

    " Если символ не найден - остаемся на месте
    " (не выводим сообщение, чтобы не мешать)
endfunction
