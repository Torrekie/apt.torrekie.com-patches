all:
	mv $(dstroot)/usr/share/groff/site-tmac $(dstroot)/etc/groff

	# Debian additions
	echo $(postdest)/mandoc.local >> $(dstroot)/etc/groff/man.local
	echo $(postdest)/mandoc.local >> $(dstroot)/etc/groff/mdoc.local

	chmod +x $(dstroot)/usr/share/font/devps/generate/{afmname,symbol.sed}
	chmod +x $(dstroot)/usr/share/font/devdvi/generate/CompileFonts $(dstroot)/usr/share/font/devlj4/generate/special.awk

	# Debian Policy 10.4 specifies the #! line for Perl scripts
	ggrep -rlZ '#! */usr/bin/env perl' $(dstroot) | \
		xargs -0r gsed -i 's,\(#! *\)/usr/bin/env perl,\1/usr/bin/perl,'

	# links
	ln -s $(dstroot)/etc/groff $(dstroot)/usr/share/groff/site-tmac
	ln -s $(dstroot)/usr/bin/eqn $(dstroot)/usr/bin/geqn
	ln -s $(dstroot)/usr/bin/pic $(dstroot)/usr/bin/gpic
	ln -s $(dstroot)/usr/bin/tbl $(dstroot)/usr/bin/gtbl
	ln -s $(dstroot)/usr/share/man/man1/eqn.1 $(dstroot)/usr/share/man/man1/geqn.1
	ln -s $(dstroot)/usr/share/man/man1/pic.1 $(dstroot)/usr/share/man/man1/gpic.1
	ln -s $(dstroot)/usr/share/man/man1/tbl.1 $(dstroot)/usr/share/man/man1/gtbl.1
	ln -s $(dstroot)/usr/share/man/man1/grohtml.1 $(dstroot)/usr/share/man/man1/post-grohtml.1
	ln -s $(dstroot)/usr/share/man/man1/grohtml.1 $(dstroot)/usr/share/man/man1/pre-grohtml.1

	# mime
	mkdir -p $(dstroot)/usr/lib/mime/packages/
	echo "application/x-troff-man; /usr/bin/nroff -mandoc -Tutf8; copiousoutput; print=/usr/bin/nroff -mandoc -Tutf8 | print text/plain:-" >> $(dstroot)/usr/lib/mime/packages/groff-base
	echo "text/troff; /usr/bin/nroff -mandoc -Tutf8; copiousoutput; print=/usr/bin/nroff -mandoc -Tutf8 | print text/plain:-" >> $(dstroot)/usr/lib/mime/packages/groff-base
