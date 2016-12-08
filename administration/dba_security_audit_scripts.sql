--View logs

--8/25 12:11am
SELECT * INTO #log1 FROM sys.fn_get_audit_file ('.sqlaudit',default,default);
GO




SELECT * FROM #log1
UNION
SELECT * FROM #log2



/* drop tables after done

DROP table #log1
GO
DROP table #log2
GO


*/

GO

