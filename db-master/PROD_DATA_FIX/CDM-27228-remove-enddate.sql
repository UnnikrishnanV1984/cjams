/*
   Issue Description: CDM-27228
   Category/ Module  : Child Removal
   Root cause: user wants to  remove end date
   Pull request# for code fix: 7176
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do only data fix
*/

update cjams.intakeservreqchildremoval
set exitdate = NULL,
	removalexitreason = NULL,
	updatedby = 'CDM-23957',
	updatedon = now()
	where intakeservreqchildremovalid ='b3f11902-e9ea-4546-9d53-b7f114d51e53'
	and activeflag = 1 ;

update cjams.personprogramarea 
set enddate = NULL, 
	updatedby = 'CDM-27228',
	updatedon = now()
where personprogramid = 'd94ca381-654e-455c-8fdd-83fa7ff3d432'
	and activeflag = 1 ;


update cjams.tb_client_eligibility
set end_dt = NULL,
	update_user_id = 'CDM-27228',
	update_ts = now()
where removal_id =  253855
	and delete_sw = 'N' ;


