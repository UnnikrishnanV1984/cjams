
--  select * from role_resource rr where roleid  in ('5992','5990','5991','129');
-- select * from  cjams.permissiongroup  where permissiongroupname  in ('Citizens_Review_Board_for_Children','Psychotropic_Pharmacist_Review','Psychotropic_Psychiarist_Review', 'Psychotropic_Coordinator_Review');

-- Citizens_Review_Board_for_Children
-- Psychotropic_Pharmacist_Review
-- Psychotropic_Psychiarist_Review
-- Psychotropic_Coordinator_Review

-- select * from resource r where resourcename in ('Citizens_Review_Board_for_Children','Psychotropic_Pharmacist_Review','Psychotropic_Psychiarist_Review', 'Psychotropic_Coordinator_Review');


Delete from  cjams.permissiongroup 
where permissiongroupname in  ('Citizens_Review_Board_for_Children','Psychotropic_Pharmacist_Review','Psychotropic_Psychiarist_Review', 'Psychotropic_Coordinator_Review');

Delete from cjams.resource 
where resourcename in  ('Citizens_Review_Board_for_Children','Psychotropic_Pharmacist_Review','Psychotropic_Psychiarist_Review', 'Psychotropic_Coordinator_Review');

Delete from cjams.role_resource
where id in ('ef9bb485-9208-48ba-b43b-226f5655fe12','334f4dc2-9b40-472a-b978-6c3417242c27','52223164-8091-4fbb-9fc0-9b0a084191a2', '4dad1d41-6d7e-45c9-b6dd-449c0b5d5535') and activeflag = 1;

Delete from cjams.pgresource
where pgresourceid in ('e0127ae5-bd16-4626-968e-ca0ad708edd4','8416f971-026d-41cf-8270-f49bd626c1d6','c7c2b11b-688a-4636-ac48-394a7a503ed1','404e0b98-f4f4-4869-9baa-77b6c55c6280') and activeflag = 1;

--Citizens_Review_Board_for_Children 129

