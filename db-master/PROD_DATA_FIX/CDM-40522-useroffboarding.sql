
/*
  Issue Description:CDM-40522 Terminated Worker.
  Category/ Module : user management
  Root cause: Users are still active in tables
  Pull request# for code fix: 
  Reason why no related code fix:
  Status of the code fix if already submitted and expected prod fix date:
   Backup before update/ delete: 1
*/
-- email:'rosa.barrientos@montgomerycountymd.gov'
-- id : 4843

update userprofile set activeflag = 0, updatedby = 'CDM-40522', updatedon = now() 
where email in ('rosa.barrientos@montgomerycountymd.gov') and activeflag = 1;

update muser set activeflag = 0, updatedby = 'CDM-40522', updatedon = now() 
where email in ('rosa.barrientos@montgomerycountymd.gov') and activeflag = 1;

update cjams.securityusers set activeflag=0, updatedby='CDM-40522', updatedon=now()  
where securityusersid in (select securityusersid from userprofile where 
email in ('rosa.barrientos@montgomerycountymd.gov')) and activeflag = 1;

update teammember set activeflag=0, updatedby='CDM-40522', updatedon=now() 
where teammemberid in (select teammemberid from cjams.teammemberassignment 
where securityusersid in (select securityusersid from userprofile where 
email in ('rosa.barrientos@montgomerycountymd.gov')) and activeflag = 1) and activeflag = 1;

update cjams.teammemberassignment set activeflag=0, updatedby='CDM-40522', updatedon=now() 
where securityusersid in (select securityusersid from userprofile where 
email in ('rosa.barrientos@montgomerycountymd.gov')) and activeflag = 1;

update rolemapping set activeflag = 0, updatedby = 'CDM-40522', updatedon = now() 
where principalid in (select id::varchar from muser where 
email in ('rosa.barrientos@montgomerycountymd.gov')) and activeflag = 1;

update userresource set activeflag = 0, updatedby = 'CDM-40522', updatedon = now() 
where userid in (select id from muser where 
email in ('rosa.barrientos@montgomerycountymd.gov')) and activeflag = 1;

---- update supervisor id from rosa.barrientos@montgomerycountymd.gov to rosa.joppy@montgomerycountymd.gov

update userprofile set supervisorid = '41d2c97d-a7fd-404d-a659-b34392ddcb21', updatedby = 'CDM-40522', updatedon = now() 
where supervisorid in ('e2842f9c-7cd1-4570-ae01-dc431596e4e9') and activeflag = 1; 



