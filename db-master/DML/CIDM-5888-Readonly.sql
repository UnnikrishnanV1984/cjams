--Role resource
delete from cjams.role_resource where roleid in (5989,5988,5987) and activeflag=1;

INSERT INTO cjams.role_resource
(id, roleid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, permissiontype, old_id)
VALUES(gen_random_uuid(), 5987, 'cefb560c-258c-4be6-86c0-aed507ee9834', 1, 'QRTPUS', now(), 'QRTPUS', now(), true, true, true, 1, NULL);

INSERT INTO cjams.role_resource
(id, roleid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, permissiontype, old_id)
VALUES(gen_random_uuid(), 5988, 'cefb560c-258c-4be6-86c0-aed507ee9834', 1, 'QRTPUS', now(), 'QRTPUS', now(), true, true, true, 1, NULL);

INSERT INTO cjams.role_resource
(id, roleid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, permissiontype, old_id)
VALUES(gen_random_uuid(), 5989, 'cefb560c-258c-4be6-86c0-aed507ee9834', 1, 'QRTPUS', now(), 'QRTPUS', now(), true, true, true, 1, NULL);