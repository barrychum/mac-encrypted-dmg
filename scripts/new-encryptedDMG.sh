usage() {

    exit 1
}

# Parse command-line arguments
parse_args() {
    for arg in "$@"; do
        case $arg in
        --size=* | -s=*)
            size="${arg#*=}"
            ;;
        --volname=* | -v=*)
            volname="${arg#*=}"
            ;;
        --dmgname=* | -d=*)
            dmgname="${arg#*=}"
            ;;
        --mountpoint=* | -m=*)
            mountpoint="${arg#*=}"
            ;;
        --help | -h)
            usage
            exit 1
            ;;
        *)
            printf "%s\n" "$arg is not a valid argument"
            exit 1
            ;;
        esac
    done
}

size="100" # Default key size
volname="enctmp"

# Parse command-line arguments
parse_args "$@"

if [ -z "$dngname" ]; then
    dmgname="$HOME/.${volname}.dmg"
fi
if [ -z "$mountpoint" ]; then
    mountpoint="$HOME/${volname}"
fi

derive-key.sh | hdiutil create -size "${size}m" -encryption AES-256 -fs APFS -volname "$volname" -stdinpass "$dmgname"

derive-key.sh | hdiutil attach -stdinpass "$dmgname" -mountpoint "$mountpoint" | grep "$mountpoint"
