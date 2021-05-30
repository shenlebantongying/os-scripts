# Postgre > mariadb/mysql

Default root passwd doesn't exist and can only be login via `su` root
Reset root passwd to play locally
```
ALTER USER 'root'@'localhost' IDENTIFIED BY 'PASSWORD';
```


# first install message
Installing MariaDB/MySQL system tables in '/var/lib/mysql' ...
OK

Two all-privilege accounts were created.
One is root@localhost, it has no password, but __you need to
be system 'root' user to connect__. Use, for example, sudo mysql
The second is mysql@localhost, it has no password either, but
you need to be the system 'mysql' user to connect.
After connecting you can set the password, if you would need to be
able to connect as any of these users with a password and without sudo


You can start the MariaDB daemon with:
cd '/usr' ; /usr/bin/mysqld_safe --datadir='/var/lib/mysql'

You can test the MariaDB daemon with mysql-test-run.pl
cd '/usr/mysql-test' ; perl mysql-test-run.pl

