/* monitors.h */
#pragma once

static const MonitorRule monrules[] = {
    /* name   mfact  nmaster  scale  layout     transform         x  y */
    { "eDP-1", 0.55f, 1,      1,     &layouts[0], WL_OUTPUT_TRANSFORM_NORMAL, -1, -1 },
    /* дефолтное правило */
    { NULL,    0.55f, 1,      1,     &layouts[0], WL_OUTPUT_TRANSFORM_NORMAL, -1, -1 },
};
