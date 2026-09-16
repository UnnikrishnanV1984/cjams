/*
Issue Description:User wants to remove the intake #I241013046386 
Category/Module: Bug
Root cause: User requested to delete the intake as they do not have access to delete . So, they request requested to remove it.
Fix provided: DB queries to update intakedastatus, intakedastaging table.
Data/Code fix ticket#: CJAMS-60666
Regression Impacts: N/A
Is Code fix Required?: No      
Code fix ticket#: N/A
Reason why no related code fix: User Roor
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


update intakedastatus
set activeflag=0, updatedby='CJAMS-60666', updatedon=now()
where intakenumber='I241013046386' and activeflag=1;

update intakedastaging
set activeflag=0, updatedby='CJAMS-60666', updatedon=now()
where intakenumber='I241013046386' and activeflag=1;