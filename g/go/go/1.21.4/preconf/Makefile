all:
	# If we don't do that, we will require to download llvm and make lots of patches
	# Which just for this object file, not worth it
	# Even I don't want to include binary files to git
	cp $(preconf)/race_ios_arm64.syso $(srcroot}/src/runtime/race/

	# Go doesn't seems understand how this world deal with cross compilers
	# So when we are cross compiling from macOS to iOS, set "clang" as host CC/LD
	# As we always have clang xcrun shim. Then set target CC to "cc" which actually
	# pointing to $(srcroot}/shimbin/cc, which let Go hardcode its CC to "cc" so we
	# are able to use it normally on target device without "aarch64-apple-darwin" prefix
	mkdir -p $(srcroot}/shimbin
	printf "#!/bin/sh\nexec \"$(CC)\" \"$*\"" > $(srcroot}/shimbin/cc
	printf "#!/bin/sh\nexec \"$(CXX)\" \"$*\"" > $(srcroot}/shimbin/c++
	printf "#!/bin/sh\nexec \"$(LD)\" \"$*\"" > $(srcroot}/shimbin/ld
	chmod +x $(srcroot}/shimbin/*
