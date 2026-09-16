 /*
   Issue Description: CDM-34794
   Category/ Module  : Role
   Root cause: Due to new security check case management specialist loses their ability to add contact notes
   Fix Privided: Did code and db script to enable permissions for this users
*/

delete from cjams.userresource where roleid=135 and userid=14557 and permissiongroupid='0388441d-afe8-4aff-9553-a192e6fca30f' and activeflag=1;
 
 INSERT INTO cjams.userresource
(userresourceid, userid, permissiongroupid, roleid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES(gen_random_uuid(), 14557, '0388441d-afe8-4aff-9553-a192e6fca30f', 135, NULL, 1, 'CDM-34794', now(), 'CDM-34794', now(), true, true, true, NULL);