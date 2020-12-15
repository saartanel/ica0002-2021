# Service installation/configuration and data restoration

## MySQL and MySQL exporter
Ansible handles installation and configuration
ansible-playbook infra.yaml -tmysql

### Restoration in saartanel-1 (MySQL master):
```
Switch user to backup
sudo su - backup
Empty restore folder
rm /home/backup/restore/*
Import data with duplicity to host  
duplicity --no-encryption restore rsync://saartanel@backup.toenail.ts//home/saartanel/ restore/  
Import data to MySQL master
mysql agama < /home/backup/restore/agama.sql
```


## Prometheus  
Ansible handles installation and configuration
ansible-playbook infra.yaml -tprometheus

### Restoration in saartanel-3 (prometheus server):   
```
Switch user to backup
sudo su - backup
Empty restore folder
rm /home/backup/restore/*
Import data with duplicity to host  
duplicity --no-encryption restore rsync://saartanel@backup.toenail.ts//home/saartanel/ restore/  
Stop prometheus service for restoration
service prometheus stop
Copy imported folder to /var/lib
cp -a /home/backup/restore/prometheus /var/lib/ 
Give imported folder permissions for Prometheus service    
chown prometheus:prometheus -R /var/lib/prometheus     
Start prometheus service
service prometheus start
```


## Influxdb and Telegraf
Ansible handles installation and configuration
ansible-playbook infra.yaml -tinfluxdb

### Restoration in saartanel-3 (inlfuxdb server):
```
Switch user to backup
sudo su - backup
Empty restore folder
rm /home/backup/restore/*
Import data with duplicity to host  
duplicity --no-encryption restore rsync://saartanel@backup.toenail.ts//home/saartanel/ restore/  
exit
Restore imported data to Influxdb
influxd restore -metadir /var/lib/influxdb/meta /home/backup/restore
influxd restore -database telegraf -datadir /var/lib/influxdb/data /home/backup/restore 
influxd restore -database latency -datadir /var/lib/influxdb/data /home/backup/restore
```


## Grafana      
Ansible handles installation and configuration
ansible-playbook infra.yaml -tgrafana_docker
       
### Restoration in saartanel-3 (grafana server):
```
Switch user to backup
sudo su - backup   
Empty restore folder
rm /home/backup/restore/*
Import data with duplicity to host  
duplicity --no-encryption restore rsync://saartanel@backup.toenail.ts//home/saartanel/ restore/  
Copy grafana.db to Grafana shared volume
docker cp /home/backup/restore/grafana.db Grafana:/var/lib/grafana/  
Give permissions for 472 to new .db file
chown 472:472 /opt/docker/grafana/grafana.db
Restart container for new .db
docker restart Grafana
```


## Nginx, Nginx exporter and node exporter
Ansible handles installation and configuration
ansible-playbook infra.yaml -tnginx

## Bind9 (dns)
Ansible handles installation and configuration
ansible-playbook infra.yaml -tbind


## HAProxy and HAProxy exporter
Ansible handles installation and configuration
ansible-playbook infra.yaml -thaproxy


## Keepalived and keepalived exporter
Ansible handles installation and configuration
ansible-playbook infra.yaml -tkeepalived


## Bind exporter
Ansible handles installation and configuration
ansible-playbook infra.yaml -tbind_exporter