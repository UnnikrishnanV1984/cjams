/*
 Issue Description:CDM-43224
 Category/ Module:delete intake
 Root cause: delete
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/

update intakedastaging
set activeflag = 0, updatedby ='CDM-43244' , updatedon = now()
where intakenumber ='I241013190307' and activeflag = 1;

update intakedastatus
set activeflag = 0, updatedby ='CDM-43244' , updatedon = now()
where intakenumber ='I241013190307' and activeflag = 1;


update intakesnapshot
set activeflag = 0, updatedby ='CDM-43244' , updatedon = now()
where intakenumber ='I241013190307' and activeflag = 1;

update intakeservicerequest
set activeflag = 0, updatedby ='CDM-43244' , updatedon = now()
where intakenumber ='I241013190307' and activeflag = 1;

update routing
set activeflag = 0, updatedby ='CDM-43244' , updatedon = now()
where objectid ='I241013190307' and activeflag = 1;
