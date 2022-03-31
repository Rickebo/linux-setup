HERE=$(dirname "$0")
$HERE/setup-sudo.sh
$HERE/setup-python.sh
python3.10 $HERE/setup-ssh.py
