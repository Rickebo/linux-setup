REPO_NAME=linux-setup
REPO=https://github.com/Rickebo/$REPO_NAME.git
STARTUP_SCRIPT=setup.sh

REQUIRED_COMMANDS=(sudo git curl)

for required in ${REQUIRED_COMMANDS[@]}; do
    if ! command -v $required &> /dev/null;
    then
        echo "Installing $required..."
        apt install $required -y
    fi
done

git clone $REPO

if [ "$EUID" -ne 0 ]
then
    sudo chmod -R +x ./$REPO_NAME
    sudo ./$REPO_NAME/$STARTUP_SCRIPT
else
    chmod -R +x ./$REPO_NAME
    ./$REPO_NAME/$STARTUP_SCRIPT
fi
