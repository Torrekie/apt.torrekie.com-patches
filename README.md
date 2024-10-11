Patches for packages released by Torrekie's repo

** Missing patches for your desired package? Create an [issue](issues/new) to remind me! **

Cydia Repository (Upcomming): https://apt.torrekie.com/Comdartiwerk

Some packaging policies(preferences):

 - Installation prefix is normally `/usr`, respectively
    - libdir: $prefix/lib
    - datarootdir: $prefix/share
    - mandir: $datarootdir/man
    - etc.

 - But while multiple versions of one package has to be released, or conflicting with some system provided files
    - prefix: /usr/libexec/${PACKNAME}${PACKVER}
       - e.g. latest autoconf installs under `/usr`, but autoconf@2.69 installs to `/usr/libexec/autoconf2.69`
       - meanwhile, creating symlinks for files with version suffix like `/usr/libexec/autoconf2.69/bin/autoconf -> /usr/bin/autoconf2.69`

 - As Darwin should be a Darwin or a BSD distro, some Debian packaging rules are not capable
    - Common programs may both created by BSD and GNU
       - In that case, we normally add a prefix `g` to GNU's one and create symlinks without `g` under `/usr/libexec/${PACKNAME}${PACKVER}/gnu{bin,man}`
       - But, I'm trying to make the environment behaves like how macOS does, that means some GNU programs may be as the 1st choice
          - e.g. `tar` provided by `libarchive` has been renamed to `bsdtar` and GNU Tar keeps `tar`
    - We have to deal with a fat binary format
       - Mach-O supports multiple architectures, which was not something ELF can do
          - While distros using ELF as executable file format, they implements multiarch support by separating arch library path
             - `lib32` and `lib64` sounds weird for Darwin users, isn't it?
       - No target triple(t) should exist in libdir except you are creating a cross toolchain
          - Debian is doing library packaging by something like `$(DEB_HOST_MULTIARCH)`, but Darwin users don't have to
    - Try to make library linkage absolute
       - ELF has some mechanism like `soversion` and `soname`, similar things can be found in Mach-O, but they do have some difference
          - `soname` only records the name of the library, but `install_name` contains the location of the library
             - When an ELF executable has been loaded, loader will find all `rpath` and use the first matching library, if we have rpaths like `/usr/lib` and `/opt/lib`, the loaded library could be under one of them
             - But Mach-O will try to load an absolute path if possible, e.g. while install name equals `/opt/homebrew/lib/libsomething.dylib`, `dyld` would complain if no corresponding library found under this location, even this lib appears under other rpaths
          - `soversion` and ELF symver plays a perfect role on version diverting, but we don't have `.symver` for Mach-O
             - `dyld` cannot identify symbol version because theres no such thing, as alternative, some build progress may add version numbers to their symbols
             - For Mach-O we have `compatibility_version` and `current_version` to help dyld to identify a range of supported library version, but the problem is, same `install_name` may not referring to same version. If we link to `@rpath/libsomething.8.dylib`, we may load to a lib with an incompatible version, regarding to a SIGABRT
    - Currently we don't provide apt-src packages
       - Oh, Cydia...
       - Can anyone help me to reborn those saurik pieces?
       - I didn't see other pkgmans providing this feature though
    - Try to follow macOS hierarchy if possible
       - Some libraries can be built as framework and that was how macOS does (e.g. liblldb -> LLDB.framework)
       - Language extensions may installed under a specific location following macOS scheme (e.g. `/System/Library/Tcl`)
       - Only back to Debian-like scheme when something works terrible (Python huh)

 - Packages containing launch daemons are set to onload by default

 - Try not use `dpkg-divert`
    - We need a better version divertion control, I would prefer how MacPorts and Xcode CLT does
       - MacPorts implemented a `port select` way to let user choose preferred packver
       - macOS created lots of "xcrun shim" executables under `/usr/bin`
          - `/usr/bin/cc` is a 'shim executable' that actually calling libxcselect/libxcrun to run the real `cc` with arguments, it searches across multiple Xcode/CLT paths installed. I would like to implement similar/same thing on iOS

 - Always do static linking for essential packages (and somepackages)
    - For some common-used packages, we would better not to do dynamic links for them, i.e. bash should link against static readline/gettext/ncurses
       - As the reason we talked above, readline do `compatibility_version` updates, that would cause program linked with `8.0.1` cannot be ran with `8.0.0`, while readline and bash was suffering from upgrades together, bash may upgrades earlier, causing everything depending bash become broken (my previous users were gone cause of this)
    - For somepackages (ehw...), we may better to do static links because of a high-frequency updating like GLib
       - GLib and various projects include library version in their symbols to emulate `.symver` on Darwin, but this would break compatibility
          - Remove versions from symbols if possible (Apple defines `-DU_DISABLE_RENAMING=1` to prevent ICU inserting symbol versions)
          - For libraries that did not provide such option, try to make a **shim library** for them, or just static link to other rdeps

 - Use system provided libraries if possible
    - We don't always need alternative libraries for some packages, try to use the system one if capable
    - We don't need to build another libxml2 for `xsltproc` as libxml2/libxslt presents in dsc

