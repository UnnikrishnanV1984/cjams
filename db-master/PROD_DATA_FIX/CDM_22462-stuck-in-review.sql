/*
**************************************************************************************************	
	Issue Description: CDM-22462
   Category/ Module  : Stuck in reveiew
   Root cause: user wants to remove  stuck in review  in subsidy rate 
   Pull request# for code fix: 5661
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update permanencyplan
set intakeservicerequestactorid = 'b9054c13-7864-4ec9-b089-d39aaf91226d' ,
updatedby = 'CDM-22462', updatedon = now()
where permanencyplanid = 'e86e320f-899b-45e8-9984-86caa7169eae';