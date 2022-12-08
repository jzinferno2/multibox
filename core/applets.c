#include "applets.h"
#include "multibox.h"

bb_applet applets_table[] = {
    dirname_main,
};

char *applets_name[] = {
    "dirname",
};

int applets_count = sizeof(applets_name) / sizeof(applets_name[0]);
