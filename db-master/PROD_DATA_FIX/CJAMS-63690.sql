
/*
Issue:Dashboard:Please delete user/supervisor Shondelle Johnson-Pugh from Child welfare and provider side. SHe was off boarded but continues to populate.
Root Cause:Please do a datafix to deactivate the user in cjams db. Both profiles are inactive in sailpoint.
Fix Provided (Data Fix Only):Data fix was done to deactivate user from cjams db.
Data/Code fix ticket#: CJAMS-63690
Regression Impacts: N/A 
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/

update userprofile
set activeflag = 0,updatedby='CJAMS-63690',updatedon=now()
where securityusersid = 'b5b6357a-9742-441c-936e-65a3f737f152' and activeflag=1;


update muser set activeflag = 0,updatedby='CJAMS-63690',updatedon=now()
where securityusersid ='b5b6357a-9742-441c-936e-65a3f737f152' and activeflag=1;

update cjams.securityusers set activeflag=0, updatedby='CJAMS-63690', updatedon=now()  
where securityusersid ='b5b6357a-9742-441c-936e-65a3f737f152' and activeflag =1;


update teammember set activeflag = 0, updatedby = 'CJAMS-63690', updatedon = now()
where teammemberid in (select teammemberid from teammemberassignment where securityusersid='b5b6357a-9742-441c-936e-65a3f737f152' and activeflag=1) 
and activeflag = 1;


update cjams.teammemberassignment set activeflag=0, updatedby='CJAMS-63690', updatedon=now() 
where securityusersid = 'b5b6357a-9742-441c-936e-65a3f737f152' and activeflag =1;


update rolemapping set activeflag = 0,updatedby='CJAMS-63690',updatedon=now()
where principalid='16486' and id in ('114103709','108650803','176672693') and activeflag = 1;


update userprofileaddress set activeflag = 0, updatedby = 'CJAMS-63690', updatedon = now() 
where securityusersid='b5b6357a-9742-441c-936e-65a3f737f152' and activeflag=1;

update teammember set activeflag = 0, updatedby = 'CJAMS-63690', updatedon = now()
where teammemberid in (select teammemberid from as_teammemberassignment where securityusersid='b5b6357a-9742-441c-936e-65a3f737f152' and activeflag=1) 
and activeflag = 1;

update cjams.as_teammemberassignment set activeflag=0, updatedby='CJAMS-63690', updatedon=now() 
where securityusersid = 'b5b6357a-9742-441c-936e-65a3f737f152' and activeflag =1;
