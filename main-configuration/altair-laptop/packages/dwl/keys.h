/* keys.h - горячие клавиши (обновленная версия) */
#pragma once

#define MODKEY WLR_MODIFIER_LOGO

/* Вспомогательные макросы для тегов */
#define TAGKEYS(KEY,SKEY,TAG) \
    { MODKEY,                    KEY,            view,        {.ui = 1 << TAG} }, \
    { MODKEY|WLR_MODIFIER_CTRL,  KEY,            toggleview,  {.ui = 1 << TAG} }, \
    { MODKEY|WLR_MODIFIER_SHIFT, SKEY,           tag,         {.ui = 1 << TAG} }, \
    { MODKEY|WLR_MODIFIER_CTRL|WLR_MODIFIER_SHIFT,SKEY,toggletag, {.ui = 1 << TAG} }

#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* ===== КОМАНДЫ ДЛЯ ЗАПУСКА ПРИЛОЖЕНИЙ ===== */
static const char *termcmd[] = { "foot", NULL };
static const char *waypaper[] = { "waypaper", NULL };
static const char *menucmd[] = { "fuzzel", NULL };
static const char *woficmd[] = { "wofi", "--show", "drun", NULL };
static const char *browsercmd[] = { "firefox", NULL };
static const char *filemanagercmd[] = { "foot", "-e", "--app-id=yazi-terminal", "yazi", NULL };
static const char *taskcmd[] = { "foot", "-e", "--app-id=taskwarrior-tui", "taskwarrior-tui", NULL };
static const char *bottomcmd[] = { "foot", "btm", NULL };
static const char *nvimconfigcmd[] = { "foot", "nvim", "/home/soundwave/nixos-dotfiles", NULL };
static const char *nvimnotescmd[] = { "foot", "nvim", "/home/soundwave/Notes", NULL };

/* ===== КОМАНДЫ ДЛЯ ЗВУКА (Wireplumber) ===== */
static const char *vol_up_cmd[] = { "sh", "-c", "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ -l 1.0", NULL };
static const char *vol_down_cmd[] = { "sh", "-c", "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-", NULL };
static const char *vol_mute_cmd[] = { "sh", "-c", "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle", NULL };
static const char *mic_mute_cmd[] = { "sh", "-c", "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle", NULL };

/* ===== КОМАНДЫ ДЛЯ ЯРКОСТИ (Brightnessctl) ===== */
static const char *brightness_up_cmd[] = { "brightnessctl", "--class=backlight", "set", "+10%", NULL };
static const char *brightness_down_cmd[] = { "brightnessctl", "--class=backlight", "set", "10%-", NULL };

/* ===== КОМАНДЫ ДЛЯ СКРИНШОТОВ ===== */
static const char *screenshot_area_cmd[] = { "sh", "-c", "grim -g \"$(slurp)\" - | satty --filename -", NULL };
static const char *screenshot_screen_cmd[] = { "grim", NULL };
static const char *screenshot_window_cmd[] = { "sh", "-c", "grim -g \"$(slurp -f '%o:%x,%y %wx%h' -o focused)\" - | satty --filename -", NULL };

