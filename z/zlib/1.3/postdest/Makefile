all:
	# Move docs to default paths
	mv $(dstroot)/usr/libexec/zlib/share $(dstroot)/usr
	# Build minizip
	cd $(srcroot)/contrib/minizip && autoreconf -fiv && ./configure --prefix=/usr --enable-demos; \
	  make -j8 install DESTDIR=$(dstroot)
	mkdir -p $(dstroot)/usr/{bin,share/man/man1}
# Only do those when not using autoconf, but we will lost libraries anyway
#	make -C $(srcroot)/contrib/minizip minizip miniunzip
#	install -m755 $(srcroot)/contrib/minizip/minizip $(dstroot)/usr/bin
#	install -m755 $(srcroot)/contrib/minizip/miniunz $(dstroot)/usr/bin/miniunzip
	# minizip's autoconf not included man installation
	install -m644 $(srcroot)/contrib/minizip/minizip.1 $(dstroot)/usr/share/man/man1
	install -m644 $(srcroot)/contrib/minizip/miniunzip.1 $(dstroot)/usr/share/man/man1
	# Docs
	mkdir -p $(dstroot)/usr/share/doc/zlib/examples
	cp FAQ README doc/* $(dstroot)/usr/share/doc/zlib
	cp examples/* test/* $(dstroot)/usr/share/doc/zlib/examples
