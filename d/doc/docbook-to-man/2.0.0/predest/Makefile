OVERRIDE_DESTROOT = 1

all:
	# Structure
	mkdir -p $(dstroot)/usr/bin
	mkdir -p $(dstroot)/usr/share/sgml/transpec
	mkdir -p $(dstroot)/usr/share/man/man{1,5}
	# dest
	$(MAKE) install ROOT=$(dstroot)/usr
	# Install manpages
	cp $(srcroot)/Doc/*.1 $(dstroot)/usr/share/man/man1/
	if [ -f "$(dstroot)/usr/share/man/man1/transpec.1" ]; then mv $(dstroot)/usr/share/man/man1/transpec.1 $(dstroot)/usr/share/man/man5/transpec.5
	if [ -f "$(srcroot)/Doc/transpec.5" ]; then cp $(srcroot)/Doc/transpec.5 $(dstroot)/usr/share/man/man5/transpec.5
