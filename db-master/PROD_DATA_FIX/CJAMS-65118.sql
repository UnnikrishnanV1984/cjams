 
 /*
   Issue Description: CJAMS-65118
   Category/ Module  : posc 
   Root cause: Requested to do the data fix to change status from inprogress to approved.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
 
 update safecareplan set approvalstatus=16,updatedon=now()
 where safecareplanid='569bb165-727f-45bf-b1c5-b48c2b25ef2b' and activeflag=1;