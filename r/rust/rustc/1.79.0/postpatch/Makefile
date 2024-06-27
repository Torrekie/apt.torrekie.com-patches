SDKROOT ?= /
APPLE_LLVM_DIR ?= /usr/lib/llvm-16

all:
	# For later use
	mkdir -p $(srcroot)/altbin

	# This will have to use patched rustc with a
        # aarch64-apple-ios target set, if not,
	# then this build is a middle stage which for
	# building the final stage.
	gsed -i -e "s|@CARGO@|$(shell which cargo)|g" \
		-e "s|@RUSTC@|$(shell which rustc)|g" \
		-e "s|@RUSTFMT@|$(shell which rustfmt)|g" \
		-e "s|@DSTROOT@|$(dstroot)|g" \
		-e "s|@RUST_BUILD_TRIPLE@|$(shell rustc -Vv | grep 'host:' | gawk -F': ' '/host:/ {print $$2}')|g" \
		-e "s|@RUST_TARGET_TRIPLE@|aarch64-apple-ios|g" \
		-e "s|@FAKE_LLVM_CONFIG@|$(srcroot)/altbin/llvm-config|g" \
		$(srcroot)/config.toml
# When I wrote this, I was using a self-implemented script to mimic xcrun's logic
# But not provided here because it still not as completed as how I expected
# Rust was only using it to return sdkroot, so a simple stub is ok I guess
ifeq (, $(shell which xcrun))
	echo "#!/bin/sh"		> $(srcroot)/altbin/xcrun
	echo "exec echo $(SDKROOT)"	>> $(srcroot)/altbin/xcrun
endif
	# After patching, we added a macro USE_APPLE_LLVM to specify
	# we are using Apple's LLVM fork, to ensure the default behavior,
	# we add CFLAGS directly to a compiler wrapper instead of setting
	# bunch of envvars.
	echo "#!/bin/sh"		> $(srcroot)/altbin/cc
	# Don't forget this, do something like -L$(LLVM_DSTROOT)/usr/lib/llvm-16/lib
	echo 'exec "$(CC)" "-L$(APPLE_LLVM_DIR)/lib" "-DUSE_APPLE_LLVM" "$$@"' >> $(srcroot)/altbin/cc

	echo "#!/bin/sh"		> $(srcroot)/altbin/c++
	echo 'exec "$(CXX)" "-L$(APPLE_LLVM_DIR)/lib" "-DUSE_APPLE_LLVM" "$$@"' >> $(srcroot)/altbin/c++

	# chmod all custom tools
	# After that we should make sure PATH=$(srcroot)/altbin/:$PATH
	mv $(srcroot)/ios-llvm-config $(srcroot)/altbin/llvm-config
	chmod +x $(srcroot)/altbin/*
