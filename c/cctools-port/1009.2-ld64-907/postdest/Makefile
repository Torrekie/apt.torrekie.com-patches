all:
	# Match how Apple does
	ln -s codesign_allocate $(dstroot)/usr/bin/codesign_allocate-p
	# Apple now uses LLVM tools by default, and move old tools with suffix
	for tools in nm objdump otool; do \
		if [ -e $(dstroot)/usr/bin/$${tools} ]; then mv $(dstroot)/usr/bin/$${tools} $(dstroot)/usr/bin/$${tools}-classic; fi; \
		ln -s llvm-$${tools} $(dstroot)/usr/bin/$${tools}; \
	done
	# ld is now the driver
	rm $(dstroot)/usr/share/man/man1/ld64.1
	mv $(dstroot)/usr/share/man/man1/ld-classic.1 $(dstroot)/usr/share/man/man1/ld.1
	# no dyld_debug for Release
	rm $(dstroot)/usr/share/man/man3/dyld_debug.3
	# cctools-port seems missing vtool.1
	install -m644 $(srcroot)/cctools/man/vtool.1 $(dstroot)/usr/share/man/man1/vtool.1
	# compat symlink
	# Consider redo libcodedirectory things
	mkdir -p $(dstroot)/usr/lib
	ln -s /usr/lib/swift/libswiftDemangle.dylib $(dstroot)/usr/lib/libswiftDemangle.dylib
