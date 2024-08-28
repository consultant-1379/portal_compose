#!/bin/bash
#Purpose = Copy /data and /usr/aia-data
#START
TIME=`date +%b-%d-%y`

#Import Mongo Collections START
MONGOCONTID=mongo
mkdir /tmp/mongoBackups
wget http://10.44.149.3:8080/swift/v1/backup/$TIME-collections.tar.gz
mv $TIME-collections.tar.gz /tmp/mongoBackups
/usr/bin/docker exec $MONGOCONTID mkdir /tmp/mongoBackups
/usr/bin/docker cp /tmp/mongoBackups/$TIME-collections.tar.gz $MONGOCONTID:/tmp/mongoBackups/
/usr/bin/docker exec $MONGOCONTID tar -mzxf /tmp/mongoBackups/$TIME-collections.tar.gz -C /tmp/mongoBackups/
/usr/bin/docker exec $MONGOCONTID mongoimport -d aia -c aia-templates /tmp/mongoBackups/aia-templates.json
/usr/bin/docker exec $MONGOCONTID mongoimport -d aia -c applications /tmp/mongoBackups/applications.json
/usr/bin/docker exec $MONGOCONTID mongoimport -d aia -c schema-inputs /tmp/mongoBackups/schema-inputs.json
/usr/bin/docker exec $MONGOCONTID mongoimport -d aia -c schema-outputs /tmp/mongoBackups/schema-outputs.json
/usr/bin/docker exec $MONGOCONTID mongoimport -d aia -c schema-test /tmp/mongoBackups/schema-test.json
/usr/bin/docker exec $MONGOCONTID mongoimport -d aia -c templates /tmp/mongoBackups/templates.json
/usr/bin/docker exec $MONGOCONTID rm -rf /tmp/mongoBackups
rm -rf /tmp/mongoBackups
rm -rf $TIME-collections.tar.gz
#Import Mongo Collections END
