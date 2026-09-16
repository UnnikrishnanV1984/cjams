INSERT INTO cjams."resource"
(parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES(NULL, 'intake_full_access', 2, 1, 'RBAC', now(), 'RBAC', now(), 'intake_full_access', NULL, NULL, 'intake_full_access', NULL, '');

INSERT INTO cjams."resource"
(parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES(NULL, 'investigation_full_access', 2, 1, 'RBAC', now(), 'RBAC', now(), 'investigation_full_access', NULL, NULL, 'investigation_full_access', NULL, '');

INSERT INTO cjams."resource"
(parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES(NULL, 'servicecase_full_access', 2, 1, 'RBAC', now(), 'RBAC', now(), 'servicecase_full_access', NULL, NULL, 'servicecase_full_access', NULL, '');

INSERT INTO cjams."resource"
(parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES(NULL, 'adoptioncase_full_access', 2, 1, 'RBAC', now(), 'RBAC', now(), 'adoptioncase_full_access', NULL, NULL, 'adoptioncase_full_access', NULL, '');

INSERT INTO cjams."resource"
(parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES(NULL, 'finance_full_access', 2, 1, 'RBAC', now(), 'RBAC', now(), 'finance_full_access', NULL, NULL, 'finance_full_access', NULL, '');

INSERT INTO cjams.permissiongroup
(permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('intake_full_access', '', 1, 'RBAC', 'RBAC', now(), now(), NULL);

INSERT INTO cjams.permissiongroup
(permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('investigation_full_access', '', 1, 'RBAC', 'RBAC', now(), now(), NULL);

INSERT INTO cjams.permissiongroup
(permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('servicecase_full_access', '', 1, 'RBAC', 'RBAC', now(), now(), NULL);

INSERT INTO cjams.permissiongroup
(permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('adoptioncase_full_access', '', 1, 'RBAC', 'RBAC', now(), now(), NULL);

INSERT INTO cjams.permissiongroup
(permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('finance_full_access', '', 1, 'RBAC', 'RBAC', now(), now(), NULL);

