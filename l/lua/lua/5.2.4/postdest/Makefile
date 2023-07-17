LUA_PKG_CONFIG_DIR =		$(dstroot)/usr/libexec/lua5.2/lib/pkgconfig
LUA_PKG_CONFIG_FILE =		$(LUA_PKG_CONFIG_DIR)/lua.pc
LUA_PKG_CONFIG_FILE_FBSD =	$(LUA_PKG_CONFIG_DIR)/lua-5.2.pc
LUA_PKG_CONFIG_FILE_VER =	$(LUA_PKG_CONFIG_DIR)/lua5.2.pc
LUA_PKG_CONFIG_FILE_NODOT =	$(LUA_PKG_CONFIG_DIR)/lua52.pc
LUAPP_PKG_CONFIG_FILE =		$(LUA_PKG_CONFIG_DIR)/lua-c++.pc
LUAPP_PKG_CONFIG_FILE_FBSD =	$(LUA_PKG_CONFIG_DIR)/lua-5.2-c++.pc
LUAPP_PKG_CONFIG_FILE_VER =	$(LUA_PKG_CONFIG_DIR)/lua5.2-c++.pc
LUAPP_PKG_CONFIG_FILE_NODOT =	$(LUA_PKG_CONFIG_DIR)/lua52-c++.pc

