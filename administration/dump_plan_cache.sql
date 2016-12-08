use sem5

select
    SUBSTRING(text, (statement_start_offset/2) + 1,
    (CASE WHEN statement_end_offset = -1 THEN LEN(CONVERT(nvarchar(max), text)) * 2 ELSE statement_end_offset END - statement_start_offset)/2) as sqlstmt,
    total_physical_reads/execution_count as avg_physical_reads,
    total_logical_reads/execution_count as avg_logical_reads,
    total_logical_writes/execution_count as avg_logical_writes,
    total_worker_time/execution_count/1024 as avg_cpu_time_ms,
    total_elapsed_time/execution_count/1024 as avg_duration_ms,
    query_plan,
    st.dbid, st.objectid, db_name(st.dbid) as db, object_name(st.objectid) objname,
    execution_count, total_physical_reads, total_logical_reads, total_elapsed_time/1024 as total_elapsed_time_ms,
    total_logical_writes, total_clr_time/1024 as total_clr_time_ms
into DbaMgmt..plancache5
from sys.dm_exec_query_stats qs
cross apply
    sys.dm_exec_sql_text(sql_handle) st
cross apply
    sys.dm_exec_query_plan(plan_handle) qp
Order by total_elapsed_time desc

select count(*) from DbaMgmt..plancache4 --where db = ''
select count(*) from DbaMgmt..plancache5 --where db = ''

select * from DbaMgmt..plancache5 where db = ''
