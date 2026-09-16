/*
 Issue Description:CDM-42719
 Category/ Module:delete intake
 Root cause: delete
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/

update intakedastatus 
set activeflag = 0,updatedby = 'CDM-42719',updatedon = now()
where intakenumber = 'I241013170735' and activeflag = 1;

update intakedastaging 
set activeflag = 0,updatedby = 'CDM-42719',updatedon = now()
where intakenumber = 'I241013170735' and activeflag = 1;