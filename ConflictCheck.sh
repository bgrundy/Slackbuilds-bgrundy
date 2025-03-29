#!/bin/bash

LOCAL_GIT='./'
SBO_REPO='/usr/sbo/repo'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check the MD5 of SBo repo vs. Local Repo
echo
SBO=$(sudo sbofind -te $1 | awk -F'Path:' '{print $1}')
SBO_PATH=$(sudo sbofind -te $1 | grep Path | awk '{print $NF}')
echo $SBO
echo
echo "Download URL:"
sudo sbofind -tei $1 | grep DOWNLOAD= | awk -F '"' '{print $2}'
echo
echo "Home Page:"
sudo sbofind -tei $1 | grep HOMEPAGE= | awk -F '"' '{print $2}'
echo
if [[ $(md5sum $1/README | awk '{print $1}') == $(md5sum $SBO_PATH/README | awk '{print $1}') ]]
then
    echo "README matches"
else
    printf "${RED}README MIS-MATCH${NC}\n"
fi

if [[ $(md5sum $1/$1.SlackBuild | awk '{print $1}') == $(md5sum $SBO_PATH/$1.SlackBuild | awk '{print $1}') ]]
then
    echo "$1.SlackBuild matches"
else
    printf "${RED}$1.SlackBuild MIS-MATCH${NC}\n"
fi

if [[ $(md5sum $1/$1.info | awk '{print $1}') == $(md5sum $SBO_PATH/$1.info | awk '{print $1}') ]]
then
    echo "$1.info matches"
else
    printf "${RED}$1.info MIS-MATCH${NC}\n"
fi

if [[ $(md5sum $1/slack-desc | awk '{print $1}') == $(md5sum $SBO_PATH/slack-desc | awk '{print $1}') ]]
then
    echo "slack-desc matches"
else
    printf "${RED}slack-desc MIS-MATCH${NC}\n"
fi
