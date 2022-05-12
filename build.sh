#!/bin/bash

# exit when any command fails
set -e

# set the name of the program
PRGNAM=$1
cd $PRGNAM

# set the download url, tarball name, and correct MD5
DLURL=$(grep "DOWNLOAD=" $PRGNAM.info | awk -F \" '{print $2}')
PKGNAM=$(basename $DLURL)
INFOMD5=$(grep "MD5SUM=" $PRGNAM.info | awk -F \" '{print $2}')

# download the package and check the hash
wget $DLURL
PKGMD5=$(md5sum $PKGNAM | awk '{print $1}')
echo "info md5 is   : $INFOMD5"
echo "package md5 is: $PKGMD5"
if [[ $INFOMD5 != $PKGMD5 ]]
then
    echo "MD5 MISMATCH! EXITING"
    exit 1
else
    echo "md5sums match..."
    echo
fi

# build the package without networking
echo "Building with unshared namespace (unshare -n)..."
sudo unshare -n sh $PRGNAM.SlackBuild

# cleanup
echo "Build script complete.  Removing source tarball..."
rm -f $PKGNAM
echo "Done"





