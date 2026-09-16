/*
   Issue Description: CDM-31161
   Category/ Module  : child removal 
   Root cause: user requested 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update cjams.intakeservreqchildremoval
set exitdate = Null,
	returndate = Null,
	returntime = Null,
	removalexitreason = NULL,
	updatedby = 'CDM-31161',
	updatedon = now()
where removalid = 250688
	and activeflag = 1 ;


update cjams.personprogramarea 
set enddate = Null, 
	updatedby = 'CDM-31161',
	updatedon = now()
where personprogramid = '3dfd3bcd-750a-49ff-83d3-916e09da3303'
	and activeflag = 1 ;


update cjams.tb_client_eligibility
set end_dt = Null,
	update_user_id = 'CDM-31161',
	update_ts = now()
where removal_id =  250688
	and delete_sw = 'N' ;