if ! command -v curl &> /dev/null
then
    echo "curl does not exist, installing it..."
    apt install curl -y
fi
