#!/bin/bash -e

if [ $# != 2 ]; then
    echo "usage:"
    echo "./$0 <EULA file path> <target directry path>"
    exit 1
fi

echo "start build!"

EULApath=$1
targetpath=$2

if [ ! -e $EULApath -o ! -e $targetpath ]; then
    echo "$EULApath or $targetpath is not exist!"
    exit 1
fi

if [ ! -e ./input ]; then
    echo "create input directry"
    mkdir ./input
fi

if [ ! -e ./temp ]; then
    echo "create temp directry"
    mkdir ./temp
fi

if [ ! -e ./output ]; then
    echo "create output directry"
    mkdir ./output
fi

cp -rf $EULApath ./temp/EULA
cp -rf $targetpath ./temp/target
projname=`basename $targetpath`
sync

setupshlines=`wc -l ./setup.sh | awk '{print $1}'`
echo "setup shell line is $setupshlines"
cd ./temp/
tar -cvzf ./EULA.tgz ./EULA > /dev/null
EULAsizes=`stat -c %s ./EULA.tgz | tr -d '\n'`
echo "EULA.tgz size is $EULAsizes"
tar -cvzf ./target.tgz ./target > /dev/null
targetsizes=`stat -c %s ./target.tgz | tr -d '\n'`
echo "target.tgz size is $targetsizes"
cat ./EULA.tgz ./target.tgz > ./EULAtarget
sync
cd - > /dev/null

sed -i "s/projname=.*/projname=$projname/g" ./setup.sh && sync
sed -i "s/setupshlines=.*/setupshlines=$setupshlines/g" ./setup.sh && sync
sed -i "s/EULAsizes=.*/EULAsizes=$EULAsizes/g" ./setup.sh && sync
sed -i "s/targetsizes=.*/targetsizes=$targetsizes/g" ./setup.sh && sync

cat ./setup.sh ./temp/EULAtarget > ./output/setup.bin
sync

chmod +x ./output/setup.bin

rm -rf ./temp

echo "end build!"

