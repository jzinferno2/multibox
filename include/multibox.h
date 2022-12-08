#include <stdio.h>
#include <libgen.h>
#include <string.h>

#ifndef BB_VER
#define BB_VER "1"
#endif

#ifndef BB_NAME
#define BB_NAME "1"
#endif


typedef int (*bb_applet)(int, char **);
extern bb_applet applets_table[];
extern char *applets_name[];
extern int applets_count;
