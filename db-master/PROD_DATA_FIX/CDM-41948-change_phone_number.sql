/* 
   Issue Description: CDM-41948
   Category/ Module  : Assignments
   Root cause: User RequestUser request to update the phonenumber because The listed phone number under “Signed in Worker: Natalie Watkins”, should be 410-858-6874, not the number listed.
   Pull request# for code fix: N/A
   Reason why no related code fix: N/A
   Status of the code fix if already submitted and expected prod fix date: N/A
    
*/
/*
select userprofilephonenumberid,* from userprofilephonenumber u where securityusersid ='54e3a2c7-6bef-4763-98c3-7fd943c3d4d1';
select * from v_userprofile vu where securityusersid ='54e3a2c7-6bef-4763-98c3-7fd943c3d4d1';
*/

update userprofilephonenumber 
set phonenumber = '410-858-6874',
	updatedby = 'CDM-41948',
	updatedon = now()
where userprofilephonenumberid = '3d992e62-7470-4f93-a591-7dbbd0c75baa'
and activeflag = 1;

/*
select * from tb_slpa_snapshot where  worker_staff_id  = '203322352'
*/