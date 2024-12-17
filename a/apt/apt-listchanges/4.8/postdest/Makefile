apt_listchanges_PLIST := $(dstroot)/Library/LaunchDaemons/apt-listchanges.plist

all:
	# Create daemon
	mkdir -p $(dstroot)/Library/LaunchDaemons/
	/usr/libexec/PlistBuddy -c "Save" $(apt_listchanges_PLIST)
	for entry in ":Label string apt-listchanges" \
	             ":ProgramArguments array" \
	             ":ProgramArguments:0 string /usr/bin/python3" \
	             ":ProgramArguments:1 string -m" \
	             ":ProgramArguments:2 string apt_listchanges.populate_database" \
	             ":ProgramArguments:3 string --profile" \
	             ":ProgramArguments:4 string apt" \
	             ":StartInterval integer 3600" \
	             ":HardResourceLimits dict" \
	             ":HardResourceLimits:MemoryLock integer 67092480" \
	             ":HardResourceLimits:NumberOfProcesses integer 2000" \
	             ":HardResourceLimits:NumberOfFiles integer 10240" \
	             ":POSIXSpawnType string Interactive" \
	             ":KeepAlive bool true"; do \
	    /usr/libexec/PlistBuddy -c "Add $${entry}" $(apt_listchanges_PLIST); \
	done

