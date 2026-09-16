/*
   Issue Description: CDM-39883
   Category/ Module  : Persons
   Root cause: user requested to remove the person in Household 
   Pull request# for code fix: 
   Reason why no related code fix: 
   requested a data fix to resolve:
*/

update intakeservicerequestactor
set activeflag = 0, updatedby = 'CDM-39883', updatedon = now()
where intakeservicerequestactorid ='f78e2c66-768d-400f-ae86-36a6d863eb8f' and personid = '69d0eb63-2bd2-4277-989e-af1150b3758e'
and activeflag = 1;

update personrole
set activeflag = 0, updatedby = 'CDM-39883', updatedon = now()
where personid = '69d0eb63-2bd2-4277-989e-af1150b3758e' and servicecaseid = '8cce42b3-9042-43b5-ae32-f30123bc9392' and activeflag = 1 ;
    
update actor
set activeflag = 0, updatedby = 'CDM-39883', updatedon = now()
where personid ='309a4149-9a2b-45d3-8033-16251e6e0ce7'
and actorid = 'c19703cd-7616-4bd4-a41d-b1261f05bd11' and activeflag = 1 ;

update actorrelationship
set activeflag = 0, updatedby = 'CDM-39883', updatedon = now()
where intakeservicerequestactorid ='f78e2c66-768d-400f-ae86-36a6d863eb8f' and activeflag = 1;

update personroletype set activeflag = 0, 
updatedby = 'CDM-39883', updatedon = now() 
where personroleid = '901d53aa-22da-49e6-896d-9867c7d7c4e2' and personroletypeid = '4294f879-3132-4f5c-ad5e-199724d9900b' and activeflag = 1;

