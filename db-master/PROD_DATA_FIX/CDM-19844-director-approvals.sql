
 /*
  Issue Description: CDM-19844
   Category/ Module  :  Not able to approve over $1000 service logs as LDSS Director
   Root cause: wrongly mapped with program manager role
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
*/

update userresource set activeflag=0, updatedby='CDM-19844', updatedon=now() where userid=3963 and activeflag=1
and permissiongroupid='5c760141-a1ff-4ae2-bbc8-5692391e3dc1' and userresourceid='aed2bbad-aabb-4092-a394-160a783339e7';

delete from cjams.userresource where userid=3963 and permissiongroupid='57a390b8-3387-428a-97a8-0b8559fd1f1e' and activeflag=1;
INSERT INTO cjams.userresource
(userresourceid, userid, permissiongroupid, roleid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES(gen_random_uuid(), 3963, '57a390b8-3387-428a-97a8-0b8559fd1f1e', 36, NULL, 1, 'CDM-19844', now(), 'CDM-19844', now(), NULL, NULL, NULL, NULL);
