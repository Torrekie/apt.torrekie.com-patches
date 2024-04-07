HostGhcVersion := $(shell ghc --version | awk -F"version " '{print $2}')
ProjectVersion := $(shell cat $(srcroot)/VERSION)

all:
	# Make sure LLVM target is *-ios
	sed -i 's/arm64-apple-darwin/arm64-apple-ios/g' $(srcroot)/hadrian/cfg/system.config $(srcroot)/mk/project.mk

	# For some reason, I changed "osx" to "darwin" to avoid misleading
	# But sometimes the system cabal-install may not synced with this patch
	mkdir -p $(srcroot)/_build/stage0/lib/aarch64-darwin-ghc-$(HostGhcVersion)
	rm -r $(srcroot)/_build/stage0/lib/aarch64-osx-ghc-$(HostGhcVersion)
	ln -s aarch64-darwin-ghc-$(HostGhcVersion) $(srcroot)/_build/stage0/lib/aarch64-osx-ghc-$(HostGhcVersion)
	# stage1 is current project ver
	mkdir -p $(srcroot)/_build/stage1/lib/aarch64-darwin-ghc-$(ProjectVersion)
	rm -r $(srcroot)/_build/stage1/lib/aarch64-osx-ghc-$(ProjectVersion)
	ln -s aarch64-darwin-ghc-$(ProjectVersion) $(srcroot)/_build/stage1/lib/aarch64-osx-ghc-$(ProjectVersion)	
