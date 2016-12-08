--audit queries

--find audit action_id values
Select DISTINCT action_id,name,class_desc,parent_class_desc from sys.dm_audit_actions