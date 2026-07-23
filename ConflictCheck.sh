#!/bin/bash

LOCAL_GIT='./'
SBO_REPO='/usr/sbo/repo'
RED='\033[0;31m'
NC='\033[0m' # No Color
MISMATCH=0

# set the name of the program we are building
# and remove the trailing slash
PRGNAM=${1%/}

# Check the MD5 of SBo repo vs. Local Repo
echo
SBO=$(sudo sbofind -te $1 | grep SBo)
SBO_PATH=$(sudo sbofind -te $1 | grep Path | awk '{print $NF}')
echo "$SBO"
LOCAL_VER=$(cat libvhdi/libvhdi.info | grep VERSION | awk -F'"' '{print $2}')
echo -e "GIT:\t$1 $LOCAL_VER"
echo
echo "Download URL:"
sudo sbofind -tei $1 | grep DOWNLOAD= | awk -F '"' '{print $2}'
echo
echo "Home Page:"
sudo sbofind -tei $1 | grep HOMEPAGE= | awk -F '"' '{print $2}'
echo


# TEST the MD5sums:
if [[ $(md5sum $1/README | awk '{print $1}') == $(md5sum $SBO_PATH/README | awk '{print $1}') ]]
then
    echo "README matches"
else
    printf "${RED}README MIS-MATCH${NC}\n"
    MISMATCH=1
fi

if [[ $(md5sum $1/$1.SlackBuild | awk '{print $1}') == $(md5sum $SBO_PATH/$1.SlackBuild | awk '{print $1}') ]] 
then
    echo "$1.SlackBuild matches"
else
    printf "${RED}$1.SlackBuild MIS-MATCH${NC}\n"
    MISMATCH=1
fi

if [[ $(md5sum $1/$1.info | awk '{print $1}') == $(md5sum $SBO_PATH/$1.info | awk '{print $1}') ]]
then
    echo "$1.info matches"
else
    printf "${RED}$1.info MIS-MATCH${NC}\n"
    MISMATCH=1
fi

if [[ $(md5sum $1/slack-desc | awk '{print $1}') == $(md5sum $SBO_PATH/slack-desc | awk '{print $1}') ]]
then
    echo "slack-desc matches"
else
    printf "${RED}slack-desc MIS-MATCH${NC}\n"
    MISMATCH=1
fi

echo

if [[ $MISMATCH == 1 ]]
then
    printf "${RED}Mismatch${NC}: "
else
    echo "No mismatch."
    exit 0
fi

# If there is a mis-match, allow copying from SBo repo:

while true; do
    # -p allows specifying a prompt
    read -p "Do you want to copy from SBo repo? (y/n): " yn
    case $yn in
        # Case-insensitive match for 'y' or 'yes'
        [Yy]* ) echo "Proceeding..."
        cp  $SBO_PATH/* $1/.
        echo "Copy Complete";
        break
        ;;

        # Case-insensitive match for 'n' or 'no'
        [Nn]* ) echo "Exiting..." 
        exit
        ;;
        # Default case for invalid input, asks again
        * ) echo "Invalid response. Please answer yes or no."
        ;;
    esac
done


