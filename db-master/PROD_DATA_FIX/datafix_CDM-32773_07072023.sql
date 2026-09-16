-- CDM-32773 - Removal in draft
/*
-- Issue Description: 
   User reuest to delete draft child removal is completed in error.

-- Case ID: 3112284
-- Client ID: 3507315 (MAKAYLA RACHELL LEE) - 1ae47da1-2647-4e26-abd6-9d7ee2ad1fef
-- Removal ID: 278602 - 2023-04-19 To Current - fdf114af-13c5-41a1-a67c-35211ac10d35

-- Category/ Module: Removal (Case Management) 
-- Root cause: User Error
-- Fix Provided: Datafix has been promoted to delete the requested draft child removal.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To delete the requested draft child removal (CDM-32773)
select removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag 
	from cjams.intakeservreqchildremoval
where removalid = 278602
	and activeflag = 1;
	
update cjams.intakeservreqchildremoval
set activeflag = 0,
	updatedby = 'CDM-32773',
	updatedon = now()
where removalid = 278602
	and activeflag = 1;
	
