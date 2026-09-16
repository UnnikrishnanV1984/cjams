DELETE FROM cjams.role_resource WHERE roleid in (5989, 5988, 5987);
                       
INSERT INTO cjams.role_resource
(id, roleid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, permissiontype, old_id)
VALUES('c8b1461b-c2c3-4708-8c5d-4d125911535e'::uuid, 5987, '90ed1d47-e282-48df-a54a-a2151bde847f'::uuid, 1, 'QRTPUS', '2022-09-27 11:43:23.899', 'QRTPUS', '2022-09-27 11:43:23.899', true, true, true, 1, NULL)ON CONFLICT DO NOTHING;
       
 INSERT INTO cjams.role_resource
(id, roleid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, permissiontype, old_id)
VALUES('88843676-9706-454c-908f-0c4ef7002679'::uuid, 5989, '2105ed26-fdaf-41d5-aca8-19b334f78daa'::uuid, 1, 'QRTPUS', '2022-09-27 11:43:23.899', 'QRTPUS', '2022-09-27 11:43:23.899', true, true, true, 1, NULL)ON CONFLICT DO NOTHING;
    
INSERT INTO cjams.role_resource
(id, roleid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, permissiontype, old_id)
VALUES('5cbb1b46-2dda-4af0-aed3-acc6890abeb4'::uuid, 5988, '4ba216d8-5eb2-4164-b01b-e19452425387'::uuid, 1, 'QRTPUS', '2022-09-27 11:43:23.899', 'QRTPUS', '2022-09-27 11:43:23.899', true, true, true, 1, NULL)ON CONFLICT DO NOTHING;