all:
	# Basic structure
	mkdir -p $(dstroot)/usr/{bin,include,lib/lua/5.2,share/{man/man1,lua/5.2}}
	rmdir $(dstroot)/usr/libexec/lua5.2/{lib,share}/lua/5.2 || true
	# Make sure vendor dir is under default path
	ln -s /usr/lib/lua/5.2 $(dstroot)/usr/libexec/lua5.2/lib/lua/5.2
	ln -s /usr/share/lua/5.2 $(dstroot)/usr/libexec/lua5.2/share/lua/5.2
	# Version suffixes
	ln -s ../libexec/lua5.2/bin/lua $(dstroot)/usr/bin/lua5.2
	ln -s ../libexec/lua5.2/bin/lua $(dstroot)/usr/bin/lua-5.2
	ln -s ../libexec/lua5.2/bin/luac $(dstroot)/usr/bin/luac5.2
	ln -s ../libexec/lua5.2/bin/luac $(dstroot)/usr/bin/luac-5.2
	ln -s ../libexec/lua5.2/include/lua $(dstroot)/usr/include/lua5.2
	ln -s ../../../libexec/lua5.2/share/man/man1/lua.1 $(dstroot)/usr/share/man/man1/lua5.2.1
	ln -s ../../../libexec/lua5.2/share/man/man1/lua.1 $(dstroot)/usr/share/man/man1/lua-5.2.1
	ln -s ../../../libexec/lua5.2/share/man/man1/luac.1 $(dstroot)/usr/share/man/man1/luac5.2.1
	ln -s ../../../libexec/lua5.2/share/man/man1/luac.1 $(dstroot)/usr/share/man/man1/luac-5.2.1
	# Debian-like libraries with version
	for libs in "" "-c++"; do \
		ln -s liblua$${libs}.dylib $(dstroot)/usr/libexec/lua5.2/lib/liblua5.2$${libs}.dylib; \
		ln -s liblua$${libs}.a $(dstroot)/usr/libexec/lua5.2/lib/liblua5.2$${libs}.a; \
	done
	# Link versioned libraries to default path
	for libs in $(dstroot)/usr/libexec/lua5.2/lib/*.*; do \
		ln -s ../libexec/lua5.2/lib/$$(basename $${libs}) $(dstroot)/usr/lib/; \
	done
	rm -f $(dstroot)/usr/lib/liblua{,-c++}.{a,dylib}
	# Write pkgconfig
	mkdir -p $(LUA_PKG_CONFIG_DIR) $(dstroot)/usr/lib/pkgconfig
	echo "V=5.2"					>  $(LUA_PKG_CONFIG_FILE)
	echo "R=5.2.4"					>> $(LUA_PKG_CONFIG_FILE)
	echo "prefix=/usr/libexec/lua\$${V}"		>> $(LUA_PKG_CONFIG_FILE)
	echo "includedir=\$${prefix}/include"		>> $(LUA_PKG_CONFIG_FILE)
	echo "major_version=\$${V}"			>> $(LUA_PKG_CONFIG_FILE)
	echo "version=\$${R}"				>> $(LUA_PKG_CONFIG_FILE)
	echo "lib_name=lua\$${V}"			>> $(LUA_PKG_CONFIG_FILE)
	echo "libdir=\$${prefix}/lib"			>> $(LUA_PKG_CONFIG_FILE)
	echo "INSTALL_LMOD=/usr/share/lua/\$${V}"	>> $(LUA_PKG_CONFIG_FILE)
	echo "INSTALL_CMOD=/usr/lib/lua/\$${V}"		>> $(LUA_PKG_CONFIG_FILE)
	echo ""						>> $(LUA_PKG_CONFIG_FILE)
	echo "Name: Lua"				>> $(LUA_PKG_CONFIG_FILE)
	echo "Description: Lua language engine"		>> $(LUA_PKG_CONFIG_FILE)
	echo "version=\$${version}"			>> $(LUA_PKG_CONFIG_FILE)
	echo "Requires:"				>> $(LUA_PKG_CONFIG_FILE)
	echo "Libs: -L\$${libdir} -l\$${lib_name}"	>> $(LUA_PKG_CONFIG_FILE)
	echo "Cflags: -I\$${includedir}/lua"		>> $(LUA_PKG_CONFIG_FILE)
	echo "V=5.2"					>  $(LUAPP_PKG_CONFIG_FILE)
	echo "R=5.2.4"					>> $(LUAPP_PKG_CONFIG_FILE)
	echo "prefix=/usr/libexec/lua\$${V}"		>> $(LUAPP_PKG_CONFIG_FILE)
	echo "includedir=\$${prefix}/include"		>> $(LUAPP_PKG_CONFIG_FILE)
	echo "major_version=\$${V}"			>> $(LUAPP_PKG_CONFIG_FILE)
	echo "version=\$${R}"				>> $(LUAPP_PKG_CONFIG_FILE)
	echo "lib_name=lua\$${V}-c++"			>> $(LUAPP_PKG_CONFIG_FILE)
	echo "libdir=\$${prefix}/lib"			>> $(LUAPP_PKG_CONFIG_FILE)
	echo "INSTALL_LMOD=/usr/share/lua/\$${V}"	>> $(LUAPP_PKG_CONFIG_FILE)
	echo "INSTALL_CMOD=/usr/lib/lua/\$${V}"		>> $(LUAPP_PKG_CONFIG_FILE)
	echo ""						>> $(LUAPP_PKG_CONFIG_FILE)
	echo "Name: Lua"				>> $(LUAPP_PKG_CONFIG_FILE)
	echo "Description: Lua language engine"		>> $(LUAPP_PKG_CONFIG_FILE)
	echo "version=\$${version}"			>> $(LUAPP_PKG_CONFIG_FILE)
	echo "Requires:"				>> $(LUAPP_PKG_CONFIG_FILE)
	echo "Libs: -L\$${libdir} -l\$${lib_name}"	>> $(LUAPP_PKG_CONFIG_FILE)
	echo "Cflags: -I\$${includedir}/lua"		>> $(LUAPP_PKG_CONFIG_FILE)
	ln -s $$(basename $(LUA_PKG_CONFIG_FILE)) $(LUA_PKG_CONFIG_FILE_FBSD)
	ln -s $$(basename $(LUA_PKG_CONFIG_FILE)) $(LUA_PKG_CONFIG_FILE_VER)
	ln -s $$(basename $(LUA_PKG_CONFIG_FILE)) $(LUA_PKG_CONFIG_FILE_NODOT)
	ln -s $$(basename $(LUAPP_PKG_CONFIG_FILE)) $(LUAPP_PKG_CONFIG_FILE_FBSD)
	ln -s $$(basename $(LUAPP_PKG_CONFIG_FILE)) $(LUAPP_PKG_CONFIG_FILE_VER)
	ln -s $$(basename $(LUAPP_PKG_CONFIG_FILE)) $(LUAPP_PKG_CONFIG_FILE_NODOT)
	ln -s $(LUA_PKG_CONFIG_DIR)/* $(dstroot)/usr/lib/pkgconfig/
	rm $(dstroot)/usr/lib/pkgconfig/lua{,-c++}.pc
