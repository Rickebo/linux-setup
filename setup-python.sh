
HERE=$(dirname "$0")
$HERE/setup-sudo.sh

if command -v python3.10 &> /dev/null
then
    echo "Python 3.10 command already exists. Skipping installation of Pyhon 3.10."
    exit 0
fi

sudo apt-get install build-essential -y
sudo apt-get install zlib1g-dev -y

START_DIR=$(pwd)
TMP=$(mktemp -d)
TAR_DIR=$TMP/Python-3.10.0
TAR=$TAR_DIR.tgz

wget -O $TAR https://www.python.org/ftp/python/3.10.0/Python-3.10.0.tgz
mkdir $TAR_DIR
tar -xf $TAR -C $TMP
cd $TAR_DIR

./configure --enable-optimizations
make -j 4
sudo make altinstall

echo "Installed version: "
python3.10 --version

cd $START_DIR

#rm -r $TMP
