" Vim color file - Ashen
" Based on Zed theme Ashen
" Maintainer: Converted from ashen_theme.json

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "ashen"

" Палитра (максимально близко к оригиналу)
let s:bg           = "#121212"
let s:bg_dark      = "#0e0e0e"
let s:bg_light     = "#151515"
let s:bg_elevated  = "#191919"
let s:bg_element   = "#212121"
let s:bg_hover     = "#323232"
let s:fg           = "#b4b4b4"
let s:fg_muted     = "#949494"
let s:fg_placeholder = "#737373"
let s:fg_disabled  = "#535353"
let s:accent       = "#DF6464"
let s:accent_dark  = "#B14242"
let s:orange       = "#E49A44"
let s:blue         = "#4A8B8B"
let s:green        = "#629C7D"
let s:yellow       = "#E5A72A"
let s:red          = "#C53030"
let s:red_dark     = "#B14242"
let s:purple       = "#a7a7a7"
let s:white        = "#d5d5d5"
let s:gray         = "#737373"
let s:line         = "#323232"
let s:line_active  = "#535353"

" Функция для установки цветов с поддержкой гуи (и терминала 256 цветов)
fun! <sid>hi(group, guifg, guibg, gui, ctermfg, ctermbg, cterm)
  if a:guifg != ""
    exec "hi " . a:group . " guifg=" . a:guifg
  endif
  if a:guibg != ""
    exec "hi " . a:group . " guibg=" . a:guibg
  endif
  if a:gui != ""
    exec "hi " . a:group . " gui=" . a:gui
  endif
  if a:ctermfg != ""
    exec "hi " . a:group . " ctermfg=" . a:ctermfg
  endif
  if a:ctermbg != ""
    exec "hi " . a:group . " ctermbg=" . a:ctermbg
  endif
  if a:cterm != ""
    exec "hi " . a:group . " cterm=" . a:cterm
  endif
endfun

" Общие элементы интерфейса
call <sid>hi("Normal",       s:fg, s:bg, "",         "254", "233", "")
call <sid>hi("NonText",      s:fg_placeholder, "", "",       "242", "",   "")
call <sid>hi("Cursor",       s:bg, s:accent, "",     "233", "203", "")
call <sid>hi("LineNr",       s:fg_disabled, "", "",          "239", "",   "")
call <sid>hi("CursorLineNr", s:fg, "", "",                  "254", "",   "")
call <sid>hi("CursorLine",   "",   s:bg_element, "",   "",   "235", "")
call <sid>hi("ColorColumn",  "",   s:bg_dark, "",     "",   "234", "")
call <sid>hi("StatusLine",   s:fg, s:bg_elevated, "none", "254", "236", "NONE")
call <sid>hi("StatusLineNC", s:fg_disabled, s:bg_dark, "none", "239", "234", "NONE")
call <sid>hi("VertSplit",    s:line, s:bg, "none",   "236", "233", "NONE")
call <sid>hi("TabLine",      s:fg_muted, s:bg_light, "none", "242", "235", "NONE")
call <sid>hi("TabLineFill",  s:fg_muted, s:bg, "none",          "242", "233", "NONE")
call <sid>hi("TabLineSel",   s:fg, s:bg_element, "none",        "254", "235", "NONE")
call <sid>hi("Title",        s:accent_dark, "", "bold",         "167", "",   "bold")
call <sid>hi("Directory",    s:blue, "", "",                    "110", "",   "")
call <sid>hi("MatchParen",   s:bg, s:orange, "",                "233", "215", "")

" Поиск
call <sid>hi("Search",       s:fg, s:bg_hover, "",      "254", "236", "")
call <sid>hi("IncSearch",    s:bg, s:orange, "",        "233", "215", "")

" Окна и границы
call <sid>hi("Pmenu",        s:fg, s:bg_element, "",      "254", "235", "")
call <sid>hi("PmenuSel",     s:bg, s:blue, "",            "233", "110", "")
call <sid>hi("PmenuSbar",    "",   s:bg_hover, "",        "",   "236", "")
call <sid>hi("PmenuThumb",   "",   s:fg_placeholder, "",  "",   "242", "")

