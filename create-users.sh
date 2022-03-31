#!/bin/bash
HERE=$(dirname "$0")
$HERE/setup-sudo.sh

echo "Enter a username to create, or press enter to skip user creation"
while read -r USER; do
    if test "$USER"
    then
        echo "Enter user github name, to use for retrieving SSH key, or press enter to skip."
        read -r GITHUB;

        echo "Creating user $USER"
        $HERE/create-user.sh $USER $GITHUB

        echo "Enter another username to create, or press enter if finished creating users"
    else
        echo "Exiting user creation."
        break
    fi
done
