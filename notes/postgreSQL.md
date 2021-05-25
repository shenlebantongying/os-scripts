Refresh install of PostgreSQL only use 80mb of memory.

# Management 101

Service -> `systemctl status postgresql.service`

```
su
su -l postgres
```

psql -> main cli

check port -> `cat /etc/services | grep postgresql`

# Misc

default data dir

/var/lib/postgres/data/

TODO:
+ .pgpass?