/*
 Issue Description:CDM-18541
 Category/ Module: Delete Duplicate Case
 Root cause: user Delete Case
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/
update intakedastaging set activeflag=0,updatedby='CDM-18541',updatedon=now() where id='3093531';
update intakedastatus set activeflag=0,updatedby='CDM-18541',updatedon=now() where intakedastatusid='efd882ff-15c6-43ff-a017-693f773ade0c'