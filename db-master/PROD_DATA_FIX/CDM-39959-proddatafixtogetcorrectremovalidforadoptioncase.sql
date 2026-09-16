/*
   Issue Description: CDM-39959
   Category/ Module  : Prod data fix to update with active intakeservicerequestactorid
   Root cause: Adoption planning is having inactive intakeservicerequestactorid record
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



-- 1c5f214d-1030-418d-b6ec-d68168f6840e
update adoptionplanning set intakeservicerequestactorid = '71d61f23-38ca-4df3-ab21-e34a7673bd1d', updatedby = 'CDM-39959', updatedon = now()
where adoptionplanningid = '5d6848c3-400d-47ce-82d9-1d3cc0dc8c7e' and intakeservicerequestactorid = '1c5f214d-1030-418d-b6ec-d68168f6840e';