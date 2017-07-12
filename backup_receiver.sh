#!/bin/bash
mailboxLocation=/home/backup_sender/backup_mailbox/
backupFolderLocation=/home/backup_grabber/backups/

rsync -avz -e "ssh -p 2202" backup_sender@wwustc.com:$mailboxLocation $backupFolderLocation --remove-source-files
