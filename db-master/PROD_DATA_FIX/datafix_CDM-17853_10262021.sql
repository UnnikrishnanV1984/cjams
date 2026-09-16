-- CDM-17853 - Child Removal
/*
-- Issue Description: 
   Child removal created in Investigation did not transfer over to the service case #3297534
   
-- CPS-IR ID: 211020152242 - 129e7951-372b-4edb-a4b0-645ee04337f4
-- Case ID: 3297534 - 900af3ac-b2e7-49d7-b018-8e7510806120
-- Removal ID: 252962 - 2021-10-25 To Current - ec3c4a58-6858-48b0-b653-47fb0bc21188
    
-- Category/ Module: Removal (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to update service case id in Removal table
select intakeservreqchildremovalid, removaldate, exitdate, intakeserviceid, 
	servicecaseid, updatedby, updatedon, activeflag
from cjams.intakeservreqchildremoval
where removalid = 252962
	and servicecaseid is null 
	and activeflag = 1 ;
	
update cjams.intakeservreqchildremoval
set servicecaseid = '900af3ac-b2e7-49d7-b018-8e7510806120',
	updatedby = 'CDM-17853',
	updatedon = now()
where removalid = 252962
	and servicecaseid is null 
	and activeflag = 1 ;
	
-- Soft-delete draft removal
select intakeservreqchildremovalid, removaldate, exitdate, intakeserviceid, 
	servicecaseid, updatedby, updatedon, activeflag
from cjams.intakeservreqchildremoval
where removalid = 252964
	and activeflag = 1 ;
	
update cjams.intakeservreqchildremoval
set activeflag = 0,
	updatedby = 'CDM-17853',
	updatedon = now()
where removalid = 252964
	and activeflag = 1 ;