INSERT INTO cjams.permissiongroup
(permissiongroupid, permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('4e528223-ebf7-47ab-bd3c-413279e138ce'::uuid, 'Citizens_Review_Board_for_Children', '', 1, 'CIDM-10293', 'CIDM-10293', NOW(), NOW(), NULL);

INSERT INTO cjams.resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('c7ccc063-6fae-4fae-b4d2-4f256a9ac7ca', NULL, 'Citizens_Review_Board_for_Children', 2, 1, 'CIDM-10293', NOW(), 'CIDM-10293', NOW(), 'Citizens_Review_Board_for_Children', NULL, NULL, 'Citizens_Review_Board_for_Children', NULL, 'Citizens_Review_Board_for_Children');
      
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('e0127ae5-bd16-4626-968e-ca0ad708edd4'::uuid, '4e528223-ebf7-47ab-bd3c-413279e138ce'::uuid, 'c7ccc063-6fae-4fae-b4d2-4f256a9ac7ca'::uuid, 1, 'CIDM-10293', NOW(), 'CIDM-10293', NOW(), true, true, NULL, NULL);

INSERT INTO role_resource
(id, roleid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, permissiontype, old_id)
VALUES('ef9bb485-9208-48ba-b43b-226f5655fe12', 129, '4e528223-ebf7-47ab-bd3c-413279e138ce', 1, 'CIDM-10293', now(), 'CIDM-10293', now(), true, true, true, 1, NULL);

--Psychotropic_Pharmacist_Review 5990

INSERT INTO cjams.permissiongroup
(permissiongroupid, permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('015458cb-a0a8-4999-b24f-29133c19abf1'::uuid, 'Psychotropic_Pharmacist_Review', '', 1, 'CIDM-10293', 'CIDM-10293', NOW(), NOW(), NULL);

INSERT INTO cjams.resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('304fc7f6-2783-4329-8aba-4510b9d7035e', NULL, 'Psychotropic_Pharmacist_Review', 2, 1, 'CIDM-10293', NOW(), 'CIDM-10293', NOW(), 'Psychotropic_Pharmacist_Review', NULL, NULL, 'Psychotropic_Pharmacist_Review', NULL, 'Psychotropic_Pharmacist_Review');
      
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('8416f971-026d-41cf-8270-f49bd626c1d6'::uuid, '015458cb-a0a8-4999-b24f-29133c19abf1'::uuid, '304fc7f6-2783-4329-8aba-4510b9d7035e'::uuid, 1, 'CIDM-10293', NOW(), 'CIDM-10293', NOW(), true, true, NULL, NULL);

INSERT INTO role_resource
(id, roleid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, permissiontype, old_id)
VALUES('334f4dc2-9b40-472a-b978-6c3417242c27', 5990, '015458cb-a0a8-4999-b24f-29133c19abf1', 1, 'CIDM-10293', now(), 'CIDM-10293', now(), true, true, true, 1, NULL);

--Psychotropic_Psychiarist_Review 5991
INSERT INTO cjams.permissiongroup
(permissiongroupid, permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('771dace4-c277-4664-9a1b-5b3d5b1232e2'::uuid, 'Psychotropic_Psychiarist_Review', '', 1, 'CIDM-10293', 'CIDM-10293', NOW(), NOW(), NULL);

INSERT INTO cjams.resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('912f1cbc-be6e-4dd4-bf3d-8f47831908b8', NULL, 'Psychotropic_Psychiarist_Review', 2, 1, 'CIDM-10293', NOW(), 'CIDM-10293', NOW(), 'Psychotropic_Psychiarist_Review', NULL, NULL, 'Psychotropic_Psychiarist_Review', NULL, 'Psychotropic_Psychiarist_Review');
      
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('c7c2b11b-688a-4636-ac48-394a7a503ed1'::uuid, '771dace4-c277-4664-9a1b-5b3d5b1232e2'::uuid, '912f1cbc-be6e-4dd4-bf3d-8f47831908b8'::uuid, 1, 'CIDM-10293', NOW(), 'CIDM-10293', NOW(), true, true, NULL, NULL);

INSERT INTO role_resource
(id, roleid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, permissiontype, old_id)
VALUES('52223164-8091-4fbb-9fc0-9b0a084191a2', 5991, '771dace4-c277-4664-9a1b-5b3d5b1232e2', 1, 'CIDM-10293', now(), 'CIDM-10293', now(), true, true, true, 1, NULL);

-- Psychotropic_Coordinator_Review 5992
INSERT INTO cjams.permissiongroup
(permissiongroupid, permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('edbf5ba1-b78d-4a6d-9704-272bcdb668f4'::uuid, 'Psychotropic_Coordinator_Review', '', 1, 'CIDM-10293', 'CIDM-10293', NOW(), NOW(), NULL);

INSERT INTO cjams.resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('3ad16c58-5432-48c1-a312-f0e38c89c9cc', NULL, 'Psychotropic_Coordinator_Review', 2, 1, 'CIDM-10293', NOW(), 'CIDM-10293', NOW(), 'Psychotropic_Coordinator_Review', NULL, NULL, 'Psychotropic_Coordinator_Review', NULL, 'Psychotropic_Coordinator_Review');
      
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('404e0b98-f4f4-4869-9baa-77b6c55c6280'::uuid, 'edbf5ba1-b78d-4a6d-9704-272bcdb668f4'::uuid, '3ad16c58-5432-48c1-a312-f0e38c89c9cc'::uuid, 1, 'CIDM-10293', NOW(), 'CIDM-10293', NOW(), true, true, NULL, NULL);

INSERT INTO role_resource
(id, roleid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, permissiontype, old_id)
VALUES('4dad1d41-6d7e-45c9-b6dd-449c0b5d5535', 5992, 'edbf5ba1-b78d-4a6d-9704-272bcdb668f4', 1, 'CIDM-10293', now(), 'CIDM-10293', now(), true, true, true, 1, NULL);

