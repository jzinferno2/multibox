VERSION = 0
PATCHLEVEL = 0
SUBLEVEL = 1
EXTRAVERSION = -jzinferno

# Do not print "Entering directory ..."
MAKEFLAGS += --no-print-directory

ifeq ($(V),1)
  Q =
else
  Q = @
endif

# CROSS_COMPILE specify the prefix used for all executables used
# during compilation. Only gcc and related bin-utils executables
# are prefixed with $(CROSS_COMPILE).
CROSS_COMPILE ?=

# Make variables (CC, etc...)
ifneq ($(LLVM),)
CC	= clang
AR	= llvm-ar
STRIP	= llvm-strip
else
CC	= $(CROSS_COMPILE)gcc
AR	= $(CROSS_COMPILE)ar
STRIP	= $(CROSS_COMPILE)strip
endif

CFLAGS	:=
LDFLAGS	:=

IMAGENAME = multibox
KERNELVERSION = $(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
CFLAGS	+= -DBB_VER='"$(KERNELVERSION)"'
CFLAGS	+= -DBB_NAME='"$(IMAGENAME)"'

CFLAGS	+= -Wall -O2 -Iinclude -Werror

obj	:= core/applets.o core/main.o applets/dirname.o

%.o:%.c Makefile
	$(Q) echo "CC    $@"
	$(Q) $(CC) $(CFLAGS) -c $< -o $@

$(IMAGENAME):$(obj)
	$(Q) echo "LINK  $(@)"
	$(Q) $(CC) $(LDFLAGS) $^ -o $(@)
	$(Q) $(STRIP) --strip-all $(@)

clean:
	$(Q) echo Clean .
	$(Q) rm -rf $(obj) $(IMAGENAME)

all:$(IMAGENAME)
