REQUIRED_COMMANDS=(sudo git curl wget)

for required in ${REQUIRED_COMMANDS[@]}; do
    if ! command -v $required &> /dev/null;
    then
        echo "Installing $required..."

        if [ "$EUID" -ne 0 ]
        then
            sudo apt install $required -y
        else
            apt install $required -y
        fi
    fi
done