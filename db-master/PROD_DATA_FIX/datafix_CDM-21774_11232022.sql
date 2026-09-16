-- CDM-21774 - Missing client
/*
-- Issue Description: 
   User request to delete the child removal of Duplicate Client Client 1872133 Kayla Duplicate Ellison. 

-- Client ID: 1872133 (KAYLA duplicate ELLISON) - d36c5231-f113-412a-8d69-023d31c739f7
-- Removal ID: 252715 - 2021-09-09 To Null - 15332d25-e647-41cf-aac7-cb885f920fa2
 
-- Category/ Module: Removal (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to close and delete the removal/OOH/Placement/IV-E of the deleted duplicate client
-- Update Removal
select removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag 
	from cjams.intakeservreqchildremoval
where removalid = 252715
	and activeflag = 1 ;
	
update cjams.intakeservreqchildremoval
set exitdate = removaldate,
	activeflag = 0, 
	updatedby = 'CDM-21774',
	updatedon = now()
where removalid = 252715
	and activeflag = 1 ;
	
-- No OOH, IV-E and Rount Data 

