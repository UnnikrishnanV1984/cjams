
--  select * from role_resource rr where roleid  in ('5989','5988','5987') ON CONFLICT DO NOTHING;


-- select * from  cjams.permissiongroup  where permissiongroupname  in ('FTDM_Facilitator_Worker','QUALIFIED_INDIVIDUAL_Worker','FTDM_QI_SUPERVISOR') ON CONFLICT DO NOTHING;


-- select * from resource r where resourcename ='FTDM_Facilitator_Worker';

-- --select gen_random_uuid() ON CONFLICT DO NOTHING;

-- select * from cjams.pgresource where permissiongroupid ='f53a8be9-15c2-404c-a3a0-5450240a0d9d';



update teammemberroletype set rolelevel =39, updatedby ='QRTP', updatedon= now() where roletypekey in ('FTDMQIS','QUINW','FTDMFW');



--FTDM_Facilitator_Worker

INSERT INTO cjams.permissiongroup
(permissiongroupid, permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('90ed1d47-e282-48df-a54a-a2151bde847f'::uuid, 'FTDM_Facilitator_Worker', '', 1, 'QRTP', 'QRTP', NOW(), NOW(), NULL) ON CONFLICT DO NOTHING;


INSERT INTO cjams.resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('b4987169-3260-4970-9500-14b56f145288', NULL, 'FTDM_Facilitator_Worker', 2, 1, 'CIDM-5675', NOW(), 'CIDM-5675', NOW(), 'FTDM_Facilitator_Worker', NULL, NULL, 'FTDM_Facilitator_Worker', NULL, 'FTDM_Facilitator_Worker') ON CONFLICT DO NOTHING;
      

INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('da323192-02f8-4eac-b089-359f20a2b972'::uuid, '90ed1d47-e282-48df-a54a-a2151bde847f'::uuid, 'b4987169-3260-4970-9500-14b56f145288'::uuid, 1, 'QRTP', NOW(), 'QRTP', NOW(), true, true, NULL, NULL) ON CONFLICT DO NOTHING;



--FTDM_QI_SUPERVISOR


INSERT INTO cjams.permissiongroup
(permissiongroupid, permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('2105ed26-fdaf-41d5-aca8-19b334f78daa'::uuid, 'FTDM_QI_SUPERVISOR', '', 1, 'QRTP', 'QRTP', now(), now(), NULL) ON CONFLICT DO NOTHING;


INSERT INTO cjams.resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('97ad3650-3aaa-4447-a5fa-a8d30e6a5e01', NULL, 'FTDM_QI_SUPERVISOR', 2, 1, 'CIDM-5675', NOW(), 'CIDM-5675', NOW(), 'FTDM_QI_SUPERVISOR', NULL, NULL, 'FTDM_QI_SUPERVISOR', NULL, 'FTDM_QI_SUPERVISOR') ON CONFLICT DO NOTHING;
      

INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('183aadd1-df40-4c3e-89be-ae23ee13e793', '2105ed26-fdaf-41d5-aca8-19b334f78daa', '97ad3650-3aaa-4447-a5fa-a8d30e6a5e01', 1, 'CIDM-5675', NOW(), 'CIDM-5675', NOW(), true, true, true, NULL)ON CONFLICT DO NOTHING;



--QUALIFIED_INDIVIDUAL_Worker

INSERT INTO cjams.permissiongroup
(permissiongroupid, permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('4ba216d8-5eb2-4164-b01b-e19452425387'::uuid, 'QUALIFIED_INDIVIDUAL_Worker', '', 1, 'QRTP', 'QRTP', now(),  now(), NULL) ON CONFLICT DO NOTHING;


INSERT INTO cjams.resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('01e2ffec-bf18-4e85-ae62-3775748fd008', NULL, 'QUALIFIED_INDIVIDUAL_Worker', 2, 1, 'CIDM-5675', NOW(), 'CIDM-5675', NOW(), 'QUALIFIED_INDIVIDUAL_Worker', NULL, NULL, 'QUALIFIED_INDIVIDUAL_Worker', NULL, 'QUALIFIED_INDIVIDUAL_Worker') ON CONFLICT DO NOTHING;
      

INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('dc7e8a4b-d6a5-44be-8c9b-e67bdf7eb3a0'::uuid, '4ba216d8-5eb2-4164-b01b-e19452425387'::uuid, '01e2ffec-bf18-4e85-ae62-3775748fd008'::uuid, 1, 'QRTP', NOW(), 'QRTP', NOW(), true, true, NULL, NULL) ON CONFLICT DO NOTHING;




