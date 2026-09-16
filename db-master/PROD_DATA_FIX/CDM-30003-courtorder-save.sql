/*
   Issue Description: CDM-30003
   Category/ Module  : Court
   Root cause: courtorder details was not patching up in the form
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
update intakeservreqcourtorder 
set intakeservicerequestactorid = 'd3d0d3d5-5e53-4ca0-b674-7281408fc958', 
updatedby ='CDM-30003', 
updatedon = now() 
where intakeservreqcourtorderid ='78074177-6fe9-44bf-9bbf-038f63ed94cc'