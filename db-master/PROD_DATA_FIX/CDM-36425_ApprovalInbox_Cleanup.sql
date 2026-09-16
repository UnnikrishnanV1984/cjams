-- CDM-36425 
/* Issue Description:User request to clean approval inbox for given users

-- Intake case number: NA

-- Category/ Module: Approval Inbox

-- Root cause: User request to clean approval inbox for given users
-- Fix Provided: Datafix has been provided to inactivate routing records
-- Pull request# N/A

*/
--Notes: Inactivated routing records related to Approval Inbox only. There are some assessment approvals pending for these users, which are ignored.

--Angela English -- 
select * from routing where tosecurityusersid = 'c442053f-fe02-42f9-b05c-3054c3738f24' and activeflag = 1 and routingstatustypeid = 15;
UPDATE routing
	SET updatedby = 'CDM-36425', updatedon = now(), activeflag = 0
	WHERE routingid IN (
			'773b51f4-277d-45a8-b127-abb08a5fd408',
			'6ce2a4ab-c3c1-4a06-9a53-7415267d5163',
			'05f1e591-eb11-46c6-b900-12e43f20bd82');

--John Hawkins --
select * from routing where tosecurityusersid = '7915cfc4-37e7-4542-9ee8-b44923981301' and activeflag = 1 and routingstatustypeid = 15;
UPDATE routing
	SET updatedby = 'CDM-36425', updatedon = now(), activeflag = 0
	WHERE routingid IN (
			'ef308520-efd3-41b1-9419-f75e53046f59',
			'659a8537-a006-47a7-8025-43c95d86f42e',
			'2c5b178a-f060-4247-b705-cc98da7f9cf1');

--Keyandra Brisco -- 
select * from routing where tosecurityusersid = '95491808-ca84-489d-88fe-b1ebaab74937' and activeflag = 1 and routingstatustypeid = 15;
UPDATE routing
	SET updatedby = 'CDM-36425', updatedon = now(), activeflag = 0
	WHERE routingid IN (
			'cb13c94b-8a5a-4614-ad61-b3eb75d2de67',
			'd48ecbea-af95-4244-b05e-85af823de8a1',
			'1a6cd265-2da3-47af-8e4f-56cea0104a3a',
			'09138826-f620-4973-aab5-a6b4f924bb7c',
			'23a9be41-edd6-4347-852b-2cd06655bf50',
			'35157908-1972-44f0-ab9b-b10d33c3f85a',
			'f1d0701a-4262-4454-b490-ddc9619e9a06');

--Norita Prather -- 
select * from routing where tosecurityusersid = '0488ac0f-02bc-42a7-855b-5c23b4126730' and activeflag = 1 and routingstatustypeid = 15;
UPDATE routing
	SET updatedby = 'CDM-36425', updatedon = now(), activeflag = 0
	WHERE routingid IN ('e35bcf6e-88af-44da-86eb-da8c78861905');