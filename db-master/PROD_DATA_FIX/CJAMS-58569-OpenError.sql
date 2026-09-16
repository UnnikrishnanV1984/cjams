

/*
Issue Description: Please remove the  draft intake # I251013250314 as requested.
Category/Module: Bug
Root cause: Users cannot Delete the intake,they can only create .
Fix provided: DB queries to delete intake in intakedastatus,intakedastaging tables.
Data/Code fix ticket#: CJAMS-58569
Regression Impacts: N/A
Is Code fix Required?: No    
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


update intakedastatus
	set	activeflag = 0,
		updatedon = now(),
		updatedby = 'CJAMS-58569'
	where intakenumber in ('I251013250314')
		and activeflag = 1;
	

update intakedastaging
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CJAMS-58569'
	where intakenumber in ('I251013250314')
		and activeflag = 1;