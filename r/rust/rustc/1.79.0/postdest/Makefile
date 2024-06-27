APPLE_LLVM_VERSION ?= 16
DEB_HOST_RUST_TYPE ?= aarch64-apple-ios

all:
	# Replace duplicated compile-time/run-time dylibs with symlinks
	for f in $(dstroot)/usr/lib/rustlib/$(DEB_HOST_RUST_TYPE)/lib/lib*.dylib; do \
	  name=$${f##*/}; \
	  if [ -f "$(DEB_DESTDIR)/usr/lib/$$name" ]; then \
	    ln -sf ../../../$$name $$f; \
	  fi; \
	done

	# Rust LLVM symlinks
	# Currently LLVM 16
	ln -s lld-$(APPLE_LLVM_VERSION) $(dstroot)/usr/bin/rust-lld
	ln -s clang-$(APPLE_LLVM_VERSION) $(dstroot)/usr/bin/rust-clang
	ln -s llvm-dwp-$(APPLE_LLVM_VERSION) $(dstroot)/usr/bin/rust-llvm-dwp
	# for -Z gcc-ld=lld, see compiler/rustc_codegen_ssa/src/back/link.rs for logic
	# This is for keeping Debian scheme, even we use CC as linker by default
	mkdir -p $(dstroot)/usr/lib/rustlib/$(DEB_HOST_RUST_TYPE)/bin/gcc-ld/ld
	ln -s ../../../../../bin/rust-lld $(dstroot)/usr/lib/rustlib/$(DEB_HOST_RUST_TYPE)/bin/gcc-ld/ld
	# Consider actually use ld64
	ln -s ../../../../../bin/rust-lld $(dstroot)/usr/lib/rustlib/$(DEB_HOST_RUST_TYPE)/bin/gcc-ld/ld64
	# For applications that use cargo-binutils, e.g. grcov
	ln -s ../../../../bin/llvm-profdata-$(APPLE_LLVM_VERSION) $(dstroot)/usr/lib/rustlib/$(DEB_HOST_RUST_TYPE)/bin/llvm-profdata
	ln -s ../../../../bin/llvm-cov-$(APPLE_LLVM_VERSION) $(dstroot)/usr/lib/rustlib/$(DEB_HOST_RUST_TYPE)/bin/llvm-cov
