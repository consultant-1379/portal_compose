#!/bin/bash
#Purpose = Copy /data and /usr/aia-data
#START
TIME=`date +%b-%d-%y`
IP=$(cat /home/cloud-user/.env | grep HOSTIP | sed 's/.*=//')
wget http://10.44.149.3:8080/swift/v1/backup/datafolder-backup-$TIME.tar.gz
tar -zxf datafolder-backup-$TIME.tar.gz -C /
rm -rf datafolder-backup-$TIME.tar.gz
rm -rf /data/wordpress/
mv /usr/aia-data/wordpress/ /data/
rm -rf /usr/aia-data
rm /data/wordpress/mysql/master*
sed -i 's/eselivm3v258l.lmera.ericsson.se:23306/mariadb:3306/g' /data/wordpress/html/wp-config.php
sed -i "s/analytics.ericsson.se/$IP/g" /data/portal/app/api.js
mkdir /data/tomcat
cp /tmp/compose/metadata-rest.war /data/tomcat/
#END
