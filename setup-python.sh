#!/bin/bash
HERE=$(dirname "$0")
$HERE/setup-sudo.sh
$HERE/setup-essentials.sh

if command -v python3.11 &> /dev/null
then
    echo "Python 3.11 command already exists. Skipping installation of Pyhon 3.11."
    exit 0
fi

sudo apt-get install build-essential -y
sudo apt-get install zlib1g-dev -y

START_DIR=$(pwd)
TMP=$(mktemp -d)
TAR_DIR=$TMP/Python-3.11.1
TAR=$TAR_DIR.tgz

wget -O $TAR https://www.python.org/ftp/python/3.11.1/Python-3.11.1.tgz
mkdir $TAR_DIR
tar -xf $TAR -C $TMP
cd $TAR_DIR

./configure --enable-optimizations
make -j 4
sudo make altinstall

echo "Installed version: "
python3.11 --version

cd $START_DIR

sudo rm -r $TMP
