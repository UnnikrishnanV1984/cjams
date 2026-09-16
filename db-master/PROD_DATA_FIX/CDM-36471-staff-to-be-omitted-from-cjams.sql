/*
-- Issue Description: CDM-36471 - Staff to be omitted from CJAMS
-- Category/ Module  :  user management
-- Root cause: User is deactivated in sailpoint and but active in DB
-- Fix provided: Deactivated users from database
-- Pull request# for code fix: 
-- Reason why no related code fix: 
-- Status of the code fix if already submitted and expected prod fix date: 
-- Backup before update/ delete: 1
*/

--securityusersid: e65651b1-f64c-48aa-b533-6b9e66cb2a80
select securityusersid, teamtypekey, * from userprofile where email like 'carla.gu%' and activeflag = 1;
--securityusersid: a2b0e332-c1ed-47ec-a755-064642c248fc
select securityusersid, teamtypekey, * from userprofile where email like 'lisa.ral%' and activeflag = 1;

update userprofile 
set activeflag = 0,updatedon=now(), updatedby = 'CDM-36471'
where securityusersid in ('e65651b1-f64c-48aa-b533-6b9e66cb2a80','a2b0e332-c1ed-47ec-a755-064642c248fc');

update muser 
set activeflag = 0,updatedon=now(), updatedby = 'CDM-36471'
where securityusersid in ('e65651b1-f64c-48aa-b533-6b9e66cb2a80','a2b0e332-c1ed-47ec-a755-064642c248fc');

-- Query to get id
select id, * from muser where securityusersid in ('e65651b1-f64c-48aa-b533-6b9e66cb2a80','a2b0e332-c1ed-47ec-a755-064642c248fc');

-- above id is below principalid
select roleid ,* from rolemapping 
where principalid in ('4890','4884') and activeflag = 1 and teamtypekey = 'CW';

update rolemapping
set activeflag = 0, updatedby = 'CDM-36471', updatedon = now() 
where principalid in ('4890','4884') and activeflag = 1 and teamtypekey = 'CW';

select * from userresource where userid in (4890,4884) and activeflag = 1 and roleid in (71);

update userresource
set activeflag = 0, updatedby = 'CDM-36471', updatedon = now() 
where userid in (4890,4884) and activeflag = 1 and roleid in (71);

-- Query to get teammemberid
select teammemberid,securityusersid, * from teammemberassignment where securityusersid in ('e65651b1-f64c-48aa-b533-6b9e66cb2a80','a2b0e332-c1ed-47ec-a755-064642c248fc');

update teammemberassignment 
set activeflag = 0, updatedby = 'CDM-36471', updatedon = now() 
where securityusersid in ('e65651b1-f64c-48aa-b533-6b9e66cb2a80','a2b0e332-c1ed-47ec-a755-064642c248fc') and activeflag = 1;

select * from teammember where teammemberid in  ('1263141d-abf2-4493-b1e9-e4802bf4a2fb','b27c67f9-88b4-4a04-8960-8b9822b4bec3');

update teammember 
set activeflag = 0, updatedby = 'CDM-36471', updatedon = now() 
where teammemberid in ('1263141d-abf2-4493-b1e9-e4802bf4a2fb','b27c67f9-88b4-4a04-8960-8b9822b4bec3') and activeflag = 1;

update securityusers 
set activeflag = 0, updatedby = 'CDM-36471', updatedon = now() 
where securityusersid in ('e65651b1-f64c-48aa-b533-6b9e66cb2a80','a2b0e332-c1ed-47ec-a755-064642c248fc') and activeflag = 1;

select * from userprofileaddress where securityusersid in ('e65651b1-f64c-48aa-b533-6b9e66cb2a80','a2b0e332-c1ed-47ec-a755-064642c248fc') and activeflag = 1;

update userprofileaddress
    set activeflag = 0,
    updatedby = 'CDM-36471', 
    updatedon = now() 
    where securityusersid in ('e65651b1-f64c-48aa-b533-6b9e66cb2a80','a2b0e332-c1ed-47ec-a755-064642c248fc') and activeflag = 1;
