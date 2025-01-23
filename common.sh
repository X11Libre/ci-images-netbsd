set -e

. ./conf.sh

die() {
    echo "$*" >&2
    exit 1
}

[ "$VM_OS_ARCH" ] || die "missing variable VM_OS_ARCH"

case "$VM_OS_ARCH" in
    amd64)
        export VM_QEMU_ARCH=x86_64
    ;;
    i386)
        export VM_QEMU_ARCH=i386
    ;;
    *)
        export VM_QEMU_ARCH="$VM_OS_ARCH"
    ;;
esac
