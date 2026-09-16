/*
 Issue Description:CJAMS-64054
 Category/ Module:delete intake
 Root cause: delete
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/

update intakedastatus 
set activeflag = 0,updatedby = 'CJAMS-64054',updatedon = now()
where intakenumber = 'I251013528803' and activeflag = 1;

update intakedastaging 
set activeflag = 0,updatedby = 'CJAMS-64054',updatedon = now()
where intakenumber = 'I251013528803' and activeflag = 1;