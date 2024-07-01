usage() {

    exit 1
}

# Parse command-line arguments
parse_args() {
    for arg in "$@"; do
        case $arg in
        --volname=* | -v=*)
            volname="${arg#*=}"
            ;;
        --delete | -d)
            flag_delete=true
            ;;
        --help | -h)
            usage
            exit 1
            ;;
        esac
    done
}

volname="enctmp"

# Parse command-line arguments
parse_args "$@"

ENCTMP=$(mount | grep "$volname" | awk '{print $1}')

dmgname=$(hdiutil info | grep -B 0 "$volname" | grep "image-path" | awk -F': ' '{print $2}')

hdiutil detach $ENCTMP

if [ "$flag_delete" = true ]; then
    rm $dmgname
fi
