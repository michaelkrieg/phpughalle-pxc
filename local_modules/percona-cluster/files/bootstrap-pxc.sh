#!/bin/bash -

export PATH=/usr/sbin:/usr/bin:/sbin:/bin

(
  cd /var/lib/mysql/ && rm -Rf
)

mysql_install_db --user=mysql
service mysql bootstrap-pxc
/usr/bin/mysqladmin -u root password 'ficken100'
