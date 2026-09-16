
/*
Issue Description: CJAMS-57719: SailPoint/CJAMS
Category/Module: Case assignment 
Root cause: Supervisor is unable to find the Case worker in case assignment as permissions are not available in the user resource table.
Fix provided: Data fix has been done to add necessary permissions for the user Cara Little in Case assignment.
Data/Code fix ticket#: CJAMS-57719
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This is a know sailpoint issue and data fix to update userresource should fix it.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

INSERT INTO cjams.userresource
(userresourceid, userid, permissiongroupid, roleid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES(gen_random_uuid(), 49442, '4ba216d8-5eb2-4164-b01b-e19452425387'::uuid, 5988, NULL, 1, 'CJAMS-57719', now(), 'CJAMS-57719', now(), true, true, true, NULL);
