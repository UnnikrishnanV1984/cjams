/*
   Issue Description: CDM-15519
   Category/ Module  :  merged person issue
   Root cause: since merged merson and existing person are on the same case, duplicate roles we created.
   Pull request# for code fix: 
   Reason why no related code fix: 
   this is a defect raised from person merge 
*/

update intakeservicerequestactor 
set activeflag = 0,
updatedby = 'CDM-15519',
updatedon = now()
where intakeservicerequestactorid = 'a7c91b6b-2704-4a9f-912a-62f08cd3ce46';


update personrole p 
set activeflag = 0,
updatedby = 'CDM-15519',
updatedon = now()
where personid = '1fef85b9-6c82-4530-be3e-f1045e6a7b4d'
and intakeserviceid = '13cfde03-6e84-4f9e-9012-3e0d14f3e8c8'
and ishouseholdmember = 2;