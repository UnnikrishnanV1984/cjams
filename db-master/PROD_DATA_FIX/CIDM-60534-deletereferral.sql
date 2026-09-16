

/*
Issue Description:User wants to remove the intake #I251013316414
Category/Module: Bug
Root cause: User requested to remove the intake I251013316414.
Fix provided: DB queries  update intakedastatus, intakedastaging table.
Data/Code fix ticket#: CJAMS-60534
Regression Impacts: N/A
Is Code fix Required?: No      
Code fix ticket#: N/A
Reason why no related code fix: User Request
Status of the code fix if already submitted and expected prod fix date:NA
Backup before update/ delete:Query:
*/
update intakedastaging set activeflag =0, updatedby = 'CJAMS-60534', updatedon = now() where intakenumber  ='I251013316414' and activeflag =1; 
update intakedastatus set activeflag =0, updatedby = 'CJAMS-60534', updatedon = now() where intakenumber  ='I251013316414' and activeflag =1; 