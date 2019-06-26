# Build an Autoconf package
#
# Makefile targets:
#
# all/install   build and install the package
# clean         clean build products and intermediates
#
# Variables to override:
#
# MIX_COMPILE_PATH path to the build's ebin directory
#
# CC            C compiler
# CROSSCOMPILE	crosscompiler prefix, if any
# CFLAGS	compiler flags for compiling all C files
# LDFLAGS	linker flags for linking all binaries

BUSYBOX_VERSION = 1.30.1

TOP := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
SRC_TOP = $(TOP)/busybox-$(BUSYBOX_VERSION)

PREFIX = $(MIX_COMPILE_PATH)/../priv
BUILD  = $(MIX_COMPILE_PATH)/../obj

GNU_TARGET_NAME = $(notdir $(CROSSCOMPILE))
GNU_HOST_NAME =

MAKE_ENV = KCONFIG_NOTIMESTAMP=1
MAKE_OPTS = CONFIG_PREFIX="$(PREFIX)"

ifneq ($(CROSSCOMPILE),)
MAKE_OPTS += CROSS_COMPILE="$(CROSSCOMPILE)-"
endif

ifeq ($(shell uname -s),Darwin)
# Fixes to build on OSX
MAKE_OPTS += SED=gsed
MAKE = $(shell which gmake)
PATCH_DIRS = $(TOP)/patches/Darwin

ifeq ($(CROSSCOMPILE),)
$(warning Native OS compilation is not supported on OSX. Skipping compilation.)

# Do a fake install so that we can run some tests
TARGETS = fake_install
endif
endif
TARGETS ?= install

calling_from_make:
	mix compile

all: $(TARGETS)

install: $(BUILD) $(PREFIX) $(BUILD)/.config $(TOP)/make_menuconfig
	$(MAKE_ENV) $(MAKE) $(MAKE_OPTS) -C $(BUILD)
	$(MAKE_ENV) $(MAKE) $(MAKE_OPTS) -C $(BUILD) install

$(TOP)/make_menuconfig: Makefile
	# Simple script for running "make menuconfig"
	printf "#!/bin/sh\n$(MAKE_ENV) $(MAKE) $(MAKE_OPTS) -C $(BUILD) menuconfig\ncp $(BUILD)/.config $(TOP)/busybox.config" > $(TOP)/make_menuconfig

fake_install: $(PREFIX)
	mkdir -p $(PREFIX)/bin $(PREFIX)/sbin $(PREFIX)/usr/bin $(PREFIX)/usr/sbin
	echo "#!/bin/sh\necho \"BusyBox v$(BUSYBOX_VERSION) () multi-call binary.\"\n" > $(PREFIX)/bin/busybox
	echo "#!/bin/sh\nexit 1\n" > $(PREFIX)/bin/false
	echo "#!/bin/sh\nexit 1\n" > $(PREFIX)/sbin/udhcpc
	echo "#!/bin/sh\nexit 1\n" > $(PREFIX)/sbin/udhcpd
	chmod +x $(PREFIX)/bin/busybox $(PREFIX)/bin/false $(PREFIX)/sbin/udhcpc $(PREFIX)/sbin/udhcpd

# Initialize the build directory, but use our .config (use make oldconfig to fixup symbols)
$(BUILD)/.config: $(SRC_TOP)/.patched $(TOP)/busybox.config
	$(MAKE_ENV) $(MAKE) -C $(BUILD) KBUILD_SRC=$(SRC_TOP) $(MAKE_OPTS) -f $(SRC_TOP)/Makefile defconfig
	cp $(TOP)/busybox.config $(BUILD)/.config
	yes | $(MAKE_ENV) $(MAKE) $(MAKE_OPTS) -C $(BUILD) oldconfig

$(PREFIX) $(BUILD):
	mkdir -p $@

$(TOP)/busybox-$(BUSYBOX_VERSION).tar.bz2:
	curl -L https://www.busybox.net/downloads/busybox-$(BUSYBOX_VERSION).tar.bz2 > $@

$(SRC_TOP)/.extracted: $(TOP)/busybox-$(BUSYBOX_VERSION).tar.bz2
	sha256sum -c busybox.hash
	tar xf $<
	touch $(SRC_TOP)/.extracted

$(SRC_TOP)/.patched: $(SRC_TOP)/.extracted
	cd $(SRC_TOP); \
	for patchdir in $(PATCH_DIRS); do \
	    for patch in $$(ls $$patchdir); do \
		patch -p1 < "$$patchdir/$$patch"; \
	    done; \
	done

clean:
	if [ -n "$(MIX_COMPILE_PATH)" ]; then $(RM) -r $(BUILD); fi
	$(RM) -r $(SRC_TOP)

distclean: clean
	$(RM) $(TOP)/busybox-$(BUSYBOX_VERSION).tar.bz2

.PHONY: all clean distclean calling_from_make fake_install install
