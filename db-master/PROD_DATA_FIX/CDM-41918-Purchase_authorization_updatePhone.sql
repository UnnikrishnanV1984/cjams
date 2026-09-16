
/* 
   Issue Description: CDM-41918
   Category/ Module  : Assignments
   Root cause: User Request (handle null values)
   Pull request# for code fix: N/A
   Reason why no related code fix: N/A
   Status of the code fix if already submitted and expected prod fix date: N/A
    
*/

/*
select * from userprofilephonenumber where securityusersid = 'd5ccb914-fc10-4cfc-a709-aa98f9228b66';
*/

update userprofilephonenumber 
set phonenumber = '410-980-9932',
	updatedby = 'CDM-41918',
	updatedon = now()
where userprofilephonenumberid = '6376ce5b-08c9-49f3-91e7-bcdc74dfa4d5'
and activeflag = 1;

/*
select * from tb_slpa_snapshot where  worker_staff_id  = '201183930'
worker_name = 'Sarah Bevins' and worker_phone = '443-510-5553';
*/

update tb_slpa_snapshot
set requestor_phone ='410-980-9932',
	update_user_id='CDM-41918',
	update_ts=now()
where  worker_staff_id  = '201183930' 
and worker_name = 'Sarah Bevins' 
and requestor_phone  = '443-510-5553';