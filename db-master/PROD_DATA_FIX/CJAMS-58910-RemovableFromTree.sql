
/*
Issue Description:intake # I251013251729 is still in-progress status. User is asked to remove the intake.
Category/Module: Bug
Root cause: User can only create intake , they do not have access to delete . So, they request to remove it.
Fix provided: DB queries  update intakedastatus, intakedastaging table.
Data/Code fix ticket#: CJAMS-58910
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Roor
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/



update intakedastatus 
	set activeflag = 0, updatedon = now(), updatedby = 'CJAMS-58910' 
where intakenumber = 'I251013251729' and activeflag =1;

update intakedastaging 
	set activeflag=0, updatedon = now(), updatedby = 'CJAMS-58910' 
where intakenumber ='I251013251729' and activeflag=1;