/*
   Issue Description: CDM-40336
   Category/ Module  :  person card removal
   Root cause: user wants to rename the person and remove the person from case
   Fix Provided: Did data fix to remove person card  
*/

update person
set dob='1964-03-08 00:00:00',firstname='LAVERNE',lastname='HARRIS',updatedby='CDM-40336',updatedon=now()
where personid='5551c7c2-5de6-40ef-a3c7-0f651cfe4313' and activeflag=1;

update personrole
set activeflag=0,updatedby='CDM-40336',updatedon=now()
where personid='5551c7c2-5de6-40ef-a3c7-0f651cfe4313' and intakeserviceid='6c3f08f0-1d1e-4f18-bf69-1d66ff699f20' and activeflag=1;

update personroletype
set activeflag=0,updatedby='CDM-40336',updatedon=now()
where personroleid in (select personroleid 
                               from personrole 
                               where personid='5551c7c2-5de6-40ef-a3c7-0f651cfe4313' and intakeserviceid='6c3f08f0-1d1e-4f18-bf69-1d66ff699f20' ) and activeflag=1;

update actor
set activeflag=0,updatedby='CDM-40336',updatedon=now()
where personid = '5551c7c2-5de6-40ef-a3c7-0f651cfe4313' and intakeserviceid = '6c3f08f0-1d1e-4f18-bf69-1d66ff699f20' and activeflag=1;

update actorrelationship
set activeflag=0,updatedby='CDM-40336',updatedon=now()
where intakeservicerequestactorid in (select intakeservicerequestactorid
			from intakeservicerequestactor
		where personid = '5551c7c2-5de6-40ef-a3c7-0f651cfe4313'
			and intakeserviceid = '6c3f08f0-1d1e-4f18-bf69-1d66ff699f20') and activeflag=1;

update intakeservicerequestactor
set activeflag=0,updatedby='CDM-40336',updatedon=now()
where personid = '5551c7c2-5de6-40ef-a3c7-0f651cfe4313' and intakeserviceid = '6c3f08f0-1d1e-4f18-bf69-1d66ff699f20' and activeflag=1;



