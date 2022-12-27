#!/bin/bash
HERE=$(dirname "$0")
$HERE/setup-sudo.sh
$HERE/setup-python.sh
python3.11 $HERE/setup-ssh.py
