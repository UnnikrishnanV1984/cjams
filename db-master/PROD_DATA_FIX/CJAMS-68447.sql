/*
   Issue Description:CJAMS-68447
   Category/ Module  : posc 
   Root cause:User error, Requested to do the data fix to delete inprogress record.
   Fix provided: Data fix is done to remove the in progress posc record.
   Is code fix required: N 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update safecareplan
set activeflag=0,
updatedon=now() where safecareplanid='c29bf1d2-025a-45db-b2f5-5732dfb99f1d' and activeflag=1;