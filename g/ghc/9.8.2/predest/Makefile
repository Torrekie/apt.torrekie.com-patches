ProjectVersion := $(shell cat $(srcroot)/VERSION)

HOST_GNU_TRIPLE := aarch64-apple-darwin

BINDIST = $(srcroot)/_build/bindist/ghc-$(ProjectVersion)-$(HOST_GNU_TRIPLE)

$(BINDIST)/config.mk:
	cd $(BINDIST) && \
		./configure \
			--prefix=/usr \
			--docdir=/usr/share/doc/ghc \
			--host $(HOST_GNU_TRIPLE) --build $(HOST_GNU_TRIPLE) --target $(HOST_GNU_TRIPLE) \
			LLC=llc OPT=opt 
	# Debian set ghclibdir to libdir/ghc instead of libdir/ghc-VERSION
	echo 'ghclibdir := $$(libdir)/ghc' >> $@

	# fix LLVM target
	gsed -i 's,arm64-apple-darwin,arm64-apple-ios,g' $(BINDIST)/config.mk

all: $(BINDIST)/config.mk
