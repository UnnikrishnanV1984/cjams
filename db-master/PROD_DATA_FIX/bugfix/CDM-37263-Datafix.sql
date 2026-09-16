/* 
    Issue Description: CDM-37263
   Category/ Module  : Payment
   Root cause: The purchase auth status is displayed as blank but in the approval history showed as approved by Finance.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    void the rejected provider placement from backend
*/
-- Making an active record so making the status to pending.

update routing set activeflag=1,updatedby='CDM-37263', updatedon=now()
where routingid='b0d99244-2139-4fcc-882a-6e8a8eb94c8a' and objectid='2935522';