--View the quorum model

SELECT 	cluster_name, quorum_type_desc, quorum_state_desc
FROM 		sys.dm_hadr_cluster;

--view the node votes

SELECT	member_name, number_of_quorum_votes
FROM 		sys.dm_hadr_cluster_members;

--PowerShell

--View current vote settings for all nodes


Get-ClusterNode | fl NodeName, NodeWeight

