/*
-- Issue Description: 
  Delete the Child Removal - Draft version   
 
-- Category/ Module: Removal (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to delete n the Removal
-- Update Removal
select 	removalid, intakeservreqchildremovalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag 
from 	cjams.intakeservreqchildremoval
where 	removalid = 255242
		and activeflag = 1 ;
	
update 	cjams.intakeservreqchildremoval
set 	activeflag = 0,
		updatedby = 'CDM-27418',
		updatedon = now()
where 	removalid = 255242 
		and activeflag = 1;

select 	removalid, intakeservreqchildremovalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag 
from 	cjams.intakeservreqchildremoval
where 	removalid = 255243
		and activeflag = 1 ;
	
update 	cjams.intakeservreqchildremoval
set 	activeflag = 0,
		updatedby = 'CDM-27418',
		updatedon = now()
where 	removalid = 255243 
		and activeflag = 1;
