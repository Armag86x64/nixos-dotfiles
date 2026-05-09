" ~/.vim/config/autocomplete.vim
" ======================================================
" КЛАССИЧЕСКАЯ СИСТЕМА АВТОДОПОЛНЕНИЯ
" Tab: перемещение ВНИЗ по меню
" Enter: выбор текущего варианта
" Shift+Tab: перемещение ВВЕРХ по меню
" ======================================================

" -----------------------------------------------------
" 1. ОСНОВНЫЕ НАСТРОЙКИ
" -----------------------------------------------------

" Настройки окна дополнений:
" menuone  - показывать меню даже с одним вариантом
" noselect - не выбирать первый вариант автоматически
" preview  - показывать дополнительную информацию
set completeopt=menuone,noselect,preview
set shortmess+=c  " Уменьшаем количество сообщений
set pumheight=10  " Высота меню дополнений
set updatetime=300  " Задержка перед показом меню

" Включаем все источники дополнений
set complete=.,w,b,u,t,i,k

" Устанавливаем безопасный omnifunc по умолчанию
set omnifunc=syntaxcomplete#Complete

" -----------------------------------------------------
" 2. КЛАВИШНЫЕ СОЧЕТАНИЯ (ГЛАВНОЕ)
" -----------------------------------------------------

" ТАБ - перемещение ВНИЗ по меню дополнений
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"

" SHIFT+TAB - перемещение ВВЕРХ по меню дополнений
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" ENTER - выбор текущего варианта из меню
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

" ESCAPE - закрытие меню дополнений
inoremap <expr> <Esc> pumvisible() ? "\<C-e>\<Esc>" : "\<Esc>"

" CTRL+SPACE - ручной запуск дополнения
inoremap <C-Space> <C-x><C-n>
inoremap <C-@> <C-x><C-n>  " Для терминалов, где Ctrl+Space не работает

" -----------------------------------------------------
" 3. АВТОЗАПУСК ДОПОЛНЕНИЯ
" -----------------------------------------------------

function! s:AutoTriggerCompletion() abort
    " Автоматически запускает дополнение при вводе определенных символов

    " Проверяем, не открыто ли уже меню
    if pumvisible()
        return ''
    endif

    let l:char = getline('.')[col('.') - 2]  " Последний введенный символ

    " Символы, после которых автоматически запускать дополнение
    if l:char ==# '.' || l:char ==# ':' || l:char ==# '>'
        " Для Rust файлов используем rust-analyzer
        if &filetype ==# 'rust'
            return s:TriggerRustAnalyzer()
        else
            " Для других файлов
            return "\<C-x>\<C-o>"
        endif
    endif

    return ''
endfunction

" Автоматический запуск дополнения при вводе символов
inoremap <silent> . .<C-r>=<SID>AutoTriggerCompletion()<CR>
inoremap <silent> : :<C-r>=<SID>AutoTriggerCompletion()<CR>
inoremap <silent> > ><C-r>=<SID>AutoTriggerCompletion()<CR>

" -----------------------------------------------------
" 4. RUST-ANALYZER ИНТЕГРАЦИЯ
" -----------------------------------------------------

function! s:TriggerRustAnalyzer() abort
    " Запуск rust-analyzer дополнения

    " Проверяем наличие coc.nvim
    if exists('*coc#refresh')
        " Используем coc.nvim
        call coc#refresh()
        return ''
    endif

    " Проверяем наличие нативного LSP (Neovim)
    if has('nvim-0.5')
        " Пробуем нативный LSP
        try
            lua vim.lsp.buf.completion()
            return ''
        catch
            " Если не сработало, используем omnifunc
        endtry
    endif

    " Используем стандартное omnifunc дополнение
    return "\<C-x>\<C-o>"
endfunction

" -----------------------------------------------------
" 5. НАСТРОЙКА ДЛЯ РАЗНЫХ ТИПОВ ФАЙЛОВ
" -----------------------------------------------------

function! s:SetupFileTypeCompletion() abort
    " Настраиваем дополнение для конкретного типа файла

    if &filetype ==# 'rust'
        " Для Rust
        if exists('*coc#complete')
            setlocal omnifunc=coc#complete
        else
            setlocal omnifunc=syntaxcomplete#Complete
        endif

    elseif &filetype ==# 'python'
        setlocal omnifunc=python3complete#Complete

    elseif &filetype ==# 'javascript' || &filetype ==# 'typescript'
        setlocal omnifunc=javascriptcomplete#CompleteJS

    elseif &filetype ==# 'html'
        setlocal omnifunc=htmlcomplete#CompleteTags

    elseif &filetype ==# 'css'
        setlocal omnifunc=csscomplete#CompleteCSS

    elseif &filetype ==# 'vim'
        setlocal omnifunc=vimcomplete#Complete

    else
        " Для остальных типов
        setlocal omnifunc=syntaxcomplete#Complete
    endif
endfunction

" -----------------------------------------------------
" 6. АВТОЗАКРЫТИЕ СКОБОК (ОТДЕЛЬНЫЕ КЛАВИШИ)
" -----------------------------------------------------

