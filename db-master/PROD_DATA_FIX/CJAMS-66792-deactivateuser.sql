
/*
Issue:Dashboard:Offboarded User still appearing in workload
Root Cause:Angela Hoyman is deactivated in sailpoint, so requested for  a datafix to deactivate the user in cjams db
Fix Provided (Data Fix Only):Data fix was done to deactivate user from cjams.
Data/Code fix ticket#: CJAMS-66792
Regression Impacts: N/A 
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/

update userprofile
set activeflag = 0,updatedby='CJAMS-66792',updatedon=now()
where securityusersid = '3a9491d1-acde-4f67-9bf7-d260738e4494' and activeflag=1;

update muser set activeflag = 0,updatedby='CJAMS-66792',updatedon=now()
where securityusersid  in ('3a9491d1-acde-4f67-9bf7-d260738e4494') and activeflag=1;

update cjams.securityusers set activeflag=0, updatedby='CJAMS-66792', updatedon=now()  
where securityusersid in ('3a9491d1-acde-4f67-9bf7-d260738e4494') and activeflag =1;

update teammember set activeflag = 0, updatedby = 'CJAMS-66792', updatedon = now()
where teammemberid in (select teammemberid from teammemberassignment where securityusersid in ('3a9491d1-acde-4f67-9bf7-d260738e4494') and activeflag=1) 
and activeflag = 1;

update cjams.teammemberassignment set activeflag=0, updatedby='CJAMS-66792', updatedon=now() 
where securityusersid in('3a9491d1-acde-4f67-9bf7-d260738e4494') and activeflag =1;

update rolemapping set activeflag = 0,updatedby='CJAMS-66792',updatedon=now()
where id in('54874707') and activeflag = 1;

--no records
--update userresource set activeflag = 0,updatedby='CJAMS-66792',updatedon=now()
--where userid in ('54874707') and activeflag = 1;