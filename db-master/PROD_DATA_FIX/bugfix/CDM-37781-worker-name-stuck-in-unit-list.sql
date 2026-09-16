/*
  Issue Description: CDM-37781
  
   Root cause: The worker has been off-boarded from sailpoint and but active in DB
   Fix: Data fix promoted to deacticated from the DB
*/

/*email : 
brianna.ratliff@maryland.gov
*/

-- Backup
-- ec5596de-0ae8-4877-b699-d3d1c51e2b38
select securityusersid,activeflag,updatedby,updatedon from userprofile where email = 'brianna.ratliff@maryland.gov' and activeflag = 1;

--UPDATE cjams.userprofile
--SET activeflag=1, updatedby='ADMIN', updatedon='2022-12-20 11:59:46.853'
--WHERE securityusersid='ec5596de-0ae8-4877-b699-d3d1c51e2b38' and updatedby = 'CDM-37781';

--Update
 update userprofile 
 set activeflag=0,updatedon=now(), updatedby = 'CDM-37781'
 where securityusersid in ('ec5596de-0ae8-4877-b699-d3d1c51e2b38');

-- Backup
--13437
select id,activeflag,updatedby,updatedon from muser where securityusersid in ('ec5596de-0ae8-4877-b699-d3d1c51e2b38') and activeflag = 1;

--UPDATE cjams.muser
--SET activeflag=1, updatedby='admin', updatedon='2021-07-14 12:39:58.146'
--WHERE id=13437 and updatedby = 'CDM-37781';

--Update
 update muser 
 set activeflag=0,updatedon=now(), updatedby = 'CDM-37781'
 where id in (13437);

-- Backup
select principalid,activeflag,updatedby,updatedon from rolemapping where principalid in ('13437') and activeflag = 1;

--UPDATE cjams.rolemapping
--SET principalid='13437', activeflag=1, updatedby='ADMIN', updatedon='2022-12-20 11:59:46.853' where principalid in ('13437') and updatedby = 'CDM-37781';

--Update
 update rolemapping
 set activeflag = 0, updatedby = 'CDM-37781', updatedon = now() 
 where principalid in ('13437') and activeflag = 1;


-- No data
select userid,activeflag,updatedby,updatedon from userresource where userid in (13437) and activeflag = 1;

-- update userresource
-- set activeflag = 0, updatedby = 'CDM-37781', updatedon = now() 
-- where userid in (13437) and activeflag = 1;

-- Backup
select teammemberid,activeflag,updatedby,updatedon from teammemberassignment where securityusersid in ('ec5596de-0ae8-4877-b699-d3d1c51e2b38');

--UPDATE cjams.teammemberassignment
--SET teammemberid='33e64912-389f-4748-9e6f-830c60ad23c7'::uuid, activeflag=1, updatedby='ADMIN', updatedon='2022-12-20 11:59:46.853' 
--where securityusersid in ('ec5596de-0ae8-4877-b699-d3d1c51e2b38') and updatedby = 'CDM-37781';

--Update
 update teammemberassignment 
 set activeflag =0, updatedby = 'CDM-37781', updatedon = now() 
 where securityusersid in ('ec5596de-0ae8-4877-b699-d3d1c51e2b38') and activeflag = 1;

-- Backup
select teammemberid,activeflag,updatedby,updatedon from teammember where teammemberid in  ('33e64912-389f-4748-9e6f-830c60ad23c7');

--UPDATE cjams.teammember
--SET activeflag=1, updatedby='ADMIN', updatedon='2022-12-20 11:59:46.853'
--WHERE teammemberid='33e64912-389f-4748-9e6f-830c60ad23c7'::uuid and updatedby = 'CDM-37781';

--Update
 update teammember 
 set activeflag =0, updatedby = 'CDM-37781', updatedon = now() 
 where teammemberid in ('33e64912-389f-4748-9e6f-830c60ad23c7') and activeflag = 1;