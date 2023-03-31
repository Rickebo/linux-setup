#!/bin/bash
REPO_NAME=linux-setup
REPO=https://github.com/Rickebo/$REPO_NAME.git
STARTUP_SCRIPT=setup.sh

# If running as root:
if (( $EUID == 0 )); then
    # If sudo is not installed:
    if ! command -v sudo &> /dev/null;
    then
        echo "Installing sudo..."
        apt update && apt install -y sudo
    fi

    echo "The script is running as root."
else
    # Not running as root! Try sudo, then try su, else print error message
    echo "Not running as root! The script requires root privileges."
    if command -v sudo &> /dev/null;
    then
        echo "Re-running the script as root using sudo..."
        sudo ./$0
        exit
    fi

    if command -v su &> /dev/null;
    then
        echo "Re-running the script as root using su..."
        su root -c ./$0
        exit
    fi

    echo "Could not rerun the script as root. Please switch to a user with root privileges and rerun the script."
    exit
fi

REQUIRED_COMMANDS=(sudo git curl)

for required in ${REQUIRED_COMMANDS[@]}; do
    if ! command -v $required &> /dev/null;
    then
        echo "Installing $required..."
        apt install $required -y
    fi
done

TMP=$(mktemp -d)

git clone $REPO $TMP

if [ "$EUID" -ne 0 ]
then
    sudo chmod -R +x $TMP
    sudo $TMP/$STARTUP_SCRIPT
    sudo rm -r $TMP
else
    chmod -R +x $TMP
    $TMP/$STARTUP_SCRIPT
    rm -r $TMP
fi
