#!/bin/bash

echo -n ">>> Check to see if both ~/Work and ~/Dropbox exist ... "
if [ ! -e ~/Work ] || [ ! -e ~/Dropbox ]; then
    echo "FAILED"
    return
fi
echo "OK"

echo ">>> Backing up all files at ~/Work..."
# cd ~/Work > /dev/null
BACKUP_FILE=work_backup.`date +%Y-%m-%d`
GPG=gpg
if [ `uname` == Darwin ]; then
    GPG=/usr/local/bin/gpg
fi
tar --exclude=data -jcv -C ~ Work Org | $GPG --yes -eq -r yenliangl -o /tmp/$BACKUP_FILE
mv /tmp/$BACKUP_FILE ~/Dropbox
echo ">>> Encrypted backup ~/Dropbox/$BACKUP_FILE created and pushed to Dropbox <<< "
