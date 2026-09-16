INSERT INTO cjams."resource"
(parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES(NULL, 'Contact Support Approval Access', 2, 1, 'RBAC', now(), 'RBAC', now(), 'Contact Support Approval Access', NULL, NULL, 'Contact Support Approval Access', NULL, '');

INSERT INTO cjams.permissiongroup
(permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('Contact Support Approval Access', '', 1, 'RBAC', 'RBAC', now(), now(), NULL);