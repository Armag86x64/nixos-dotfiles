" Альтернативная версия с точным контролем размера
" ~/.vim/config/ui.vim

" Функция для точного увеличения шрифта в 1.5 раза
function! IncreaseFont150()
    if has('gui_running')
        " Получаем текущий шрифт
        let current_font = &guifont

        " Ищем размер шрифта в формате :hXX
        let size_match = matchstr(current_font, ':h\d\+')

        if !empty(size_match)
            " Извлекаем текущий размер
            let current_size = str2nr(matchstr(size_match, '\d\+'))

            " Увеличиваем в 1.5 раза
            let new_size = float2nr(current_size * 1.5)

            " Заменяем размер в строке шрифта
            let new_font = substitute(current_font, ':h\d\+', ':h' . new_size, '')
            let &guifont = new_font

            echo "Font increased from " . current_size . " to " . new_size . " (1.5x)"
        else
            " Если размер не указан, устанавливаем по умолчанию
            if has('mac')
                set guifont=Menlo\ Regular:h18
            elseif has('win32') || has('win64')
                set guifont=Consolas:h15
            else
                set guifont=DejaVu\ Sans\ Mono\ 15
            endif
            echo "Font set to 1.5x default size"
        endif
    else
        echo "Cannot change font size in terminal mode"
    endif
endfunction

" Автоматически увеличиваем шрифт при загрузке
call IncreaseFont150()

set t_Co=256
set termguicolors

" let ayucolor="dark"

" colorscheme ayu
colorscheme ashen
set cursorline
hi CursorLine gui=NONE cterm=NONE

set background=dark

if !has('gui_running')
    set t_Co=256
endif

" Курсор и мышь
set mouse=a
set ruler
set scrolloff=5
set cursorline

autocmd InsertEnter,InsertLeave * set cursorline!
