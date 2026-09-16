/*
   Issue Description: CDM-22236
   Category/ Module  : Child Removal
   Root cause: user wants to  correct end date
   Pull request# for code fix: 5611
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do only data fix
*/

update cjams.intakeservreqchildremoval 
set exitdate = '2021-10-07 00:00:00',
	removalexitreason = 'REUNIF',
	returntransts =  now(),
	updatedby = 'CDM-22236',
	updatedon = now()
where removalid = 200004
	and activeflag = 1	
	and exitdate is null ;	
	



update cjams.tb_client_eligibility
set end_dt = '2021-07-10',
	update_user_id = 'CDM-22236',
	update_ts = now()
where eligibility_id = 171549
	and delete_sw = 'N' ; 