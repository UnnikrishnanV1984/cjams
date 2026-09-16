/* 
    Issue Description: CDM-38398
   Category/ Module  : Lashay fuller is missing from the assignment list
   Root cause:  Lashay fuller is missing from the assignment list
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    void the rejected provider placement from backend
*/

INSERT INTO cjams.userresource
(userid, permissiongroupid, roleid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon,
 isallowed, isvisible, isenabled, old_id)
VALUES(29084, '9a29e0be-1506-4b30-a2c3-8b4ac0c8a1e0'::uuid, 1750, NULL, 1, '24e8c790-dee5-4b93-982d-89f6f263fb43',
 '2020-07-29 14:01:57.000', '24e8c790-dee5-4b93-982d-89f6f263fb43', '2020-07-29 14:01:57.000', NULL, NULL, NULL, NULL);