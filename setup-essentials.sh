REQUIRED_COMMANDS=(sudo git curl wget)

for required in ${REQUIRED_COMMANDS[@]}; do
    if ! command -v $required &> /dev/null;
    then
        echo "Installing $required..."
        apt install $required -y
    fi
done