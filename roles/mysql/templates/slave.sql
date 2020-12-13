STOP SLAVE;
CHANGE MASTER TO MASTER_HOST='{{ mysql_host }}',
                 MASTER_USER='{{ mysql_replication_user }}',
                 MASTER_PASSWORD='{{ mysql_password }}';
RESET SLAVE;
START SLAVE;