DBUS_SYSTEM_PLIST = $(dstroot)/Library/LaunchDaemons/org.freedesktop.dbus-system.plist

all:
	# We no longer provide dbus-tests, but dbus still built this tool
	rm -f $(dstroot)/usr/bin/dbus-test-tool
	rm -f $(dstroot)/usr/share/man/man1/dbus-test-tool.1

	# We no longer provide dbus-1-doc, but dbus still installing a bit of documentation
	rm -fr $(dstroot)/usr/share/doc/dbus

	# Debian
	# Remove the legacy bus configuration files. We move their old
	# versions out of the way, include the moved names in the new
	# bus setup instead of the old names, and replace the old names
	# with a symlink to the new bus setup so that old dbus-daemons
	# can still reload their configuration.
	rm -f $(dstroot)/etc/dbus-1/{session,system}.conf

	# D-Bus socket dir, even we don't use it
	mkdir -p $(dstroot)/var/run/dbus
	rm -fr $(dstroot)/run

	# Compat symlinks
	ln -s ../../libexec/dbus-1.0/dbus-daemon-launch-helper $(dstroot)/usr/lib/dbus-1.0/

	# Create system bus daemon
	mkdir -p $(dstroot)/Library/LaunchDaemons/
	/usr/libexec/PlistBuddy -c "Save" $(DBUS_SYSTEM_PLIST)
	for entry in ":Label string org.freedesktop.dbus-system" \
	             ":ProgramArguments array" \
	             ":ProgramArguments:0 string /usr/bin/dbus-daemon" \
	             ":ProgramArguments:1 string --system" \
	             ":ProgramArguments:2 string --nofork" \
	             ":HardResourceLimits dict" \
	             ":HardResourceLimits:MemoryLock integer 67092480" \
	             ":HardResourceLimits:NumberOfProcesses integer 2000" \
	             ":HardResourceLimits:NumberOfFiles integer 10240" \
	             ":POSIXSpawnType string Interactive" \
	             ":KeepAlive bool true"; do \
	    /usr/libexec/PlistBuddy -c "Add $${entry}" $(DBUS_SYSTEM_PLIST); \
	done
