/*
  Issue Description: CJAMS-60388 251023078767:Customer Nalinai Crureton was incorrectly was placed in this case record. Child need to be removed out of this case
  Category/ Module : Persons
  Root cause: The child was added incorrectly in the case and intake. Data fix needed to remove the child from this intake and service case.
  Fix Provided: Data fix has been done to remove the child from intake and service case
  Regression Impacts: N/A
  Is Code fix needed: No
  Code fix ticket # : N/A
  Reason why no related code fix: Data entry error and data fix needed.
 */
 
--Removing person from intake and CPS-IR Case
update cjams.actor 
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CJAMS-60388'
where personid ='247106bc-b346-47c8-a85f-fdbd022d3d3d'
and intakeserviceid = '74bbb178-9704-42b0-be3e-8d156c5e6594';


update cjams.actor 
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CJAMS-60388'
where personid ='247106bc-b346-47c8-a85f-fdbd022d3d3d'
and intakenumber = 'I251013308438';




update cjams.intakeservicerequestactor  
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CJAMS-60388'
where intakeservicerequestactorid in ('3cc19e43-35c7-4662-ba84-e0c326163be2','7d7e9b7d-78af-4b8c-92a3-fd689b8427c5','038759a5-21e2-430c-ae71-cd25f1cd5f1c','c5b147b1-b5fb-4cf0-a11c-84ec6a26b269')
and activeflag=1;

update cjams.personrole   
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CJAMS-60388'
where personroleid  in ('8a1e2c21-d0b4-48fe-9731-4a5a512c2136','9dddf4fc-a7ac-42ec-8414-42c08cf7db09')
and activeflag=1;

update cjams.actorrelationship 
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CJAMS-60388'
where actorrelationshipid in ('461af216-9e7b-4622-9180-56f23991e69a', 'f0f55461-75ee-411d-a085-a3b81306a067', '80f9a529-cfab-4712-b14a-60530f867790', '88c032e1-926e-4f43-bccf-b289723171b0', '97f3afa2-41dc-4470-852c-70dd82a6999d','73b304f5-83d8-462c-88af-95020e33fc38', '60b5cb2a-0d1d-4d5f-a239-4e3d4a41c824', 'dd5300da-7f47-4461-89b2-7ec456e04cbe','1185de6b-b1a9-4b8e-96dd-ce7fbe8ccecf', '1699cfbf-353d-431f-9a38-002c5dcb1829', '6bf0eb43-3a97-412d-974e-2629032dae5a' )
and activeflag=1;


update personprogramarea 
SET activeflag = 0, 
	updatedon = now(), 
	updatedby = 'CJAMS-60388' 
where personprogramid = '53c55a61-5c43-4d0b-b7ba-21391934151e'
and activeflag=1;


update personroletype 
SET activeflag = 0, 
	updatedon = now(), 
	updatedby = 'CJAMS-60388' 
where personroleid in ('8a1e2c21-d0b4-48fe-9731-4a5a512c2136','9dddf4fc-a7ac-42ec-8414-42c08cf7db09')
and activeflag=1;