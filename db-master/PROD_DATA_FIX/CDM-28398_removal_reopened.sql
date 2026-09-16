/*
   Issue Description: CDM-28398
   Category/ Module  : Removal Reopened
   Root cause::Removal and case were closed before we were able to add the placement for Pre Finalized home and the Breaking of the link for the child's subsidy to start.
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/


	
update cjams.intakeservreqchildremoval
set exitdate = Null,
	returndate = Null,
	returntime = Null,
	removalexitreason = NULL,
	updatedby = 'CDM-28398',
	updatedon = now()
where removalid = 194442
	and activeflag = 1 ;
	
-- Update OOH


update cjams.personprogramarea 
set enddate = Null, 
	updatedby = 'CDM-28398',
	updatedon = now()
where personprogramid = '76779406-e0f4-402b-b188-513dd0317e59'
	and activeflag = 1 ;
	
-- Update Eligibility


update cjams.tb_client_eligibility
set end_dt = Null,
	update_user_id = 'CDM-28398',
	update_ts = now()
where removal_id = 194442
	and delete_sw = 'N' ;