
/*
Issue:Dashboard:Offboarded worker - Leah Smith is still showing up under her former Supervisor - Michelle Jones
Root Cause:Please deactivate user in cjams db. all 3 profiles are inactive for the user in sailpoint.
Fix Provided (Data Fix Only):Data fix was done to deactivate user from cjams db.
Data/Code fix ticket#: CJAMS-67304
Regression Impacts: N/A 
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/


update userprofile
set activeflag = 0,updatedby='CJAMS-67304',updatedon=now()
where securityusersid = '53702afe-5e42-45d5-aa40-9d1253fe2dc4' and activeflag=1;


update muser set activeflag = 0,updatedby='CJAMS-67304',updatedon=now()
where securityusersid ='53702afe-5e42-45d5-aa40-9d1253fe2dc4' and activeflag=1;

update cjams.securityusers set activeflag=0, updatedby='CJAMS-67304', updatedon=now()  
where securityusersid ='53702afe-5e42-45d5-aa40-9d1253fe2dc4' and activeflag =1;


update teammember set activeflag = 0, updatedby = 'CJAMS-67304', updatedon = now()
where teammemberid in (select teammemberid from teammemberassignment where securityusersid='53702afe-5e42-45d5-aa40-9d1253fe2dc4' and activeflag=1) 
and activeflag = 1;


update cjams.teammemberassignment set activeflag=0, updatedby='CJAMS-67304', updatedon=now() 
where securityusersid = '53702afe-5e42-45d5-aa40-9d1253fe2dc4' and activeflag =1;


update rolemapping set activeflag = 0,updatedby='CJAMS-67304',updatedon=now()
where principalid='50871' and id='180662300' and activeflag = 1;


update userprofileaddress set activeflag = 0, updatedby = 'CJAMS-67304', updatedon = now() 
where securityusersid='53702afe-5e42-45d5-aa40-9d1253fe2dc4' and activeflag=1;
