#!/usr/bin/env bash

PACKNAME=""
PACKVER=""

if [[ ! $1 ]] || [[ ! $2 ]]; then
  echo "Usage: <Name> <Version> [Epoch] [Revision]"
  exit 1
else
  PACKNAME="$1"
  PACKVER="$2"
fi

PACKEPOC=""
PACKREV=""

if [[ $3 ]]; then
  if [[ $3 != "-" ]]; then
    PACKEPOC="$3"
  fi
fi

if [[ $4 ]]; then
  if [[ $4 != "-" ]]; then
    PACKREV="$4"
  fi
fi

APTVER="${PACKVER}"
if [[ ${PACKEPOC} != "" ]]; then
  APTVER="${PACKEPOC}:${PACKVER}"
fi
if [[ ${PACKREV} != "" ]]; then
  APTVER="${APTVER}-${PACKREV}"
fi
echo "Adding ${PACKNAME} ${APTVER}"

INDEXES=()
case "${PACKNAME}" in
  "a"*)
    INDEXES=("ansible" "apt" "apache" "ascii" "auto" "aws")
    ;;
  "b"*)
    INDEXES=("bash" "berkeley" "boost" "bin")
    ;;
  "c"*)
    INDEXES=("cargo" "closure" "cloud" "clutter" "cmake" "cpp")
    ;;
  "d"*)
    INDEXES=("daemon" "docker" "doc" "dvd")
    ;;
  "e"*)
    INDEXES=("emacs" "emoji" "erlang" "exif" "expat" "ext")
    ;;
  "f"*)
    INDEXES=("fabric" "fast" "ffmpeg" "find" "flac" "flow" "font" "forge" "free" "fs")
    ;;
  "g"*)
    INDEXES=("git" "glib" "gnu" "golang" "go" "gradle" "gst" "gtk")
    ;;
  "h"*)
    INDEXES=("hash" "hdf" "high" "html" "http" "hyper")
    ;;
  "i"*)
    INDEXES=("i386" "i586" "i686" "icon" "image" "imap" "inet" "intl" "io" "ip")
    ;;
  "j"*)
    INDEXES=("jpeg" "json" "js" "jvm")
    ;;
  "k"*)
    INDEXES=("kube")
    ;;
  "l"*)
    INDEXES=("latex" "launch"
             "liba" "libb" "libc" "libd" "libe" "libf"
             "libgcc" "libg"
             "libh" "libi" "libj" "libk" "libl" "libm" "libn" "libo" "libp" "libq"
             "libre" "libr"
             "libs" "libt" "libu" "libv" "libw"
             "libxfce" "libx"
             "liby" "libz"
             "license" "light" "link" "linux" "lite" "live" "local" "log" "lua" "lz")
    ;;
  "m"*)
    INDEXES=("macos" "mac" "magic" "mail" "make" "man" "map" "mariadb" "mark" "math" "md5" "mecab" "media" "mega" "micro" "midi" "mid" "mini" "min" "mix" "mk" "mongo" "mp3" "mp" "msg" "multi" "mysql")
    ;;
  "n"*)
    INDEXES=("nano" "neo" "net" "new" "node" "num")
    ;;
  "o"*)
    INDEXES=("oauth" "objc" "ocaml" "one" "open")
    ;;
  "p"*)
    INDEXES=("pack" "pam" "pass" "pdf" "perl" "pg" "php" "pi" "pkg" "png" "pod" "port" "post" "pre" "pro" "python2" "python3" "python" "py2" "py3" "py")
    ;;
  "q"*)
    INDEXES=("qt" "quick")
    ;;
  "r"*)
    INDEXES=("rbenv" "redis" "red" "regex" "reg" "re" "ruby" "rust")
    ;;
  "s"*)
    INDEXES=("scala" "schem" "sdl" "sha" "shell" "shm" "simple" "snap" "source" "space" "speed" "sql" "ssh" "ssl" "standard" "svg" "swift" "sys")
    ;;
  "t"*)
    INDEXES=("tag" "task" "tcp" "tel" "temp" "term" "text" "tex" "time" "tiny" "tmux" "tomcat" "ttf" "tty" "txt")
    ;;
  "u"*)
    INDEXES=("udp" "unix" "un" "usb" "utf" "util")
    ;;
  "v"*)
    INDEXES=("virt" "vulkan")
    ;;
  "w"*)
    INDEXES=("wasm" "watch" "way" "web" "word")
    ;;
  "x"*)
    INDEXES=("xcb" "xcode" "xml" "xorg" "xfce")
    ;;
  "y"*)
    INDEXES=("yaml" "yarn")
    ;;
  "z"*)
    INDEXES=("zsh")
    ;;
  *)
    ;;
esac

FINALDIR=""
for index in "${INDEXES[@]}"; do
  if [[ "${PACKNAME#"$index"}" != "${PACKNAME}" ]] || [[ "${PACKNAME}" == "${index}" ]]; then
    # e.g. apt-dater 1.0 => a/apt/apt-dater/1.0
    FINALDIR="${PACKNAME:0:1}/${index}/${PACKNAME}/${APTVER}"
    break
  elif [[ ${FINALDIR} == "" ]]; then
    # e.g. somepack 1.0 => s/somepack/1.0
    FINALDIR="${PACKNAME:0:1}/${PACKNAME}/${APTVER}"
  fi
done

echo "Creating ${FINALDIR}"

# preconf/postconf: Progress before/after configure
# predest/postdest: Progress before/after destroot
# prepatch/postpatch: Progress before/after patch
# maintscript: Debian Maintainer Scripts (This should be in source packages I believe)
mkdir -p "${FINALDIR}/"{pre,post}{conf,dest,patch}
mkdir -p "${FINALDIR}/maintscript"
