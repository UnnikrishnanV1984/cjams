/*
   Issue Description: CDM-39958
   Category/ Module  : Prod data fix to update with active intakeservicerequestactorid
   Root cause: Adoption planning is having inactive intakeservicerequestactorid record
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



-- b24dce5f-989e-4559-8f95-8eb5e1f60f24
update adoptionplanning set intakeservicerequestactorid = '275fa2f8-5d98-4cb7-b1e4-eed815ea8966', updatedby = 'CDM-39958', updatedon = now()
where adoptionplanningid = 'b8c6b8f9-2ea4-4ebf-9770-78b2f8292bd2' and intakeservicerequestactorid = 'b24dce5f-989e-4559-8f95-8eb5e1f60f24';
