/*
   Issue Description: CDM-16315
   Category/ Module  :  Adding intake read access for IVE users
   Root cause: Not required types
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

INSERT INTO cjams.role_resource
(id, roleid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, permissiontype, old_id)
VALUES(gen_random_uuid(), 1750, 'e66a00fe-0d20-448b-96eb-d7157ff08c39'::uuid, 1, 'CDM-16315', NOW(), 'CDM-16315', NOW(), true, true, true, 1, NULL);

INSERT INTO cjams.role_resource
(id, roleid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, permissiontype, old_id)
VALUES(gen_random_uuid(), 1051, 'e66a00fe-0d20-448b-96eb-d7157ff08c39'::uuid, 1, 'CDM-I6315', NOW(), 'CDM-16315', NOW(), true, true, true, 1, NULL);
