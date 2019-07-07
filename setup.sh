#!/bin/bash -e

projname=examplePROJ
setupshlines=122
EULAsizes=12335
targetsizes=60071

if [ $# == 1 ]; then
    insdir=$1
    mkdir -p $insdir
else
    insdir=`pwd`
fi

_dd()
{
    blocks=`expr $3 / 1024`
    bytes=`expr $3 % 1024`
    dd if="$1" ibs=$2 skip=1 obs=1024 conv=sync 2> /dev/null | \
    { test $blocks -gt 0 && dd ibs=1024 obs=1024 count=$blocks ; \
      test $bytes  -gt 0 && dd ibs=1 obs=1024 count=$bytes ; } 2> /dev/null
}

_error()
{
    echo "ERROR: $1" 1>&2
}

_unpack()
{
    cd $insdir
    tar $1vzf - 2>&1 || { _error "Extraction failed." ; kill -15 $$; }
    cd -
}

_progress()
{
    while read a; do
		echo -n .
    done
}

targetdir=$insdir/$projname

trap 'echo Signal caught, cleaning up >&2; /bin/rm -rf $insdir/EULA; /bin/rm -rf $targetdir; exit 15' 1 2 3 15

while true; do
    case "$1" in
        --auto-accept)
        noask=1
        shift
        ;;
        --force)
        force=1
        shift
        ;;
        *)
        break
        ;;
    esac
done

echo Welcome to $projname
echo

if [ -e "$targetdir" ] && [ -z "$force" ]; then
    _error "Target directory '$targetdir' already exists. Exiting..."
    exit 1
fi

if [ -z "$noask" ]; then
    echo You need to read and accept the EULA before continue..
    echo

    sleep 2

    echo -n "Unpacking EULA file "
    offset=`head -n $setupshlines "$0" | wc -c | tr -d " "`
    if _dd "$0" $offset $EULAsizes | _unpack x | _progress; then
        echo
        cat $insdir/EULA | more -d
        echo -n "Do you accept the EULA you just read? (y/N) "
        read REPLY
        if [ "$REPLY" != "y" ] && [ "$REPLY" != "Y" ]; then
            echo "EULA has not been accepted. Exiting..."
            exit 1
        fi
        offset=`expr $offset + $EULAsizes`
        rm -rf $insdir/EULA
        sync
        echo "EULA has been accepted. The files will be unpacked at '$targetdir'"
        echo
    else
        _error "Package is corrupted. Exiting..."
    fi
else
    echo "WARNING: EULA has been auto-accepted; this imply you agree with it anyway."
fi

echo -n "Unpacking target file "
for s in $targetsizes; do
    if _dd "$0" $offset $s | _unpack x | _progress; then
        echo " done"
    else
        _error "Package is corrupted. Exiting..."
    fi
    offset=`expr $offset + $s`
done

mv $insdir/target $targetdir

if [ -e $targetdir/xsetup.sh ]; then
    cd $targetdir
    chmod +x xsetup.sh
    sudo ./xsetup.sh
    cd ..
    rm -rf $targetdir
    sync
fi

exit 0

