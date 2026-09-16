-- CDM-33396 - Initial Contact Timer
/*
-- Issue Description: 
   Initial contact has been completed within required timeframe. 
   Timer continues to count despite household and others being seen timely.
   
-- CPS-AR: 231020791505 - b055eb2e-69c4-4dba-9a9d-2c5c5e27b00c

-- Category/ Module: Case Management
-- Root cause: User error for answering the below question:
	"Was this child an active member of the household at the start of the case but not included on the referral?"

	Also, the code is having flaw for the scenario when all other children are NOT part of the initial response, 
	CJAMS is not identifying that NO contact is needed for other children.
-- Fix Provided: Datafix has been promoted to update the answers as Yes for 2 children in this case.
	and Code fix has been promoted to handle the scenario when all other children are NOT part of the initial response.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To update initialresponse as Yes (CDM-33396)
-- Client ID: 200147071	(Aria Bell) - 856b872c-f1ee-4d8a-b044-9148ca4df4cf
-- personroleid: e7e332ed-f528-474a-bc08-fd0d7a755a51

-- Client ID: 200147072	(Jonathan Bell) - 4bad5cd0-3d7d-443f-9c68-461000b5c7c0
-- personroleid: 2f8c02a7-d3ad-4177-83d5-c22c2f990317

select personroleid, personid, initialresponse, updatedby, updatedon  
	from personrole 
where personroleid in ( 'e7e332ed-f528-474a-bc08-fd0d7a755a51', '2f8c02a7-d3ad-4177-83d5-c22c2f990317' )
	and activeflag  = 1
	and initialresponse = 0 ;

update personrole
set initialresponse = 1,
	updatedby = 'CDM-33396', 
	updatedon = now()
where personroleid in ( 'e7e332ed-f528-474a-bc08-fd0d7a755a51', '2f8c02a7-d3ad-4177-83d5-c22c2f990317' )
	and activeflag  = 1
	and initialresponse = 0 ;
	
-- To Stop the timer
-- Before 
select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = '231020791505'
	and activeflag = 1 ;

select * 
from cjams.cpsresponsetimerupdate( 'b055eb2e-69c4-4dba-9a9d-2c5c5e27b00c'::uuid, 'CDM-33396'::character varying ) ;
		
-- After
select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = '231020791505'
	and activeflag = 1 ;
		
		
-- To Stop the timer		
-- CPS-IR : 231020569366 - 09ba3593-7d17-49ac-8f8b-290593f8e215		
-- Before 
select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = '231020569366'
	and activeflag = 1 ;

select * 
from cjams.cpsresponsetimerupdate( '09ba3593-7d17-49ac-8f8b-290593f8e215'::uuid, 'CDM-33396'::character varying ) ;
		
-- After
select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = '231020569366'
	and activeflag = 1 ;
	