REPO_NAME=linux-setup
REPO=https://github.com/Rickebo/$REPO_NAME.git
STARTUP_SCRIPT=setup.sh

REQUIRED_COMMANDS=(sudo git curl)

for required in ${REQUIRED_COMMANDS[@]}; do
    if ! command -v $required &> /dev/null
    then
        echo "Installing $required..."
        apt install $required -y
    fi
done

git clone $REPO

if [ "$EUID" -ne 0 ]
    sudo ./$REPO/$STARTUP_SCRIPT
else
    ./$REPO/$STARTUP_SCRIPT
fi
