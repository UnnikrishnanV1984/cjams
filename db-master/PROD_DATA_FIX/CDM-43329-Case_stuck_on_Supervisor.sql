/*
   Issue Description: CDM-43329
   Category/ Module  : Pending Approval
   Root cause: User wants to remove CPS-IR case from pending approval
   Pull request# for code fix: 
   Reason why no related code fix: User error
*/


update intakeservicerequest
set isrouted = true, updatedon = now(), updatedby = 'CDM-43329'
WHERE servicerequestnumber = '241022967745' and activeflag = 1;