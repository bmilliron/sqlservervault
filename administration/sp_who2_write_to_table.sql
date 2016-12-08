USE <dbname>;

CREATE TABLE temp_sp_who2
    (
      SPID INT,
      Status VARCHAR(1000) NULL,
      Login SYSNAME NULL,
      HostName SYSNAME NULL,
      BlkBy SYSNAME NULL,
      DBName SYSNAME NULL,
      Command VARCHAR(1000) NULL,
      CPUTime INT NULL,
      DiskIO INT NULL,
      LastBatch VARCHAR(1000) NULL,
      ProgramName VARCHAR(1000) NULL,
      SPID2 INT
      , rEQUESTID INT NULL --comment out for SQL 2000 databases

    )


INSERT  INTO temp_sp_who2
EXEC sp_who2

SELECT  *
FROM    temp_sp_who2
WHERE   DBName = ''