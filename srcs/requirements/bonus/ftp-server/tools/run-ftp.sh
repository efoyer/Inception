#!/bin/bash

adduser $FTP_USR --disabled-password --gecos ""
echo "$FTP_USR:$FTP_PWD" | chpasswd
chown -R $FTP_USR:$FTP_USR /var/www/html
chown -R $FTP_USR:$FTP_USR /var/www/wordpress

echo $FTP_USR | tee -a /etc/vsftpd.userlist &> /dev/null

exec vsftpd /etc/vsftpd.conf