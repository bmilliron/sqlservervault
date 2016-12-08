--rebuild script

sqlcmd -S <server name> -E -d master -Q  "EXEC sp_help_revlogin" -o "build_logins.sql" -h-1 -w 700

--drop script

sqlcmd -S <server name> -E -d master -Q  "select 'DROP LOGIN ' + [name] from sys.server_principals where type_desc = 'SQL_LOGIN' and sid <> 0x01 and substring(name, 1, 1) <> '#' and name <> 'oitag'" -o "drop_logins.sql" -h-1 -w 700
