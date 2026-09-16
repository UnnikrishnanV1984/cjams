/*
   Issue Description: CDM-25331
   Category/ Module  : Persons
   Rootcause: Before applying the datafix of CDM-25173 , the user created another person to the case. On top of this, the datafix applied,
                thus duplicate clients appear in the case
    Fix: deleting the duplicate clients from the case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

select 	isprimary , activeflag, intakeservicerequestactorid, *
from 	intakeservicerequestactor 
where 	intakeservicerequestactorid in ('9f51cd48-280f-4bc6-a63a-37943bbc55d5', '8abe7dcb-9f98-4333-b3d6-f379c82ab17f', '7d83b5f2-e26c-4e65-b96b-13d386bfd51f'); 
	
update 	intakeservicerequestactor 
set 	isprimary = false,
		activeflag = 0,
		updatedby = 'CDM-25331',
		updatedon = now()
where 	intakeservicerequestactorid in ('9f51cd48-280f-4bc6-a63a-37943bbc55d5', '8abe7dcb-9f98-4333-b3d6-f379c82ab17f', '7d83b5f2-e26c-4e65-b96b-13d386bfd51f');

