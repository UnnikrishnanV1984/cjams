/*
   Issue Description: CDM-22071
   Category/ Module  : 3265490: Nanette R WIlliams was put into this case in error. It needs to be removed.
   Root cause: user wants to delete the contact note
*/

update 	cjams.actor 
set 	activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-22071'
where 	personid = 'bb3b0748-43fc-40bb-a22b-efd34727cb60' 
        and servicecaseid = 'adc545c2-836a-446f-88e8-a0a63156e1c5' 
        and activeflag = 1;

update 	cjams.intakeservicerequestactor
set 	activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-22071'
where 	personid = 'bb3b0748-43fc-40bb-a22b-efd34727cb60' 
        and servicecaseid = 'adc545c2-836a-446f-88e8-a0a63156e1c5' 
        and activeflag = 1;


update 	cjams.personrole   
set 	activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-22071'
where 	personid = 'bb3b0748-43fc-40bb-a22b-efd34727cb60' 
        and servicecaseid = 'adc545c2-836a-446f-88e8-a0a63156e1c5' 
        and activeflag = 1;


update 	cjams.actorrelationship  
set 	activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-22071'
where 	activeflag = 1 
        and intakeservicerequestactorid in 
        (select i.intakeservicerequestactorid 
        from    intakeservicerequestactor i 
        where   i.personid = 'bb3b0748-43fc-40bb-a22b-efd34727cb60' 
                and i.servicecaseid = 'adc545c2-836a-446f-88e8-a0a63156e1c5');
