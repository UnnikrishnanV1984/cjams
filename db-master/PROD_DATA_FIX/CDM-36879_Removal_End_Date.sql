-- CDM-36879 - Remove end date
/*
-- Category/ Module: Child Removal 
-- Root cause: User Error
-- Fix Provided: Datafix has been done as requested by user
--						Remove the Child End Date 
--						Living arrangement Exit type to Change of Placement
--						Reason for Exit to Other
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update intakeservreqchildremoval 
	set exitdate = null,
		returntransts= null,
		removalexitreason = null,
		updatedby ='CDM-36879',
		updatedon =now() 
	where intakeservreqchildremovalid ='fda1b47e-ee32-4b2d-bfab-94bfe20b2fcf';

update personprogramarea
	set enddate = null,
		updatedby ='CDM-36879',
		updatedon =now()
	where personprogramid='f12611ca-deb9-48c7-89d4-4fd32c00f63c';

update tb_client_eligibility
	set end_dt = null,
		update_user_id = 'CDM-36879',
		update_ts = now()
	where removal_id = '293712';

update placement
	set exittypekey = 'CPL',
		exitreasontypekey = 'OTHER', 
		enddatetime = null,
		endtime = null,
		updatedby ='CDM-36879',
		updatedon =now() 
	where placementid ='243ecad1-8a37-435f-9722-273cbf20a718';