" Автозакрытие скобок на отдельные клавиши
inoremap ( ()<Left>
inoremap { {}<Left>
inoremap [ []<Left>
inoremap " ""<Left>
inoremap ' ''<Left>
inoremap ` ``<Left>

" Умное автозакрытие для фигурных скобок с переносом
inoremap {<CR> {<CR>}<Esc>O

" -----------------------------------------------------
" 7. ДОПОЛНИТЕЛЬНЫЕ ФУНКЦИИ ДОПОЛНЕНИЯ
" -----------------------------------------------------

function! s:ManualCompletion() abort
    " Ручной запуск дополнения по Ctrl+Space

    if pumvisible()
        return ''
    endif

    " Определяем тип дополнения по контексту
    let l:line = getline('.')
    let l:col = col('.') - 1
    let l:before = l:line[:l:col-1]

    if l:before =~# '\.\s*$' || l:before =~# '::\s*$'
        " После точки или :: - языковое дополнение
        return "\<C-x>\<C-o>"
    elseif l:before =~# '\(/\|\~\)\s*$'
        " После / или ~ - дополнение файлов
        return "\<C-x>\<C-f>"
    else
        " Обычное дополнение по словам
        return "\<C-x>\<C-n>"
    endif
endfunction

" Переназначаем Ctrl+Space на умное дополнение
inoremap <expr> <C-Space> <SID>ManualCompletion()
inoremap <expr> <C-@> <SID>ManualCompletion()

" -----------------------------------------------------
" 8. АВТОКОМАНДЫ ДЛЯ АВТОМАТИЧЕСКОЙ НАСТРОЙКИ
" -----------------------------------------------------

augroup AutoCompleteConfig
    autocmd!

    " Настраиваем дополнение для каждого типа файла
    autocmd FileType * call s:SetupFileTypeCompletion()

    " Специальные настройки для Rust
    autocmd FileType rust call s:SetupRust()

    " Автоматическое закрытие меню дополнений
    autocmd InsertLeave * if pumvisible() == 0 | pclose | endif
augroup END

function! s:SetupRust() abort
    " Дополнительные настройки для Rust

    echo "[AutoComplete] Rust configuration loaded"

    " Настройки форматирования
    let g:rustfmt_autosave = 1
    let g:rustfmt_emit_files = 1

    " Настройки для rust-analyzer через coc
    if exists('*coc#refresh')
        echo "[AutoComplete] Using coc.nvim for Rust completion"

        " Дополнительные маппинги для Rust
        nmap <silent> <buffer> gd <Plug>(coc-definition)
        nmap <silent> <buffer> gy <Plug>(coc-type-definition)
        nmap <silent> <buffer> gi <Plug>(coc-implementation)
        nmap <silent> <buffer> gr <Plug>(coc-references)
    endif
endfunction

" -----------------------------------------------------
" 9. УТИЛИТЫ И ДИАГНОСТИКА
" -----------------------------------------------------

function! s:ShowCompletionInfo() abort
    " Показывает информацию о системе дополнения

    echo "=== AutoComplete System ==="
    echo "Filetype: " . &filetype
    echo "omnifunc: " . &omnifunc
    echo "completeopt: " . &completeopt
    echo "---------------------------"
    echo "Key mappings:"
    echo "  Tab: Navigate DOWN in completion menu"
    echo "  Shift+Tab: Navigate UP in completion menu"
    echo "  Enter: Select current completion"
    echo "  Ctrl+Space: Manual completion trigger"
    echo "---------------------------"

    " Rust-специфичная информация
    if &filetype ==# 'rust'
        echo "Rust-specific:"
        if exists('*coc#refresh')
            echo "  ✓ coc.nvim/rust-analyzer available"
            echo "  ✓ Auto-completion on '.' and '::'"
        else
            echo "  ✗ coc.nvim/rust-analyzer not detected"
            echo "  Using basic completion"
        endif
    endif
endfunction

command! CompletionInfo call s:ShowCompletionInfo()

" -----------------------------------------------------
" 10. НАСТРОЙКА ВНЕШНЕГО ВИДА
" -----------------------------------------------------

" Цвета для меню дополнений (адаптировано под ayu)
highlight Pmenu guibg=#0f1419 guifg=#bfbdb6 gui=NONE
highlight PmenuSel guibg=#2e3540 guifg=#ffcc66 gui=bold
highlight PmenuSbar guibg=#1a1f29
highlight PmenuThumb guibg=#3a424e

" -----------------------------------------------------
" 10. ПРОВЕРКА И ИНИЦИАЛИЗАЦИЯ
" -----------------------------------------------------

function! s:InitializeCompletionSystem() abort
    " Инициализация системы дополнений

    " Проверяем наличие rust-analyzer
    let s:has_rust_analyzer = 0

    if exists('*coc#refresh')
        let s:has_rust_analyzer = 1
        echo "[AutoComplete] coc.nvim detected"
    endif

    if executable('rust-analyzer')
        let s:has_rust_analyzer = 1
        echo "\n[AutoComplete] rust-analyzer binary found"
    endif

    " Показываем статус
    if &filetype ==# 'rust'
        if s:has_rust_analyzer
            echo "[AutoComplete] Rust: rust-analyzer integration ENABLED"
        else
            echo "[AutoComplete] Rust: Using basic completion"
        endif
    endif

    echo "[AutoComplete] System ready"
    echo "[AutoComplete] Tab=Navigate, Enter=Select, Shift+Tab=Navigate up"
endfunction

" Запускаем инициализацию при загрузке
call timer_start(100, {-> s:InitializeCompletionSystem()})

" -----------------------------------------------------
" КОНЕЦ МОДУЛЯ
" -----------------------------------------------------
