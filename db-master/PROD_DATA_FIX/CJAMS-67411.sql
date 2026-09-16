/*
   Issue Description:CJAMS-67411
   Category/ Module  : posc 
   Root cause: Requested to do the data fix to delete inprogress record.
   Fix provided: Data fix is done to remove the in progress posc record
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update safecareplan
set activeflag=0,
updatedon=now() where safecareplanid='2294172f-7ac0-4fab-b9b5-b1691bb83fe9' and activeflag=1;