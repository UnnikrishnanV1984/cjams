/*
Issue Description:I251013252420:Need to generate a ticket to have this information removed from this tree this worker put under another intake referral number.
Category/Module: Bug
Root cause: User can only create intake , they do not have access to delete . So, they request requested to remove it.
Fix provided: DB queries  update intakedastatus, intakedastaging table.
Data/Code fix ticket#: CJAMS-58756
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Roor
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/



update intakedastatus 
	set activeflag = 0, updatedon = now(), updatedby = 'CJAMS-58756' 
where intakenumber = 'I251013252420' and activeflag =1;

update intakedastaging 
	set activeflag=0, updatedon = now(), updatedby = 'CJAMS-58756' 
where intakenumber ='I251013252420' and activeflag=1;
