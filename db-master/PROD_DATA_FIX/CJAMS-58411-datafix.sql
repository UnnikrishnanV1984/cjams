/*
   Issue Description: CJAMS-58411
   Category/ Module  : Child Removal
   Root cause: User request to remove the child removal & OOH program assignment End Date
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update 	cjams.intakeservreqchildremoval
set 	exitdate = null,
		updatedby = 'CJAMS-58411',
		updatedon = now()
where 	intakeservreqchildremovalid = '62130df5-1ef5-4d71-86d7-7ee05924df39'
        and removalid = 254489
		and activeflag = 1 ;

        update 	cjams.personprogramarea 
set 	enddate = null, 
		updatedby = 'CJAMS-58411',
		updatedon = now()
where 	personid = 'e2161861-8e3f-4fba-a749-0be77ab162e1' and programkey = 'OOH'
		and personprogramid = '481dd7e5-3948-4e5f-8ff9-a3b9a998b5ae' and activeflag = 1 ;
	

update 	cjams.tb_client_eligibility
set 	end_dt = null,
		update_user_id = 'CJAMS-58411',
		update_ts = now()
where 	removal_id =  254489
		and delete_sw = 'N' ;