/* ===== ГОРЯЧИЕ КЛАВИШИ ===== */
static const Key keys[] = {
    /* ===== ЗАПУСК ПРИЛОЖЕНИЙ ===== */
    { MODKEY,                    XKB_KEY_q,    spawn, {.v = termcmd} },        /* Mod+Q - Терминал */
    { MODKEY,                    XKB_KEY_d,    spawn, {.v = menucmd} },        /* Mod+D - Fuzzel */
    { MODKEY,                    XKB_KEY_f,    spawn, {.v = filemanagercmd} }, /* Mod+F - Файловый менеджер */
    { MODKEY,                    XKB_KEY_w,    spawn, {.v = browsercmd} },     /* Mod+W - Браузер */
    { MODKEY,                    XKB_KEY_t,    spawn, {.v = taskcmd} },        /* Mod+T - Taskwarrior */
    { MODKEY,                    XKB_KEY_r,    spawn, {.v = woficmd} },        /* Mod+R - Wofi (drun) */
    { MODKEY,                    XKB_KEY_b,    spawn, {.v = bottomcmd} },      /* Mod+B - Bottom */
    { MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_w,    spawn, {.v = waypaper} },       /* Переместить на все теги */

    
    /* ===== VIM-режим: открытие конфигов ===== */
    { WLR_MODIFIER_SHIFT,        XKB_KEY_N,    spawn, {.v = nvimconfigcmd} },  /* Shift+N - NixOS конфиг */
    { MODKEY,                    XKB_KEY_o,    spawn, {.v = nvimnotescmd} },   /* Mod+O - Заметки */
    
    /* ===== ЗВУК (Wireplumber) ===== */
    { 0,                         XKB_KEY_XF86AudioRaiseVolume, spawn, {.v = vol_up_cmd} },   /* Громкость + */
    { 0,                         XKB_KEY_XF86AudioLowerVolume, spawn, {.v = vol_down_cmd} }, /* Громкость - */
    { 0,                         XKB_KEY_XF86AudioMute,        spawn, {.v = vol_mute_cmd} }, /* Выключить звук */
    { 0,                         XKB_KEY_XF86AudioMicMute,     spawn, {.v = mic_mute_cmd} }, /* Выключить микрофон */
     
    /* ===== ЯРКОСТЬ (Brightnessctl) ===== */
    { 0,                         XKB_KEY_XF86MonBrightnessUp,   spawn, {.v = brightness_up_cmd} },   /* Яркость + */
    { 0,                         XKB_KEY_XF86MonBrightnessDown, spawn, {.v = brightness_down_cmd} }, /* Яркость - */
    
    /* ===== СКРИНШОТЫ ===== */
    { 0,                         XKB_KEY_Print,                 spawn, {.v = screenshot_area_cmd} },   /* Print - выделенная область */
    { WLR_MODIFIER_CTRL,         XKB_KEY_Print,                 spawn, {.v = screenshot_screen_cmd} }, /* Ctrl+Print - весь экран */
    { WLR_MODIFIER_ALT,          XKB_KEY_Print,                 spawn, {.v = screenshot_window_cmd} }, /* Alt+Print - окно */
    
    /* ===== НАВИГАЦИЯ ПО ОКНАМ ===== */
    { MODKEY,                    XKB_KEY_j,    focusstack, {.i = +1} },         /* Следующее окно */
    { MODKEY,                    XKB_KEY_k,    focusstack, {.i = -1} },        /* Предыдущее окно */
    { MODKEY,                    XKB_KEY_Return, zoom, {0} },                  /* Сделать окно мастером */
    
    /* ===== УПРАВЛЕНИЕ МАСТЕР-ОБЛАСТЬЮ ===== */
    { MODKEY,                    XKB_KEY_h,    setmfact,   {.f = -0.05f} },    /* Уменьшить мастер-область */
    { MODKEY,                    XKB_KEY_l,    setmfact,   {.f = +0.05f} },    /* Увеличить мастер-область */
    { MODKEY,                    XKB_KEY_i,    incnmaster, {.i = +1} },        /* +1 окно в мастере */
    { MODKEY,                    XKB_KEY_d,    incnmaster, {.i = -1} },        /* -1 окно в мастере */
    
    /* ===== ДЕЙСТВИЯ С ОКНАМИ ===== */
    { MODKEY, XKB_KEY_c,    killclient, {0} },              /* Закрыть окно */
    { MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_space, togglefloating, {0} },         /* Плавающий режим */
    { MODKEY,                    XKB_KEY_e,    togglefullscreen, {0} },        /* Полноэкранный режим */
    
    /* ===== РАСКЛАДКИ ===== */
    { MODKEY|WLR_MODIFIER_CTRL,                    XKB_KEY_t,    setlayout, {.v = &layouts[0]} }, /* Тайл */
    { MODKEY|WLR_MODIFIER_CTRL,                    XKB_KEY_f,    setlayout, {.v = &layouts[1]} }, /* Плавающая (если layouts[1] = NULL) */
    { MODKEY|WLR_MODIFIER_CTRL,                    XKB_KEY_m,    setlayout, {.v = &layouts[2]} }, /* Монокль */
    { MODKEY,                    XKB_KEY_space, setlayout, {0} },              /* Циклично */
    
    /* ===== ТЕГИ ===== */
    { MODKEY,                    XKB_KEY_0,    view,      {.ui = ~0} },        /* Показать все теги */
    { MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_parenright, tag, {.ui = ~0} },       /* Переместить на все теги */
    
    /* Теги 1-9 */
    TAGKEYS(XKB_KEY_1, XKB_KEY_exclam, 0),
    TAGKEYS(XKB_KEY_2, XKB_KEY_at, 1),
    TAGKEYS(XKB_KEY_3, XKB_KEY_numbersign, 2),
    TAGKEYS(XKB_KEY_4, XKB_KEY_dollar, 3),
    TAGKEYS(XKB_KEY_5, XKB_KEY_percent, 4),
    TAGKEYS(XKB_KEY_6, XKB_KEY_asciicircum, 5),
    TAGKEYS(XKB_KEY_7, XKB_KEY_ampersand, 6),
    TAGKEYS(XKB_KEY_8, XKB_KEY_asterisk, 7),
    TAGKEYS(XKB_KEY_9, XKB_KEY_parenleft, 8),
     
    /* ===== ВЫХОД ===== */
    { MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_q,      quit,    {0} },               /* Mod+Shift+Q - выход */
    { WLR_MODIFIER_CTRL|WLR_MODIFIER_ALT, XKB_KEY_Terminate_Server, quit, {0} }, /* Ctrl+Alt+Backspace */
    
    /* ===== ВИРТУАЛЬНЫЕ ТЕРМИНАЛЫ ===== */
#define CHVT(n) { WLR_MODIFIER_CTRL|WLR_MODIFIER_ALT, XKB_KEY_XF86Switch_VT_##n, chvt, {.ui = (n)} }
    CHVT(1), CHVT(2), CHVT(3), CHVT(4), CHVT(5), CHVT(6),
    CHVT(7), CHVT(8), CHVT(9), CHVT(10), CHVT(11), CHVT(12),
};

/* ===== ДЕЙСТВИЯ МЫШИ ===== */
static const Button buttons[] = {
    { MODKEY, BTN_LEFT,   moveresize,     {.ui = CurMove} },    /* Переместить */
    { MODKEY, BTN_MIDDLE, togglefloating, {0} },                /* Плавающий режим */
    { MODKEY, BTN_RIGHT,  moveresize,     {.ui = CurResize} }, /* Изменить размер */
};
