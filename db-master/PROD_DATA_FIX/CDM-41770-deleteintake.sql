/*
 Issue Description:CDM-41770
 Category/ Module:Intake
 Root cause: user requested to delete intake
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/



update intakedastatus 
set activeflag=0,updatedon=now(),updatedby='CDM-41770'
where intakenumber ='I241013104544' and activeflag=1;

update intakedastaging 
set activeflag=0,updatedon=now(),updatedby='CDM-41770'
where intakenumber ='I241013104544' and activeflag=1;

