USE [DbaMgmt]
GO

IF EXISTS(SELECT name FROM sysobjects WHERE  name = N'temp1' AND  type = 'U')
  DROP TABLE temp1;

IF OBJECT_ID('DbaMgmt.dbo.tb_audit_log_load', 'U') IS NOT NULL
  DROP TABLE DbaMgmt..tb_audit_log_load;

CREATE TABLE [dbo].[tb_audit_log_load](
	[event_time] [datetime2](7) NOT NULL,
	[sequence_number] [int] NOT NULL,
	[action_id] [varchar](4) NULL,
	[succeeded] [bit] NOT NULL,
	[permission_bitmask] [varbinary](16) NOT NULL,
	[is_column_permission] [bit] NOT NULL,
	[session_id] [smallint] NOT NULL,
	[server_principal_id] [int] NOT NULL,
	[database_principal_id] [int] NOT NULL,
	[target_server_principal_id] [int] NOT NULL,
	[target_database_principal_id] [int] NOT NULL,
	[object_id] [int] NOT NULL,
	[class_type] [varchar](2) NULL,
	[session_server_principal_name] [nvarchar](128) NULL,
	[server_principal_name] [nvarchar](128) NULL,
	[server_principal_sid] [varbinary](85) NULL,
	[database_principal_name] [nvarchar](128) NULL,
	[target_server_principal_name] [nvarchar](128) NULL,
	[target_server_principal_sid] [varbinary](85) NULL,
	[target_database_principal_name] [nvarchar](128) NULL,
	[server_instance_name] [nvarchar](128) NULL,
	[database_name] [nvarchar](128) NULL,
	[schema_name] [nvarchar](128) NULL,
	[object_name] [nvarchar](128) NULL,
	[statement] [nvarchar](4000) NULL,
	[additional_information] [nvarchar](4000) NULL,
	[file_name] [nvarchar](260) NOT NULL,
	[audit_file_offset] [bigint] NOT NULL,
	[user_defined_event_id] [smallint] NOT NULL,
	[user_defined_information] [nvarchar](4000) NULL,
	[audit_schema_version] [int] NOT NULL,
	[sequence_group_id] [varbinary](85) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

IF OBJECT_ID('tempdb.dbo.#audit_logs', 'U') IS NOT NULL
  DROP TABLE tempdb..#audit_logs;

CREATE TABLE #audit_logs (log_name VARCHAR(1000))

INSERT INTO #audit_logs (log_name) VALUES (),
()

DECLARE @current_log VARCHAR(1000)
DECLARE @log_path VARCHAR(1000)
DECLARE @query VARCHAR(1000)

DECLARE c_1 CURSOR FOR 
SELECT * FROM #audit_logs

OPEN c_1
FETCH NEXT FROM c_1 INTO @current_log

SET @log_path = '''B:\audit_logs\' + @current_log + '.sqlaudit'''
PRINT(@log_path)

WHILE @@FETCH_STATUS = 0

BEGIN

SET @query = 'SELECT * INTO DbaMgmt..temp1 FROM sys.fn_get_audit_file (' + @log_path + ',default,default)';
PRINT(@query)
EXEC(@query)


INSERT INTO [dbo].[tb_audit_log_load]
           ([event_time]
           ,[sequence_number]
           ,[action_id]
           ,[succeeded]
           ,[permission_bitmask]
           ,[is_column_permission]
           ,[session_id]
           ,[server_principal_id]
           ,[database_principal_id]
           ,[target_server_principal_id]
           ,[target_database_principal_id]
           ,[object_id]
           ,[class_type]
           ,[session_server_principal_name]
           ,[server_principal_name]
           ,[server_principal_sid]
           ,[database_principal_name]
           ,[target_server_principal_name]
           ,[target_server_principal_sid]
           ,[target_database_principal_name]
           ,[server_instance_name]
           ,[database_name]
           ,[schema_name]
           ,[object_name]
           ,[statement]
           ,[additional_information]
           ,[file_name]
           ,[audit_file_offset]
           ,[user_defined_event_id]
           ,[user_defined_information]
           ,[audit_schema_version]
           ,[sequence_group_id])

	SELECT 
           [event_time]
           ,[sequence_number]
           ,[action_id]
           ,[succeeded]
           ,[permission_bitmask]
           ,[is_column_permission]
           ,[session_id]
           ,[server_principal_id]
           ,[database_principal_id]
           ,[target_server_principal_id]
           ,[target_database_principal_id]
           ,[object_id]
           ,[class_type]
           ,[session_server_principal_name]
           ,[server_principal_name]
           ,[server_principal_sid]
           ,[database_principal_name]
           ,[target_server_principal_name]
           ,[target_server_principal_sid]
           ,[target_database_principal_name]
           ,[server_instance_name]
           ,[database_name]
           ,[schema_name]
           ,[object_name]
           ,[statement]
           ,[additional_information]
           ,[file_name]
           ,[audit_file_offset]
           ,[user_defined_event_id]
           ,[user_defined_information]
           ,[audit_schema_version]
           ,[sequence_group_id] 
		   
		   FROM DbaMgmt..temp1

	DROP TABLE DbaMgmt..temp1; 

FETCH NEXT FROM c_1 INTO @current_log
SET @log_path = '''B:\audit_logs\' + @current_log + '.sqlaudit'''

END



CLOSE c_1
DEALLOCATE c_1




