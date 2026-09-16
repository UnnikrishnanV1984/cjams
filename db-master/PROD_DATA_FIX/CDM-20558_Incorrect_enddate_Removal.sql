/*
-- CDM-20558 - 
-- Issue Description: Incorrect enddate removal 
-- Customer Email ID: veronica.stanton@maryland.gov
-- Closed  on:        02/05/2021 15:16:37
-- Pull request#: N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update Removal

select removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag ,personid
	from cjams.intakeservreqchildremoval
where removalid in (99140 ) ;


update cjams.intakeservreqchildremoval
set exitdate = '2021-02-05 11:00:00',
updatedby = 'CDM-20558',
 updatedon = now() 
where removalid in (99140 ) ;
