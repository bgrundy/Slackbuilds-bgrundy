#!/bin/bash

# exit when any command fails
set -e

# set the name of the program we are hashing
# and remove the trailing slash
PRGNAM=${1%/}

cd $PRGNAM

# set the download url, tarball name, and correct MD5
DLURL=$(grep "DOWNLOAD=" $PRGNAM.info | awk -F \" '{print $2}')
PKGNAM=$(basename $DLURL)

# download the package and check the hash
wget $DLURL
PKGMD5=$(md5sum $PKGNAM | awk '{print $1}')
echo "package md5 is: $PKGMD5"
