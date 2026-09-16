INSERT INTO cjams.roletype
(roletypeid, roletypecode, roletypename, shortname, activeflag, effectivedate, expirationdate, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('c0f0cc5b-2c70-4f50-adbd-e7c151985d73'::uuid, 'CWSSAPMR', 'SSA Placement Manager Role', 'CWSSAPMR', 1, '2022-01-21 09:49:17.303', NULL, 'admin', 'admin', '2022-01-21 09:49:17.303', '2022-01-21 09:49:17.303', NULL) ON CONFLICT DO NOTHING;

INSERT INTO cjams."role"
(id, "name", description, created, modified, activeflag, insertedby, updatedby, insertedon, updatedon, roletypekey, old_id, openamrole)
VALUES(5985, 'CWSSAPMR', 'SSA Placement Manager Role,CW', NULL, NULL, 1, 'admin', NULL, '2022-01-21 09:51:01.526', NULL, 'CWSSAPMR', NULL, 'CJAMS_SSA_PLACEMENT_MANAGER') ON CONFLICT DO NOTHING;

INSERT INTO cjams.teammemberroletype
(sequencenumber, roletypekey, activeflag, description, teamtypekey, isroutable, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", isupervisor, old_id, rolelevel)
VALUES(1510, 'CWSSAPMR', 1, 'SSA Placement Manager Role', 'CW', true, 'admin', '2022-01-21 09:51:01.526', 'admin', '2022-01-21 09:51:01.526', '2022-01-21 09:51:01.526', NULL, NULL, false, NULL, NULL) ON CONFLICT DO NOTHING;

