/*
   Issue Description: CDM-39485
   Category/ Module  : Child Removal
   Root cause: user wants to  remove end date to complete Gap process
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do only data fix
*/

update cjams.intakeservreqchildremoval
set exitdate = NULL,
	removalexitreason = NULL,
	returntransts = NULL,
	updatedby = 'CDM-34985',
	updatedon = now()
	where intakeservreqchildremovalid ='4b9426c7-8d41-49ac-b4f6-1ea816f042bb'
	and activeflag = 1 ;

update cjams.personprogramarea 
set enddate = NULL, 
	updatedby = 'CDM-34985',
	updatedon = now()
where personprogramid = '2a65207a-9a54-4f65-a1cb-8c9d332f394e'
	and activeflag = 1 ;


update cjams.tb_client_eligibility
set end_dt = NULL,
	update_user_id = 'CDM-34985',
	update_ts = now()
where removal_id =  251379
	and delete_sw = 'N' ;


