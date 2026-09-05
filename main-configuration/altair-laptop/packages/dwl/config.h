/* config.h - главный файл */
/* Теги */
#define TAGCOUNT (9)

/* Логирование - только здесь! */
static int log_level = WLR_ERROR;

/* Включаем все остальные файлы */
#include "autostart.h"
#include "appearance.h"
#include "layouts.h"
#include "rules.h"
#include "monitors.h"
#include "input.h"
#include "keys.h"
