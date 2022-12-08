#include "applets.h"
#include "multibox.h"

int main(int argc, char **argv)
{
    if (!strncmp(basename(argv[0]), BB_NAME, strlen(BB_NAME)))
    {
        if (!argv[1] || (!strncmp(argv[1], "-h", 2) && strlen(argv[1]) == 2) || (!strncmp(argv[1], "--help", 6) && strlen(argv[1]) == 6))
        {
            puts("usage: " BB_NAME " [function [arguments]...]");
        }
        else if (!argv[1] || (!strncmp(argv[1], "-v", 2) && strlen(argv[1]) == 2) || (!strncmp(argv[1], "--version", 9) && strlen(argv[1]) == 9))
        {
            puts(BB_VER);
        }
        else
        {
            for (int i = 0; i < applets_count; i++)
            {
                if (!strcmp(argv[1], applets_name[i]))
                {
                    argc--;
                    argv++;
                    return applets_table[i](argc, argv);
                }
            }
        }
    }
    else
    {
        for (int i = 0; i < applets_count; i++)
        {
            if (!strcmp(basename(argv[0]), applets_name[i]))
            {
                return applets_table[i](argc, argv);
            }
        }
    }
    return 0;
}
