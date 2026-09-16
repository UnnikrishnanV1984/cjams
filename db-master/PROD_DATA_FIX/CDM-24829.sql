/*
  Issue Description: CDM-24829 CJAMS - Terminated Employees Present
   Category/ Module  :  user management
   Root cause: User is deactivated in sailpoint and but active in DB
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 1
*/

/*email : 
harry.martin@maryland.gov
maiyah.rose@maryland.gov
helen-marie.robertson@maryland.gov
*/

update userprofile 
set activeflag=0,updatedon=now(), updatedby = 'CDM-24829'
where securityusersid in ('0e3a68b6-442e-4af2-ba0d-5c6bd4bd547e',
'15c74fd8-aac0-4459-8120-974011e8d6c9',
'02f38df0-dce9-4e6a-9745-60eb6ecbe30d');


update muser 
set activeflag=0,updatedon=now(), updatedby = 'CDM-24829'
where securityusersid in ('0e3a68b6-442e-4af2-ba0d-5c6bd4bd547e',
'15c74fd8-aac0-4459-8120-974011e8d6c9',
'02f38df0-dce9-4e6a-9745-60eb6ecbe30d');


update rolemapping
set activeflag = 0, updatedby = 'CDM-24829', updatedon = now() 
where principalid in ('13465','10046','12916') and activeflag = 1;

update userresource
set activeflag = 0, updatedby = 'CDM-24829', updatedon = now() 
where userid in (13465,10046,12916) and activeflag = 1;

update teammemberassignment 
set activeflag =0, updatedby = 'CDM-24829', updatedon = now() 
where securityusersid in ('0e3a68b6-442e-4af2-ba0d-5c6bd4bd547e',
'15c74fd8-aac0-4459-8120-974011e8d6c9',
'02f38df0-dce9-4e6a-9745-60eb6ecbe30d') and activeflag = 1;

update securityusers 
set activeflag =0, updatedby = 'CDM-24829', updatedon = now() 
where securityusersid in ('0e3a68b6-442e-4af2-ba0d-5c6bd4bd547e',
'15c74fd8-aac0-4459-8120-974011e8d6c9',
'02f38df0-dce9-4e6a-9745-60eb6ecbe30d') and activeflag = 1;