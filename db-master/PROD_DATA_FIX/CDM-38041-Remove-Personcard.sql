/*
   Issue Description: CDM-38041
   Category/ Module  :  person card removal
   Root cause: user wants to remove the wrong person from case
   Fix Provided: Did data fix to remove person card  
*/

update intakeservicerequestactor
set activeflag = 0, updatedby = 'CDM-38041', updatedon = now()
where intakeservicerequestactorid ='a82d47b2-a035-44e6-8f91-73458df3f2b1' and  personid ='b583e5db-8de9-482d-87fc-dc94a8e54bf9' 
and intakeserviceid ='e83f96fe-36ce-4c1c-9a3e-5036a23efd6c' and activeflag = 1;


update  personroletype
set activeflag = 0,updatedby = 'CDM-38041',
	updatedon = now()
where activeflag = 1
and personroleid
in (select personroleid
from personrole
where intakeserviceid = 'e83f96fe-36ce-4c1c-9a3e-5036a23efd6c'
and personid ='b583e5db-8de9-482d-87fc-dc94a8e54bf9'
and activeflag = 1
);
--personrole
update personrole
set activeflag = 0,	updatedby = 'CDM-38041', updatedon = now()
where intakeserviceid = 'e83f96fe-36ce-4c1c-9a3e-5036a23efd6c' and personid ='b583e5db-8de9-482d-87fc-dc94a8e54bf9' and activeflag = 1 ;
    
update actor
set activeflag = 0,	updatedby = 'CDM-38041', updatedon = now()
   where intakeserviceid = 'e83f96fe-36ce-4c1c-9a3e-5036a23efd6c' and personid ='b583e5db-8de9-482d-87fc-dc94a8e54bf9'
and actorid ='3a4de749-1f70-4916-bf3e-7124b7a05e2f' and activeflag = 1;

update actorrelationship
set activeflag = 0,	updatedby = 'CDM-38041', updatedon = now()
where intakeservicerequestactorid ='a82d47b2-a035-44e6-8f91-73458df3f2b1' and activeflag = 1;
