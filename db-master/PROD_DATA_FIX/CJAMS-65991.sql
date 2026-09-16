 /*
   Issue Description:CJAMS-65991
   Category/ Module  : posc 
   Root cause: Requested to do the data fix to delete inprogress record.
   Fix provided: Data fix is done to remove the in progress posc record
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update safecareplan
set activeflag=0,
updatedon=now() where safecareplanid='99a9e4d8-bd09-4465-9e60-c11024d3298e' and activeflag=1;