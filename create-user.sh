#!/bin/bash
echo "Adding user $1..."

HERE=$(dirname "$0")
$HERE/setup-sudo.sh
$HERE/setup-essentials.sh

sudo useradd -m $1
sudo passwd $1
sudo usermod -aG sudo $1
sudo usermod --shell /bin/bash $1

sudo mkdir /home/$1/.ssh
sudo chmod 700 /home/$1/.ssh

sudo touch /home/$1/.ssh/authorized_keys
sudo chmod 644 /home/$1/.ssh/authorized_keys

sudo chown -R $1:$1 /home/$1/.ssh

if test -z "$2"
then
    echo "Not retrieving any ssh key since github username was not specified."
else
    echo "Retrieving public key from $2 on github..."

    SSH_KEY=$(curl -S https://github.com/$2.keys)

    if test -z "$SSH_KEY"
    then
        echo "No ssh key was found for $2 on github"
    else
        echo "$SSH_KEY" | sudo tee -a /home/$1/.ssh/authorized_keys > /dev/null
    fi
fi

sudo chown -R $1:$1 /home/$1/.ssh
