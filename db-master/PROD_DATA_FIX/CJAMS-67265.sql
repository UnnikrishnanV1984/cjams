/*
   Issue Description:CJAMS-67265
   Category/ Module  : posc 
   Root cause: Requested to do the data fix to delete inprogress record.
   Fix provided: Data fix is done to remove the in progress posc record
   Is code fix required: N
   why no code fix is required: user error
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update safecareplan
set activeflag=0,
updatedon=now() where safecareplanid='ce6c9f2f-b9f1-45da-8d10-806aaf9d0f92' and activeflag=1;