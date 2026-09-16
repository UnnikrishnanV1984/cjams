/*
   Issue Description: CDM-42484
   Category/ Module  : User Profile
   Root cause: Data fix done to remove duplicated from rolemapping and insert to user resource
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/
UPDATE cjams.rolemapping
SET activeflag=0, updatedby='CDM-42484', updatedon=now()
WHERE id in (151824932,151794831,151830933);

delete from cjams.userresource where insertedby = 'CDM-42484' and roleid=134 and userid=52653 and activeflag=1;

INSERT INTO cjams.userresource
(userid, permissiongroupid, roleid, resourceid, activeflag, isallowed, isvisible, isenabled, old_id,  insertedby, insertedon, updatedby, updatedon)
select 52653, pg.permissiongroupid, 134, NULL, 1, true, true, true, NULL, 'CDM-42484', now(), 'CDM-42484', now()
from permissiongroup pg
where pg.permissiongroupid in (select resourceid from role_resource where roleid = 134 and activeflag = 1);



