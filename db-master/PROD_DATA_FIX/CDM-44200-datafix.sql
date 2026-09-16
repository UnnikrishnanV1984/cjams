/*
   Issue Description: CDM-44200
   Category/ Module  : Pending Approval
   Root cause: user requeseted to remove pending approvals. 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update routing 
set activeflag = 0, updatedon = now(), updatedby = 'CDM-44200'
where routingid = '0555768b-23f2-4bce-88f5-57f7fc442952'
and objectid = '3eab5806-f190-4ad7-b751-bcd5ae66eeb5'
and activeflag = 1;