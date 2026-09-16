/*
   Issue Description: CDM-26955
   Category/ Module  : Permanency Plan  
   Root cause: 202108206764:The Permanency plan section is not allowing us to create a plan for Michael Snyder. When you select his name it goes to the other brother. Plan needs to be fixed in order to complete the guardianship plan.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update Permanencyplan set intakeservicerequestactorid='296e7564-41b6-41f3-a4a9-a5ef36d56cb7', updatedon = now(), updatedby = 'CDM-26955' 
where permanencyplanid  in ('d6bb25bc-287d-4a51-9795-beb6833aede5');
