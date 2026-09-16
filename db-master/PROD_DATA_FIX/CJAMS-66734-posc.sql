/*
   Issue Description:CJAMS-66734
   Category/ Module  : posc 
   Root cause: Requested to do the data fix to delete inprogress record.
   Fix provided: Data fix is done to remove the in progress posc record
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update safecareplan
set activeflag=0,
updatedon=now() where safecareplanid='28cba937-5ac7-4297-830b-d8555fdb245e' and activeflag=1;