/*
   Issue Description: CDM-30178-end-date
   Category/ Module  : end date
   Root cause: Case shows pending in approval box
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakeservreqchildremoval set exitdate = null, 
updatedby = 'CDM-30178', updatedon = now() ,
returndate = Null,
returntime = Null,
removalexitreason = NULL
where intakeservreqchildremovalid='561c0f90-a464-476d-a3c1-454be9ea2732'
and activeflag = 1 ;
	
-- Update OOH

update cjams.personprogramarea 
set enddate = Null, 
	updatedby = 'CDM-30178',
	updatedon = now()
where personprogramid in ('7af527f9-4531-485b-bfad-3144b3ada957','a09c7d78-1965-4189-b789-245cfd207cae')
and activeflag = 1 ;
	
-- Update Eligibility

update cjams.tb_client_eligibility
set end_dt = Null,
	update_user_id = 'CDM-30178',
	update_ts = now()
where removal_id = 186181
	and delete_sw = 'N' ;