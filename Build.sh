#!/bin/bash

# exit when any command fails
set -e

# set the name of the program we are building
# and remove the trailing slash
PRGNAM=${1%/}


echo "sbolint: "
# for a git repo, sbolint requires the SlackBuild to be 0644:
chmod 0644 $PRGNAM/$PRGNAM.SlackBuild
sbolint $PRGNAM

cd $PRGNAM

# set the download url, tarball name, and correct MD5
DLURL=$(grep "DOWNLOAD=" $PRGNAM.info | awk -F \" '{print $2}')
PKGNAM=$(basename $DLURL)
INFOMD5=$(grep "MD5SUM=" $PRGNAM.info | awk -F \" '{print $2}')

# display requires line and continue
#REQ=$(grep "REQUIRES=" $PRGNAM.info | awk -F \" '{print $2}')
#if ! [[ -n $REQ ]]
#    echo -n "This package requires $REQ"
#    echo ""
#
#
#else
#    echo "No additional requirements, continuing..."
#

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

# for sbolint, the SlackBuild must be 0755:
chmod 0755 $PRGNAM.SlackBuild

# build the package without networking
echo "Building with unshared namespace (unshare -n)..."
sudo unshare -n sh $PRGNAM.SlackBuild

# cleanup
echo "Build script complete.  Removing source tarball..."
rm -f $PKGNAM
echo "Done"


# Run sbolint/sbopkglint on the upgraded SB.
# Change to parent dir:

cd ..
echo "sbopkglint: "
sbopkglint /tmp/$PRGNAM*
echo
echo "Packaging: "
tar czvf "$PRGNAM.tar.gz" "$PRGNAM/"
echo
echo "Linting the SBo tarball:"
sbolint $PRGNAM.tar.gz
echo
echo "sbolint: "
# for a git repo, sbolint requires the SlackBuild to be 0644:
chmod 0644 $PRGNAM/$PRGNAM.SlackBuild
sbolint $PRGNAM
echo
