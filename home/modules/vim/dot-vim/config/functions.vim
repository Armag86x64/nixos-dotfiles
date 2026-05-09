" Функция для более удобного ввода при большом количестве результатов
function! InputWithEscCancel(prompt)
    echohl Question
    echo a:prompt
    echohl None

    let input = ''
    while 1
        let char = getchar()

        " Esc - отмена
        if char == 27 " Код Esc
            return ''
        " Enter - завершение ввода
        elseif char == 13 " Код Enter
            break
        " Backspace
        elseif char == 8 || char == "\<BS>"
            if len(input) > 0
                let input = input[:-2]
            endif
        " Допустимые символы (цифры)
        elseif nr2char(char) =~ '[0-9]'
            let input .= nr2char(char)
        endif

        " Обновляем отображение
        redraw
        echohl Question
        echo a:prompt . input
        echohl None
    endwhile

    return input
endfunction

" Улучшенная версия функции поиска
function! EnhancedSearchWithQuickJump()
    let pattern = input('Поиск: ')

    if pattern == ''
        echo "Поиск отменен"
        return
    endif

    " Используем quickfix для более надежного поиска
    execute 'vimgrep /' . pattern . '/gj %'

    let results = getqflist()
    if len(results) == 0
        echo "Совпадений не найдено"
        return
    endif

    " Отображаем результаты
    echo "Найдено " . len(results) . " совпадений:"
    let idx = 1
    for item in results
        let line = getline(item.lnum)
        let output = '[' . idx . '] ' . item.lnum . ': ' . line
        " Подсвечиваем паттерн
        let output = substitute(output,
            \ '\V' . escape(pattern, '\'),
            \ '' . pattern . '',
            \ '')
        echo output
        let idx += 1
    endfor

    " Быстрый переход
    if len(results) < 10
        echo "Нажмите цифру 1-" . len(results) . " для перехода"
        let choice = getcharstr()

        if choice =~ '^[1-9]$'
            let choice_num = str2nr(choice)
            if choice_num <= len(results)
                call cursor(results[choice_num-1].lnum, 1)
                normal! zz
                " Временно подсвечиваем строку
                match Search /\%#.*/
                redraw
                sleep 500m
                match none
            endif
        endif
    else
        let prompt = "Введите номер (1-" . len(results) . "): "
        let choice = InputWithEscCancel(prompt)

        if choice != '' && choice =~ '^\d\+$'
            let choice_num = str2nr(choice)
            if choice_num >= 1 && choice_num <= len(results)
                call cursor(results[choice_num-1].lnum, 1)
                normal! zz
                match Search /\%#.*/
                redraw
                sleep 500m
                match none
            endif
        endif
    endif
endfunction

" Альтернативное назначение горячей клавиши
nnoremap <silent> <C-f> :call EnhancedSearchWithQuickJump()<CR>
