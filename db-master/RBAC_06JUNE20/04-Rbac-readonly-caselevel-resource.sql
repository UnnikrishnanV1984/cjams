INSERT INTO cjams."resource"
(parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES(NULL, 'intake_read_only_access', 2, 1, 'RBAC', now(), 'RBAC', now(), 'intake_read_only_access', NULL, NULL, 'intake_read_only_access', NULL, '');

INSERT INTO cjams."resource"
(parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES(NULL, 'investigation_read_only_access', 2, 1, 'RBAC', now(), 'RBAC', now(), 'investigation_read_only_access', NULL, NULL, 'investigation_read_only_access', NULL, '');

INSERT INTO cjams."resource"
(parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES(NULL, 'servicecase_read_only_access', 2, 1, 'RBAC', now(), 'RBAC', now(), 'servicecase_read_only_access', NULL, NULL, 'servicecase_read_only_access', NULL, '');

INSERT INTO cjams."resource"
(parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES(NULL, 'adoptioncase_read_only_access', 2, 1, 'RBAC', now(), 'RBAC', now(), 'adoptioncase_read_only_access', NULL, NULL, 'adoptioncase_read_only_access', NULL, '');

INSERT INTO cjams.permissiongroup
(permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('intake_read_only_access', '', 1, 'RBAC', 'RBAC', now(), now(), NULL);

INSERT INTO cjams.permissiongroup
(permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('investigation_read_only_access', '', 1, 'RBAC', 'RBAC', now(), now(), NULL);

INSERT INTO cjams.permissiongroup
(permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('servicecase_read_only_access', '', 1, 'RBAC', 'RBAC', now(), now(), NULL);

INSERT INTO cjams.permissiongroup
(permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('adoptioncase_read_only_access', '', 1, 'RBAC', 'RBAC', now(), now(), NULL);

INSERT INTO cjams."resource"
(parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES(NULL, 'Intake_noaccess', 2, 1, 'RBAC', now(), 'RBAC', now(), 'Intake_noaccess', NULL, NULL, 'Intake_noaccess', NULL, '');

INSERT INTO cjams."resource"
(parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES(NULL, 'Child Protective Services_noaccess', 2, 1, 'RBAC', now(), 'RBAC', now(), 'Child Protective Services_noaccess', NULL, NULL, 'Child Protective Services_noaccess', NULL, '');

INSERT INTO cjams."resource"
(parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES(NULL, 'Service Case_noaccess', 2, 1, 'RBAC', now(), 'RBAC', now(), 'Service Case_noaccess', NULL, NULL, 'Service Case_noaccess', NULL, '');

INSERT INTO cjams."resource"
(parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES(NULL, 'Adoption Case_noaccess', 2, 1, 'RBAC', now(), 'RBAC', now(), 'Adoption Case_noaccess', NULL, NULL, 'Adoption Case_noaccess', NULL, '');

INSERT INTO cjams.permissiongroup
(permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('Intake_noaccess', '', 1, 'RBAC', 'RBAC', now(), now(), NULL);

INSERT INTO cjams.permissiongroup
(permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('Child Protective Services_noaccess', '', 1, 'RBAC', 'RBAC', now(), now(), NULL);

INSERT INTO cjams.permissiongroup
(permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('Service Case_noaccess', '', 1, 'RBAC', 'RBAC', now(), now(), NULL);

INSERT INTO cjams.permissiongroup
(permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('Adoption Case_noaccess', '', 1, 'RBAC', 'RBAC', now(), now(), NULL);
