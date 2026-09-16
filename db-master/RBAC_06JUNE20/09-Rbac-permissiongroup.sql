INSERT INTO cjams.permissiongroup
(permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('Read_only_access', '', 1, 'RBAC', 'RBAC', now(), now(), NULL);
INSERT INTO cjams.permissiongroup
(permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('Admin Audit Monitor CQI', '', 1, 'RBAC', 'RBAC', now(), now(), NULL);
INSERT INTO cjams."resource"
(parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES(NULL, 'Manual Expungment', 2, 1, 'RBAC', now(), 'RBAC', now(), 'Manual Expungment', NULL, NULL, 'Manual Expungment', NULL, '');
INSERT INTO cjams.permissiongroup
(permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('Manual Expungment', '', 1, 'RBAC', 'RBAC', now(), now(), NULL);
INSERT INTO cjams.teammemberroletype
(roletypekey, activeflag, description, teamtypekey, isroutable, insertedby, insertedon, updatedby, updatedon, effectivedate, isupervisor )
VALUES('AAMCP', 1, 'Admin-Audit-Monitor-CQI_Prov', 'PROV', true, 'Rbac', now(), 'Rbac',now(), now(), false);
INSERT INTO cjams.roletype
(roletypecode, roletypename, shortname, activeflag, effectivedate, expirationdate, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('AAMCP', 'Admin-Audit-Monitor-CQI_Prov', 'AAMCP', 1, now(), NULL, 'Rbac', 'Rbac', now(), now(), NULL); 
INSERT INTO cjams."role"
(id, "name", description, activeflag, insertedby, updatedby, insertedon, updatedon, roletypekey, openamrole)
VALUES(150, 'Admin-Audit-Monitor-CQI_Prov', 'Admin-Audit-Monitor-CQI_Prov', 1, 'Rbac', 'Rbac', now(), now(), 'AAMCP', 'ADMIN-AUDIT-MONITOR-CQI_PROV');
INSERT INTO cjams.permissiongroup
(permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('Legal Rep-Agency Attorney', '', 1, 'RBAC', 'RBAC', now(), now(), NULL);
INSERT INTO cjams."resource"
(parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES(NULL, 'Legal Rep-Agency Attorney', 2, 1, 'RBAC', now(), 'RBAC', now(), 'Legal Rep-Agency Attorney', NULL, NULL, 'Legal Rep-Agency Attorney', NULL, '');
INSERT INTO cjams.permissiongroup
(permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('Independent Living Coordinator', '', 1, 'RBAC', 'RBAC', now(), now(), NULL);
INSERT INTO cjams."resource"
(parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES(NULL, 'Independent Living Coordinator', 2, 1, 'RBAC', now(), 'RBAC', now(), 'Independent Living Coordinator', NULL, NULL, 'Independent Living Coordinator', NULL, '');
INSERT INTO cjams."resource"
(parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES(NULL, 'State Wide FA', 2, 1, 'RBAC', now(), 'RBAC', now(), 'State Wide FA', NULL, NULL, 'State Wide FA', NULL, '');
INSERT INTO cjams.permissiongroup
(permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('State Wide FA', '', 1, 'RBAC', 'RBAC', now(), now(), NULL);
INSERT INTO cjams.permissiongroup
(permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('Staff Management', '', 1, 'RBAC', 'RBAC', now(), now(), NULL);
INSERT INTO cjams.permissiongroup
(permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('staff-mangement-read-only', '', 1, 'RBAC', 'RBAC', now(), now(), NULL);
INSERT INTO cjams."resource"
(parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES(NULL, 'Staff Management', 2, 1, 'RBAC', now(), 'RBAC', now(), 'Staff Management', NULL, NULL, 'Staff Management', NULL, '');INSERT INTO cjams."resource"
(parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES(NULL, 'staff-mangement-read-only', 2, 1, 'RBAC', now(), 'RBAC', now(), 'staff-mangement-read-only', NULL, NULL, 'staff-mangement-read-only', NULL, '');
INSERT INTO cjams.permissiongroup
(permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('Medical Specialist', '', 1, 'RBAC', 'RBAC', now(), now(), NULL);
INSERT INTO cjams.permissiongroup
(permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('Resource Specialist', '', 1, 'RBAC', 'RBAC', now(), now(), NULL);
