/*
  Issue Description: CDM-26335 - Dashboard:Hello, In CJAMS i have two accounts. Is it possible to merge them so that I am listed once in CJAMS.
   Category/ Module  :  user management
   Root cause: User is deactivated in sailpoint and but active in DB
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 1
*/

/*email : 
angelesa.blackwell@maryland.gov
*/

select securityusersid, * from userprofile where email = 'angelesa.blackwell@maryland.gov';

update userprofile 
set activeflag=0,updatedon=now(), updatedby = 'CDM-26335'
where securityusersid in ('2f5db488-b4b2-4445-be6c-5fa9879672db', '440050bc-ec3a-4ff9-b678-a7a98076bb94');

select id, * from muser where securityusersid in ('2f5db488-b4b2-4445-be6c-5fa9879672db', '440050bc-ec3a-4ff9-b678-a7a98076bb94');

update muser 
set activeflag=0,updatedon=now(), updatedby = 'CDM-26335'
where securityusersid in ('2f5db488-b4b2-4445-be6c-5fa9879672db', '440050bc-ec3a-4ff9-b678-a7a98076bb94');

update rolemapping
set activeflag = 0, updatedby = 'CDM-26335', updatedon = now() 
where principalid in ('9960', '11937') and activeflag = 1;

select * from userresource where userid in (9960, 11937) and activeflag = 1;

update userresource
set activeflag = 0, updatedby = 'CDM-26335', updatedon = now() 
where userid in (9960, 11937) and activeflag = 1;

select teammemberid, * from teammemberassignment where securityusersid in ('2f5db488-b4b2-4445-be6c-5fa9879672db', '440050bc-ec3a-4ff9-b678-a7a98076bb94');

update teammemberassignment 
set activeflag =0, updatedby = 'CDM-26335', updatedon = now() 
where securityusersid in ('2f5db488-b4b2-4445-be6c-5fa9879672db', '440050bc-ec3a-4ff9-b678-a7a98076bb94') and activeflag = 1;

select * from teammember where teammemberid in  ('ad563522-dc28-4cb6-8db3-1cc0dd120824', '97c704a8-6b3d-4ea6-b34a-61fd8ef628a8');

update teammember 
set activeflag =0, updatedby = 'CDM-26335', updatedon = now() 
where teammemberid in ('ad563522-dc28-4cb6-8db3-1cc0dd120824', '97c704a8-6b3d-4ea6-b34a-61fd8ef628a8') and activeflag = 1;

update securityusers 
set activeflag =0, updatedby = 'CDM-26335', updatedon = now() 
where securityusersid in ('2f5db488-b4b2-4445-be6c-5fa9879672db', '440050bc-ec3a-4ff9-b678-a7a98076bb94') and activeflag = 1;