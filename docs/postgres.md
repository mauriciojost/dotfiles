# POSTGRESQL

## Setup

```
sudo apt-get install postgresql-all

sudo -u postgres -i

The problem is still your pg_hba.conf file (/etc/postgresql/9.1/main/pg_hba.conf*).

This line:

local   all             postgres                                peer
Should be:
local   all             postgres                                md5




change password to password (dont remember how)

psql -U postgres



driver = "org.postgresql.Driver"
url = "jdbc:postgresql://localhost/main4inoprd"
user = "postgres"
password = "password"



```
