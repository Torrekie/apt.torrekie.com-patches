# debian/rules
ProjectVersion := $(shell cat $(srcroot)/VERSION)

# DEB_HOOGLE_TXT_DIR := /usr/lib/ghc-doc/hoogle/

all:
	# Remove the conf.copy files, they really should not be in the installed package.
	find $(dstroot) -name \*.conf.copy -delete

	# Move the package.conf files
	# GHC installs package configuration files under '/usr/lib/ghc/lib/package.conf.d'
	# but in Debian we move these files under 'var/lib/ghc/package.conf.d'.
	mkdir -p $(dstroot)/var/lib/ghc
	mv $(dstroot)/usr/lib/ghc/lib/package.conf.d $(dstroot)/var/lib/ghc/
	rm -f $(dstroot)/var/lib/ghc/package.conf.d/package.cache*
	rm -f $(dstroot)/var/lib/ghc/package.conf.d/.stamp
	ln -s /var/lib/ghc/package.conf.d $(dstroot)/usr/lib/ghc/lib/package.conf.d

	# Modify the ghc-doc path in package.conf files
	gsed -ri 's,share/doc/ghc/html/libraries/(.*)\.haddock,lib/ghc-doc/haddock/ghc/\1.haddock,' $(dstroot)/var/lib/ghc/package.conf.d/*.conf

	# Replace ${pkgroot} in the package.conf files.
	# The "pkgroot" is the directory containing the package database,
	# which for us should be '/usr/lib/ghc/lib/'.
	# The reason we change it here is because we are moving the package.conf
	# files under '/var/lib/ghc/package.conf.d'.
	gsed -ri 's,\$$\{pkgroot\},/usr/lib/ghc/lib,' $(dstroot)/var/lib/ghc/package.conf.d/*.conf

	# Torrekie: It is tooooo complicated to rebuild everything
	# Before we update to next version, a symlink of osx -> darwin is still
	# required because of incompleted Cabal
	gsed -i 's,aarch64-osx-ghc,aarch64-darwin-ghc,g' \
		$(dstroot)/var/lib/ghc/package.conf.d/*.conf \
		$(dstroot)/usr/share/doc/ghc/html/libraries/Cabal-*/src/Paths_Cabal.html

	mv $(dstroot)/usr/share/doc/aarch64-{osx,darwin}-ghc-$(ProjectVersion)
	ln -s aarch64-darwin-ghc-$(ProjectVersion) $(dstroot)/usr/lib/ghc/lib/aarch64-osx-ghc-$(ProjectVersion)

	# manpages
	echo ".so man1/ghc.1" > $(dstroot)/usr/share/man/man1/ghc-$(ProjectVersion).1
	if test -e $(dstroot)/usr/bin/ghci-$(ProjectVersion); then \
		echo ".so man1/ghc.1" > $(dstroot)/usr/share/man/man1/ghci.1 ;\
		echo ".so man1/ghc.1" > $(dstroot)/usr/share/man/man1/ghci-$(ProjectVersion).1 ;\
		cp $(srcroot)/runghc.man $(dstroot)/usr/share/man/man1/runghc.1; fi
	cp $(srcroot)/utils/hp2ps/hp2ps.1 $(dstroot)/usr/share/man/man1/hp2ps.1
	cp $(srcroot)/ghc-pkg.man $(dstroot)/usr/share/man/man1/ghc-pkg.1
	echo ".so man1/ghc-pkg.1" > $(dstroot)/usr/share/man/man1/ghc-pkg-$(ProjectVersion).1
	cp $(srcroot)/haddock.man $(dstroot)/usr/share/man/man1/haddock.1

	# Delete all the library LICENSE files
	rm -f $(dstroot)/usr/share/doc/ghc/html/libraries/*/LICENSE

	# Move gen_contents_index binary
	# We use our own binary because upstream expects to be run from
	# a different directory.
	mkdir -p $(dstroot)/usr/lib/ghc-doc
	rm -f $(dstroot)/usr/share/doc/ghc/html/libraries/gen_contents_index
	cp $(srcroot)/gen_contents_index.pl $(dstroot)/usr/lib/ghc-doc/gen_contents_index
	chmod +x $(dstroot)/usr/lib/ghc-doc/gen_contents_index

	# Delete 'doc-index.html' and 'index.html' files. These are generated at
	# installation time using 'gen_contents_index'.
	rm -f $(dstroot)/usr/share/doc/ghc/html/libraries/doc-index*.html \
	    $(dstroot)/usr/share/doc/ghc/html/libraries/index.html \
	    $(dstroot)/usr/share/doc/ghc/html/libraries/frames.html \
	    $(dstroot)/usr/share/doc/ghc/html/libraries/index-frames.html \
	    $(dstroot)/usr/share/doc/ghc/html/libraries/haddock-util.js \
	    $(dstroot)/usr/share/doc/ghc/html/libraries/hslogo-16.png \
	    $(dstroot)/usr/share/doc/ghc/html/libraries/minus.gif \
	    $(dstroot)/usr/share/doc/ghc/html/libraries/plus.gif \
	    $(dstroot)/usr/share/doc/ghc/html/libraries/ocean.css \
	    $(dstroot)/usr/share/doc/ghc/html/libraries/haddock-bundle.min.js \
	    $(dstroot)/usr/share/doc/ghc/html/libraries/quick-jump.css \
	    $(dstroot)/usr/share/doc/ghc/html/libraries/linuwial.css \
	    $(dstroot)/usr/share/doc/ghc/html/libraries/synopsis.png

	# Move haddock files to the correct folder
	# (Create folders if they don't exist, i.e., if we are building '-arch')
	mkdir -p $(dstroot)/usr/lib/ghc-doc/haddock/ghc/
	mkdir -p $(dstroot)/usr/share/doc/ghc/html/libraries/
	for f in `find $(dstroot)/usr/share/doc/ghc/html/libraries/ -maxdepth 1 -mindepth 1 -type d`; do \
		mkdir $(dstroot)/usr/lib/ghc-doc/haddock/ghc/`basename $$f` ; \
		mv $$f/*.haddock $(dstroot)/usr/lib/ghc-doc/haddock/ghc/`basename $$f` ; done
	cd $(dstroot)/usr/share/doc/ghc/html/libraries/; ln -s ghc-$(ProjectVersion)-inplace ghc

	install -Dm 644 $(srcroot)/index.html $(dstroot)/usr/share/doc/ghc/index.html

	# Create Hoogle directory
	# mkdir -p $(dstroot)/$(DEB_HOOGLE_TXT_DIR)

	# ghc-doc
	# Torrekie: What was those, I didn't understand why
	# find $(dstroot)/usr/share/doc/ghc/html/libraries/*/ -name "*.txt" \
	#	-printf "%p $(DEB_HOOGLE_TXT_DIR)/%f\n" >> debian/ghc-doc.links
