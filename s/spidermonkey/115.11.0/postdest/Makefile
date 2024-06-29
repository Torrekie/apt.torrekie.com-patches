JS_SUFFIX ?= 115

all:
	cp $(srcroot)/obj-build/dist/bin/js $(dstroot)/usr/bin/js$(JS_SUFFIX)
	mv $(dstroot)/usr/lib/libjs_static.ajs $(dstroot)/usr/lib/libmozjs-$(JS_SUFFIX).a

	mv $(dstroot)/usr/lib/libmozjs-$(JS_SUFFIX).{,0.}dylib
	install_name_tool -id /usr/lib/libmozjs-$(JS_SUFFIX).0.dylib $(dstroot)/usr/lib/libmozjs-$(JS_SUFFIX).0.dylib
	ln -s libmozjs-$(JS_SUFFIX).0.dylib $(dstroot)/usr/lib/libmozjs-$(JS_SUFFIX).dylib
	chmod a-x $(dstroot)/usr/lib/pkgconfig/mozjs-$(JS_SUFFIX).pc
	chmod a-x $(dstroot)/usr/lib/*.a
