--truncate tlog without backup

USE [master]
GO
ALTER DATABASE [dbname] SET RECOVERY SIMPLE WITH NO_WAIT
DBCC SHRINKFILE(PSCS_log, 1)
ALTER DATABASE [dbname] SET RECOVERY FULL WITH NO_WAIT
GO