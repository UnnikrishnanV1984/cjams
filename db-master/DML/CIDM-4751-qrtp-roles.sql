DELETE FROM cjams."role" WHERE id in (5989, 5988, 5987) and roletypekey in ('FTDMQIS', 'QUINW', 'FTDMFW'); 


INSERT INTO cjams."role"
(id, "name", description, created, modified, activeflag, insertedby, updatedby, insertedon, updatedon, roletypekey, old_id, openamrole)
VALUES(5989, 'CJAMS_SSA_FTDM_QI_SUPERVISOR', 'FTDM/QI Supervisor', NULL, NULL, 1, 'admin', NULL, now(), now(), 'FTDMQIS', NULL, 'CJAMS_SSA_FTDM_QI_SUPERVISOR')ON CONFLICT DO NOTHING;
INSERT INTO cjams."role"
(id, "name", description, created, modified, activeflag, insertedby, updatedby, insertedon, updatedon, roletypekey, old_id, openamrole)
VALUES(5988, 'CJAMS_SSA_QUALIFIED_INDIVIDUAL', 'Qualified Individual', NULL, NULL, 1, 'admin', NULL, now(), now(), 'QUINW', NULL, 'CJAMS_SSA_QUALIFIED_INDIVIDUAL')ON CONFLICT DO NOTHING;
INSERT INTO cjams."role"
(id, "name", description, created, modified, activeflag, insertedby, updatedby, insertedon, updatedon, roletypekey, old_id, openamrole)
VALUES(5987, 'CJAMS_SSA_FTDM_FACILITATOR', 'FTDM Facilitator', NULL, NULL, 1, 'admin', NULL, now(), now(), 'FTDMFW', NULL, 'CJAMS_SSA_FTDM_FACILITATOR')ON CONFLICT DO NOTHING;


                    