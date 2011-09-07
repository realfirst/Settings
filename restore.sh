#!/bin/bash

echo -n ">>> Check to see if ~/Work and ~/Org exists... "
if [ ! -e ~/Work ]; then
    echo "Nope! But I can create it for you."
    mkdir ~/Work ~/Org
fi
echo "OK"

# Get backup file from user
# TODO: get latest one
read -p "Enter backup file: " backup_file

if [ ! -e ~/Dropbox/$backup_file ]; then
    echo "ERROR: $backup_file doesn't exist. Fix it before going on."
    return
fi

echo ">>> Decrypt backup file: $backup_file"
# Use proper GPG in MacOS and Linux
GPG=gpg
if [ `uname` == Darwin ]; then
    GPG=/usr/local/bin/gpg
fi

# Decode
$GPG --yes -o /tmp/backup.tar.bz2 -d $backup_file

# Restore from decoded backup tarball
echo -n ">>> Restoring files to ~/Work... "
tar --keep-newer-files -C ~ -jxvpf /tmp/backup.tar.bz2
if [ ! -e ~/Org/data ]; then
    echo "Make link for ~/Org/data..."
    ln -s ~/Dropbox/Org/data ~/Org/data
fi
echo "done"
