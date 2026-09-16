/*
   Issue Description: CDM-30775
   Category/ Module  : Persons need to be removed from case
   Reason why no related code fix: 
    requested a data fix to resolve
*/
update actor
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-30775'
where actorid ='682df94f-cfd7-4d85-b460-81238b43c362';

update intakeservicerequestactor i 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-30775'
where intakeservicerequestactorid= 'ad1b017b-9f9a-4f01-9f83-224dc990fe8f';

update personrole p  
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-30775'
where personroleid  = 'acc33a9c-c6c7-4fa9-8427-f3abf26b0bb3';

update cjams.actorrelationship a2 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-30775'
where actorrelationshipid ='bb6b95ea-e3e7-4100-8c50-3813e87bdcad';


update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-30775',
	updatedon = now()
where personid = '51ce7cf6-1ae2-45ac-af0f-7fe98571217f'
	and objectid = 'a7e3d6f8-9132-4771-9ca6-bc8b64262ccd' 
	and activeflag = 1 ;