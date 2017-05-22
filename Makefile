export MACOSX_DEPLOYMENT_TARGET = 10.10

AS        = nasm
ASMACH64  = -f macho64
CC       := $(CROSS_COMPILE)$(CC)
CFLAGS    = -fno-stack-protector -fPIC -nostdlib
CPPFLAGS  =
AR        = ar
ARFLAGS   =
LD        = ld
LDFLAGS   = -lSystem

DESTDIR   =
PREFIX    = /usr/local
MANPREFIX = $(if $(subst /,,$(PREFIX)),$(PREFIX),/usr)
MAN5DIR   = $(MANPREFIX)/share/man/man5
MAN8DIR   = $(MANPREFIX)/share/man/man8
BUILDDIR  = build

SRCS      = $(wildcard src/*.c) $(wildcard src/*.asm)
DEPS      = $(patsubst src/%,$(BUILDDIR)/%,$(addsuffix .d,$(SRCS)))

-include $(BUILDDIR)/Makefile.dep

# Dependencies

$(BUILDDIR)/Makefile.dep: $(DEPS)
	@mkdir -p $(dir $(@))
	@cat $^ > $@

$(BUILDDIR)/%.c.d: src/%.c
	@mkdir -p $(dir $(@))
	@$(CC) $(CPPFLAGS) -MG -MM $^ -MF $@ -MQ $(subst .c.d,.o,$@)

$(BUILDDIR)/%.asm.d: src/%.asm
	@mkdir -p $(dir $(@))
	@$(AS) $(ASMACH64) -M -MF $@ $^

$(BUILDDIR)/%.o: src/%.c
	@mkdir -p $(dir $(@))
	$(CC) $(CFLAGS) $(CPPFLAGS) -c $< -o $@

$(BUILDDIR)/%.o: src/%.asm
	@mkdir -p $(dir $(@))
	$(AS) $(ASMACH64) -i$(dir $(<)) $< -o $@

# Targets

$(BUILDDIR)/std.a: $(BUILDDIR)/string.o $(BUILDDIR)/stdio.o $(BUILDDIR)/math.o $(BUILDDIR)/internal.o
	@mkdir -p $(dir $(@))
	$(AR) rc $@ $^

$(BUILDDIR)/libtest: $(BUILDDIR)/std.a $(BUILDDIR)/test.o $(BUILDDIR)/init.o
	@mkdir -p $(dir $(@))
	$(LD) $(LDFLAGS) $^ -o $@

.PHONY: all
all: $(BUILDDIR)/libtest

.PHONY: clean
clean:
	rm -rf $(BUILDDIR)

# Install

$(DESTDIR)$(PREFIX)/bin/% $(DESTDIR)$(PREFIX)/lib/%: $(BUILDDIR)/%
	@mkdir -p $(dir $(@))
	install -m 0755 $< -o $@

install: $(DESTDIR)$(PREFIX)/bin/libtest