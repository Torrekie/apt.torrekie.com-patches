all:
	rm $(dstroot)/usr/lib/liblowdown.so
	mv $(dstroot)/usr/lib/liblowdown.{so.1,1.dylib}
	install_name_tool -id /usr/lib/liblowdown.1.dylib $(dstroot)/usr/lib/liblowdown.1.dylib
	ldid -s $(dstroot)/usr/lib/liblowdown.1.dylib
	chmod +x $(dstroot)/usr/lib/liblowdown.1.dylib
        ln -s liblowdown.1.dylib $(dstroot)/usr/lib/liblowdown.dylib

	ln -sf lowdown $(dstroot)/usr/bin/lowdown-diff

	mkdir -p $(dstroot)/usr/share/doc/lowdown
	mv $(dstroot)/usr/share/lowdown/odt $(dstroot)/usr/share/doc/lowdown/examples