" Боковые панели (например, netrw)
call <sid>hi("VertSplit",    s:line, s:bg, "",     "236", "233", "")

" Синтаксис (ключевое — переведено из syntax секции JSON)
call <sid>hi("Comment",      s:gray, "", "italic",        "242", "",   "italic")
call <sid>hi("Constant",     s:orange, "", "",            "173", "",   "")
call <sid>hi("String",       s:accent, "", "",            "203", "",   "")
call <sid>hi("Character",    s:accent, "", "",            "203", "",   "")
call <sid>hi("Number",       s:blue, "", "",              "110", "",   "")
call <sid>hi("Boolean",      s:blue, "", "",              "110", "",   "")
call <sid>hi("Float",        s:blue, "", "",              "110", "",   "")
call <sid>hi("Identifier",   s:white, "", "",             "254", "",   "")
call <sid>hi("Function",     s:white, "", "",             "254", "",   "")
call <sid>hi("Statement",    s:red_dark, "", "bold",      "167", "",   "bold")
call <sid>hi("Conditional",  s:red_dark, "", "",          "167", "",   "")
call <sid>hi("Repeat",       s:red_dark, "", "",          "167", "",   "")
call <sid>hi("Label",        s:red_dark, "", "",          "167", "",   "")
call <sid>hi("Operator",     s:orange, "", "",            "173", "",   "")
call <sid>hi("Keyword",      s:red_dark, "", "",          "167", "",   "")
call <sid>hi("Exception",    s:red_dark, "", "",          "167", "",   "")
call <sid>hi("PreProc",      s:red_dark, "", "",          "167", "",   "")
call <sid>hi("Include",      s:red_dark, "", "",          "167", "",   "")
call <sid>hi("Define",       s:red_dark, "", "",          "167", "",   "")
call <sid>hi("Macro",        s:red_dark, "", "",          "167", "",   "")
call <sid>hi("PreCondit",    s:red_dark, "", "",          "167", "",   "")
call <sid>hi("Type",         s:orange, "", "",            "173", "",   "")
call <sid>hi("StorageClass", s:orange, "", "",            "173", "",   "")
call <sid>hi("Structure",    s:orange, "", "",            "173", "",   "")
call <sid>hi("Typedef",      s:orange, "", "",            "173", "",   "")
call <sid>hi("Special",      s:yellow, "", "",            "221", "",   "")
call <sid>hi("SpecialChar",  s:white, "", "",             "254", "",   "")
call <sid>hi("Tag",          s:fg_muted, "", "",          "242", "",   "")
call <sid>hi("Delimiter",    s:orange, "", "",            "173", "",   "")
call <sid>hi("Debug",        s:yellow, "", "",            "221", "",   "")

" Дополнительные элементы
call <sid>hi("Todo",         s:bg, s:yellow, "bold",      "233", "221", "bold")
call <sid>hi("Error",        s:red, s:bg_dark, "bold",    "196", "234", "bold")
call <sid>hi("WarningMsg",   s:yellow, "", "bold",        "221", "",   "bold")
call <sid>hi("ModeMsg",      s:blue, "", "",              "110", "",   "")
call <sid>hi("MoreMsg",      s:blue, "", "",              "110", "",   "")
call <sid>hi("Question",     s:blue, "", "",              "110", "",   "")

" Различия (diff)
call <sid>hi("diffAdded",    s:green, "", "",             "72",  "",   "")
call <sid>hi("diffRemoved",  s:red_dark, "", "",          "167", "",   "")
call <sid>hi("diffChanged",  s:orange, "", "",            "173", "",   "")
call <sid>hi("diffFile",     s:blue, "", "",              "110", "",   "")
call <sid>hi("diffLine",     s:fg_muted, "", "",          "242", "",   "")

" Качество жизни
hi! link Visual         PmenuSel
hi! link VisualNOS      Visual
hi! link Folded         Comment
hi! link FoldColumn     LineNr
hi! link SignColumn     LineNr
hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC
hi! link WildMenu       PmenuSel
hi! link SpellBad       Error
hi! link SpellCap       WarningMsg
hi! link SpellRare      Todo
hi! link SpellLocal     Search
