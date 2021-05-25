Refresh install of PostgreSQL only use 80mb of memory.

# Management 101

Service -> `systemctl status postgresql.service`

```
su
su -l postgres
```

psql -> main cli

check port -> `cat /etc/services | grep postgresql`

by default, new schema goes into "public"

# Misc

default data dir

/var/lib/postgres/data/

pSQL Use cluster->databases->schemas hierarchy
-> MySql only use schemas

TODO:
+ .pgpass?
+ Important feature -> PostGIS
