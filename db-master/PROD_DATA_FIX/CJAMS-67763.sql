
/*
Issue Description:CJAMS-67763 Duplicate AR Summaries
Category/Module: Case Management
Root cause: AVerified in Production and there are two AR Narrative Summary available while there is one alleged victim & alleged maltreator in the CPS AR case.
Fix provided: Data fix has been promoted to remove one of the duplicate record  from backend
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: Data fix 
*/
update investigationallegation 
	set activeflag = 0, updatedon = now(), updatedby = 'CJAMS-67763' 
	where investigationallegationid in ('a040ebb3-c337-4fa8-86fd-8c9867541718') and activeflag = 1;

update investigationallegationmaltreators 
	set activeflag = 0, updatedon = now(), updatedby = 'CJAMS-67763' 
	where investigationallegationid in ('a040ebb3-c337-4fa8-86fd-8c9867541718') and activeflag = 1;
	