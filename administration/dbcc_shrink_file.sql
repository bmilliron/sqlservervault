--Shrink file

USE UserDB;
GO
DBCC SHRINKFILE (DataFile1, 7);
GO