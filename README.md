## Introduction

This collection of scripts is commonly used by me to quickly set up VMs.

## Prerequisites

To run the script, apt must be installed and set up, as well as curl if the command below is used.

## Setup

To run the setup script remotely, run the following command:

```bash
wget https://raw.githubusercontent.com/Rickebo/linux-setup/main/setup-remote.sh; bash ./setup-remote.sh
```

The script sets up:

- sudo
- curl (if not installed already)
- wget
- Python 3.11
  - compiled from source
- Users, and SSH keys from GitHub
  - Username, password and GitHub username is specified when script is running
- ssh
  - Sets up ssh configuration to only allow ssh using public keys. Therefore, make sure to specify a GitHub username for
    at least one user to be able to access the system.

## Supported distros

The scripts have been used and tested primarily on Debian 11 "Bullseye", and therefore likely dont work on other
distros.
