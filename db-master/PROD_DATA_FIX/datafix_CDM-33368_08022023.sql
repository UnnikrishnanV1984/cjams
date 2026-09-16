-- CDM-33368 - Removal created in error
/*
-- Issue Description: 
   User reuest to delete draft child removal is completed in error.

-- Case ID: 3164581
-- Client ID: 201413496	(Kinnard Woodrum) - bde11c26-9d80-49ad-9a05-e93f6ef48023
-- Removal ID: 281325 - 2023-07-31 To current - b457900c-7b83-4f65-8e8f-9f2fc2b883ab -- Review

-- Category/ Module: Removal (Case Management) 
-- Root cause: User Error
-- Fix Provided: Datafix has been promoted to delete the requested child removal.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To delete the requested child removal (CDM-33368)
select removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag 
	from cjams.intakeservreqchildremoval
where removalid = 281325
	and activeflag = 1;
	
update cjams.intakeservreqchildremoval
set activeflag = 0,
	updatedby = 'CDM-33368',
	updatedon = now()
where removalid = 281325
	and activeflag = 1;
	
select removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag 
	from cjams.intakeservreqchildremoval_history
where removalid = 281325
	and activeflag = 1;
	
update cjams.intakeservreqchildremoval_history	
set activeflag = 0,
	updatedby = 'CDM-33368',
	updatedon = now()
where removalid = 281325
	and activeflag = 1;
	
select eventcode, routingstatustypeid, activeflag, updatedby, updatedon 
	from routing
where objectid = 'b457900c-7b83-4f65-8e8f-9f2fc2b883ab'
	and activeflag = 1; 	
	
update routing
set activeflag = 0,
	updatedby = 'CDM-33368',
	updatedon = now()
where objectid = 'b457900c-7b83-4f65-8e8f-9f2fc2b883ab'
	and activeflag = 1; 	
	