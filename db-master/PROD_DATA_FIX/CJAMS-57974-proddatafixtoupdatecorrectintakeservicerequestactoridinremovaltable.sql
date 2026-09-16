/*
   Issue Description: CJAMS-57974
   Category/ Module  : Prod data fix to update correct intakeservicerequest actor records
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



-- ae264fe1-bba7-4f11-b2e4-bdd8df576169
update intakeservreqchildremoval set intakeservicerequestactorid = '13d0a409-693c-489c-837d-e59c8dcd7b2f', updatedby = 'CJAMS-57974', updatedon = now() where intakeservreqchildremovalid in ('087b5e43-61c4-4732-b52a-fa743081340f',
'0d5444b8-7d01-44ca-9c98-76b5468ae573','9202c985-30ac-4e8a-aee3-f5effa40ac19') and intakeservicerequestactorid = 'ae264fe1-bba7-4f11-b2e4-bdd8df576169';
