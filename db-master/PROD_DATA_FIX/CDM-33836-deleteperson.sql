/*
   Issue Description: CDM-33836
   Category/ Module  :  person
   Root cause: user wants to remove thewrong person from case
   Fix Provided: Did data fix to remove persons and personprogramareas  
*/

update intakeservicerequestactor
set activeflag = 0, updatedby = 'CDM-33836', updatedon = now()
where intakeservicerequestactorid ='fc1c4f4f-fc78-48ff-9663-f5531135a2c8' and  personid ='f392b4fa-ee5c-45ce-b6e1-5e12666ba9a5' and servicecaseid ='84cc8e7a-2439-486d-a81f-c9057eb1b585' and activeflag = 1;

--personrole
update personrole
set activeflag = 0,	updatedby = 'CDM-33836', updatedon = now()
where servicecaseid = '84cc8e7a-2439-486d-a81f-c9057eb1b585' and personid ='f392b4fa-ee5c-45ce-b6e1-5e12666ba9a5' and activeflag = 1 ;
    
update actor
set activeflag = 0,	updatedby = 'CDM-33836', updatedon = now()
where servicecaseid = '84cc8e7a-2439-486d-a81f-c9057eb1b585' and personid ='f392b4fa-ee5c-45ce-b6e1-5e12666ba9a5'and actorid ='98949baa-d047-441e-9d57-60e89d65b1f5' and activeflag = 1 ;

update actorrelationship
set activeflag = 0,	updatedby = 'CDM-33836', updatedon = now()
where intakeservicerequestactorid ='fc1c4f4f-fc78-48ff-9663-f5531135a2c8'
 and activeflag = 1;

UPDATE cjams.personprogramarea
SET activeflag = 0, updatedon = now(), updatedby = 'CDM-33836'
WHERE personprogramid ='eafb62a2-c93b-4d4f-9ac9-58ab978f3369';

