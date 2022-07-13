#!/bin/sh

echo "Type the email that you would like to associate with the SSH key, then press [ENTER]:"
read SSH_EMAIL

echo "About to generate SSH keys"
sleep 2

yes | ssh-keygen -f $HOME/.ssh/id_gmail -t rsa -C "${SSH_EMAIL}" -N ''
chmod 700 $HOME/.ssh
touch $HOME/.ssh/authorized_keys
chmod 600 $HOME/.ssh/authorized_keys
echo "Done generating keys"
