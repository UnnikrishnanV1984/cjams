/*
   Issue Description: CDM-20680
   Category/ Module  : 

   Root cause: Remove duplicate approvals
   
   Pull request# for code fix: N/A
   Reason why no related code fix:  N/A
   Status of the code fix if already submitted and expected prod fix date:  N/A
*/

update routing set activeflag =0, updatedby = 'CDM-20680', updatedon = now() where routingid in ('89ad7d9f-7cc8-49a6-a99b-e16179b28720', 
'2d572d95-094f-4a6f-a4b5-112c471e04fa');


UPDATE intakeservicerequestdispositioncode 
SET activeflag =0, 
updatedby = 'CDM-20680',
updatedon = now() 
WHERE 
intakeservicerequestdispositioncodeid in ('81ef86f2-fbd6-4d2e-8ec6-4241f172dea6','6db13747-0a15-445e-a040-6429ffe84ad0');