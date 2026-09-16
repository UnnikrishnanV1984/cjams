/*
   Issue Description: CDM-39744
   Category/ Module  : Prod data fix to update with the active intakeservicerequest actor id
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/




-- 4169e120-e0d3-4672-86d2-930c4bdf8cb2
update adoptionplanning set intakeservicerequestactorid = '173baeb2-b145-49e4-8b61-8557115ae8b6', updatedon = now(), updatedby = 'CDM-39744'
where adoptionplanningid = 'c88d66a4-790e-47bc-afb5-63a58ad3fbfe';