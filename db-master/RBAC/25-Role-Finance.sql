 
--roletype

INSERT INTO cjams.roletype
( roletypecode, roletypename, shortname, activeflag, effectivedate, expirationdate, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES( 'COFW', 'Central Office Fiscal Staff ', 'COFW', 1, now(), NULL, 'admin', 'admin', now(), now(), NULL)ON CONFLICT DO NOTHING;

INSERT INTO cjams.roletype
(roletypecode, roletypename, shortname, activeflag, effectivedate, expirationdate, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('COFS', 'Central Office Fiscal Supervisor', 'COFS', 1, now(), NULL, 'admin', 'admin', now(), now(), NULL)ON CONFLICT DO NOTHING;



--Role 

INSERT INTO cjams.teammemberroletype
(sequencenumber, roletypekey, activeflag, description, teamtypekey, isroutable, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", isupervisor, old_id)
VALUES(192, 'FNSCOFW', 1, 'Central Office Fiscal Staff ,CW', 'FNS', true, 'admin', '2019-08-29 16:33:17.811', 'admin', '2019-08-29 16:33:17.811', '2019-08-29 16:33:17.811', NULL, NULL, false, NULL)ON CONFLICT DO NOTHING;

INSERT INTO cjams."role"
(id, "name", description, created, modified, activeflag, insertedby, updatedby, insertedon, updatedon, roletypekey, old_id, openamrole)
VALUES(4201, 'FW', 'Central Office Fiscal Staff ,CW', NULL, NULL, 1, 'admin', NULL, '2019-08-29 16:33:17.811', NULL, 'FNSCOFW', NULL, '')ON CONFLICT DO NOTHING;



INSERT INTO cjams.teammemberroletype
(sequencenumber, roletypekey, activeflag, description, teamtypekey, isroutable, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", isupervisor, old_id)
VALUES(193, 'FNSCOFS', 1, 'Central Office Fiscal Supervisor', 'FNS', true, 'admin', '2019-08-29 16:33:17.811', 'admin', '2019-08-29 16:33:17.811', '2019-08-29 16:33:17.811', NULL, NULL, false, NULL)ON CONFLICT DO NOTHING;

INSERT INTO cjams."role"
(id, "name", description, created, modified, activeflag, insertedby, updatedby, insertedon, updatedon, roletypekey, old_id, openamrole)
VALUES(4202, 'FS', 'Central Office Fiscal Supervisor,FNS', NULL, NULL, 1, 'admin', NULL, '2019-08-29 16:33:17.811', NULL, 'FNSCOFS', NULL, NULL)ON CONFLICT DO NOTHING;


--roleresource

INSERT INTO cjams.role_resource
(id, roleid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, permissiontype, old_id)
VALUES('589f785e-7a05-49eb-8595-aae0f241ae55', 4201, '59bcd395-be08-4856-8958-65cb17f5a6c4', 1, 'admin', '2019-08-29 11:09:27.000', 'admin', '2019-08-29 11:09:27.000', true, true, true, 1, NULL)ON CONFLICT DO NOTHING;

INSERT INTO cjams.role_resource
(id, roleid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, permissiontype, old_id)
VALUES('ce9ef147-d2ee-4227-a923-35c2c1d75eac', 4202, 'acbe007a-28e3-4e8d-abb6-70650febe34f', 1, 'admin', '2019-08-29 11:10:41.000', 'admin', '2019-08-29 11:10:41.000', true, true, true, 1, NULL)ON CONFLICT DO NOTHING;

