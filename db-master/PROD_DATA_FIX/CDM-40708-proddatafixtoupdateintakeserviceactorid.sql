/*
   Issue Description: CDM-40708
   Category/ Module  : Prod data fix to update with active intakeservicerequestactorid
   Root cause: Adoption planning is having inactive intakeservicerequestactorid record
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



-- d4e6f9ca-8afd-4b5c-8d23-6bfc55f2aa7b
update adoptionplanning set intakeservicerequestactorid = 'c6be9f79-1d28-4dfb-bee9-aeb965931f1e', updatedon = now(), updatedby = 'CDM-40708'
where adoptionplanningid = '5bd56d26-ebc8-4aad-bce5-c5146a2c04a5';
                
-- 40770d9d-9784-4da8-800b-ae0cb9253ae9
update adoptionplanning set intakeservicerequestactorid = 'd4d4c643-e6ea-4b69-a9f1-8bcbd6a08e63', updatedon = now(), updatedby = 'CDM-40708'
where adoptionplanningid = '84677f8e-3d21-485c-8f27-50d2ab0373e9';