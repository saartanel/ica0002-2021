# Backup SLA
This document is the backup SLA for the Toenail™ company.

## Backup coverage and approaches
### Web servers
Web servers dont need to be backed up, since they can be restored with ansible playbook.

### App servers
App servers dont need to be backed up, since they can be restored with ansible playbook.

### Database servers
Our two database servers are backed up every midnight with a cron job, that dumps the database into a specified folder.
Every sunday, a full rsync is issued to the backup server.
Monday through saturday an incremental rsync is issued to the backup server.

### DNS servers
DNS servers dont need to be backed up, since they can be restored with ansible playbook.

### Monitoring servers
#### InfluxDB
Same as our database servers, InfluxDB is backed up with a cron job every midnight into a specified folder.
Every sunday, a full rsync is issued to the backup server.
Monday through saturday an incremental rsync is issued to the backup server.
#### Prometheus
Prometheus service doesnt need to be backed up, since it can be restored with ansible playbook
#### Grafana
Grafanas container itself doesnt need to be backed up, since it can be restored with ansible playbook.
Same as our database servers, Grafanas .db file is backed up with a cron job every midnight into a specified folder.
Every sunday, a full rsync is issued to the backup server.
Monday through saturday an incremental rsync is issued to the backup server.
#### Telegraf
Telegrafs service doesnt need to be backed up, since it can be restored with ansible playbook.
Telegrafs database is held in InfluxDB and is backed up via it's cron job.

### Ansible repository
Ansible repository is synced into a private Github repository where only authorized personel have access to.

## Information
### Backup RPO
Backups of the afformentioned databases are made every midnight and held on the host servers.
Every day a cron job syncs the backups to the backup server.

### Versioning and retention
Duplicity creates backups of databases on backup server and does not delete them automatically.
The backup versions are held on the server for as long as they are not deleted manually.

### Usability
Backup recovery can be verified from the recovery test.
Since the system administrator is responsible for the platform, he can only check on the services and import the last versioned data from the backup server.
Service statuses can be monitored from Grafana.
Business side has to check whether data has been lost from the databases.

### Restoration criteria
Backup of a specific service database should be restored when the service needs to be build up from the ground.
Backups need to be made also, when valuable data has been lost on the service database.

### Backup RTO
Since our company runs on instant noodles and lemonade, the system administrator is not paid well enough to keep tabs on the servers the entire day.
If restoration is needed, the system administrator must restore the data in day (24 hours) from the start of the incident.
