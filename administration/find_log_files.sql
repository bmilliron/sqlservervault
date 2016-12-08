--Finds the last t-log restored

SELECT TOP 1

rsh.destination_database_name AS [Database],
rsh.user_name AS [Restored By],
CASE WHEN rsh.restore_type = 'D' THEN 'Database'
WHEN rsh.restore_type = 'F' THEN 'File'
WHEN rsh.restore_type = 'G' THEN 'Filegroup'
WHEN rsh.restore_type = 'I' THEN 'Differential'
WHEN rsh.restore_type = 'L' THEN 'Log'
WHEN rsh.restore_type = 'V' THEN 'Verifyonly'
WHEN rsh.restore_type = 'R' THEN 'Revert'
ELSE rsh.restore_type
END AS [Restore Type],
rsh.restore_date AS [Restore Started],
bmf.physical_device_name AS [Restored From],
rf.destination_phys_name AS [Restored To]
FROM msdb.dbo.restorehistory rsh
INNER JOIN msdb.dbo.backupset bs ON rsh.backup_set_id = bs.backup_set_id
INNER JOIN msdb.dbo.restorefile rf ON rsh.restore_history_id = rf.restore_history_id
INNER JOIN msdb.dbo.backupmediafamily bmf ON bmf.media_set_id = bs.media_set_id
where destination_database_name = ''
and restore_type = 'L'
ORDER BY rsh.restore_date DESC