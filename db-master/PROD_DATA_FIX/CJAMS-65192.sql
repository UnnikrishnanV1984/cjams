
/*
-- Issue Description: There are 3 person card added for the same client. Need to remove the duplicate.

-- Category/ Module: Placement and Living Arrangement
-- Root cause: User error.  
-- Fix Provided: Datafix has been promoted to soft delete the duplicate person cards.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/
update cjams.actor 
	set activeflag = 0, 
		updatedon = now(), 
		updatedby = 'CJAMS-65192'
	where actorid in ('b13d2c28-39dd-4ba7-b02a-75629ccfff2e','187105a2-3183-4b7a-8776-fb2ea90046d0')
	and activeflag = 1;

update cjams.intakeservicerequestactor 
	set activeflag =0,
		updatedon = now(),
		updatedby = 'CJAMS-65192'
	where intakeservicerequestactorid in ('5bcfd2e7-bed1-4502-9f58-df28af017b36','647204c9-abd6-44db-8bae-1af4dbfb3b53',
'e02ab564-a8a9-4938-899c-fbe8eea14106',
'3e922faf-37a3-4911-9624-ff25dcb63e0c');

	
	
update cjams.personprogramarea 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CJAMS-65192'
	where personid IN('0c5889b0-0ad8-4043-a896-d2952ccfb4fa','1d9976dc-c5ce-406f-9192-87fb62dcff60') 
		and objectid = 'ea617180-bb98-4aed-a8c9-e7fa64cdd8a1'
		and activeflag = 1;

		
update cjams.actorrelationship 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CJAMS-65192'
	where intakeservicerequestactorid in ('5bcfd2e7-bed1-4502-9f58-df28af017b36','647204c9-abd6-44db-8bae-1af4dbfb3b53',
'e02ab564-a8a9-4938-899c-fbe8eea14106',
'3e922faf-37a3-4911-9624-ff25dcb63e0c')
and activeflag = 1;