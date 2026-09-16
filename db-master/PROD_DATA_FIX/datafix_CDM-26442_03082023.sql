/*
   Issue Description: CDM-26442 - charmaine.d'monte@montgomerycountymd.gov is the old account of user Charmaine and is deactivated/inactive on SailPoint. 
   Can we please go ahead and deactivate on our cjams side as well -  charmaine.d'monte@montgomerycountymd.gov
   Category/ Module  :  user management
   Root cause: User is deactivated in sailpoint and but active in DB
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 1
*/

/*email : 
charmaine.d'monte@montgomerycountymd.gov
*/

select securityusersid, * from userprofile where email like 'charmaine.d%';

update userprofile 
set activeflag=0,updatedon=now(), updatedby = 'CDM-26442'
where securityusersid in ('0a770a3f-207a-4840-8b0c-5b2b45d9e2f7');

update muser 
set activeflag=0,updatedon=now(), updatedby = 'CDM-26442'
where securityusersid in ('0a770a3f-207a-4840-8b0c-5b2b45d9e2f7');

select id, * from muser where securityusersid in ('0a770a3f-207a-4840-8b0c-5b2b45d9e2f7');

-- above id is below principalid
select * from rolemapping 
where principalid in ('5247') and activeflag = 1;

update rolemapping
set activeflag = 0, updatedby = 'CDM-26442', updatedon = now() 
where principalid in ('5247') and activeflag = 1;

select * from userresource where userid in (5247) and activeflag = 1;

update userresource
set activeflag = 0, updatedby = 'CDM-26442', updatedon = now() 
where userid in (5247) and activeflag = 1;

select teammemberid, * from teammemberassignment where securityusersid in ('0a770a3f-207a-4840-8b0c-5b2b45d9e2f7');

update teammemberassignment 
set activeflag =0, updatedby = 'CDM-26442', updatedon = now() 
where securityusersid in ('0a770a3f-207a-4840-8b0c-5b2b45d9e2f7') and activeflag = 1;

select * from teammember where teammemberid in  ('273ee0d6-54a5-4e39-940d-64c688972e17');

update teammember 
set activeflag =0, updatedby = 'CDM-26442', updatedon = now() 
where teammemberid in ('273ee0d6-54a5-4e39-940d-64c688972e17') and activeflag = 1;

update securityusers 
set activeflag =0, updatedby = 'CDM-26442', updatedon = now() 
where securityusersid in ('0a770a3f-207a-4840-8b0c-5b2b45d9e2f7') and activeflag = 1;