# Backup SLA
This document is the backup SLA for the Toenail™ company.

## Web servers
Web servers dont need to be backed up, since they can be restored with ansible playbook.

## App servers
App servers dont need to be backed up, since they can be restored with ansible playbook.

## Database servers
Our two database servers are backed up every midnight with a cron job, that dumps the database into a specified folder.
Every sunday, a full rsync is issued to the backup server.
Monday through saturday an incremental rsync is issued to the backup server.

## DNS servers
DNS servers dont need to be backed up, since they can be restored with ansible playbook.

## Monitoring servers
### InfluxDB
Same as our database servers, InfluxDB is backed up with a cron job every midnight into a specified folder.
Every sunday, a full rsync is issued to the backup server.
Monday through saturday an incremental rsync is issued to the backup server.
### Prometheus
Prometheus service doesnt need to be backed up, since it can be restored with ansible playbook
### Grafana
Grafanas container itself doesnt need to be backed up, since it can be restored with ansible playbook.
Same as our database servers, Grafanas .db file is backed up with a cron job every midnight into a specified folder.
Every sunday, a full rsync is issued to the backup server.
Monday through saturday an incremental rsync is issued to the backup server.
### Telegraf
Telegrafs service doesnt need to be backed up, since it can be restored with ansible playbook.
Telegrafs database is held in InfluxDB and is backed up via it's cron job.


## Ansible repository
todo