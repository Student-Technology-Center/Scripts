#!/bin/bash
test=$(date '+%F').tar.gz

tar -cvpzf $test --exclude=/$test --one-file-system /
chown backup_sender $test
mv $test /home/backup_sender/backup_mailbox/$test

sleep 1h
reboot
