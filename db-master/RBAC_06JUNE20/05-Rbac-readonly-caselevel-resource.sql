INSERT INTO cjams."resource"
(parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES(NULL, 'finance_read_only_access', 2, 1, 'RBAC', now(), 'RBAC', now(), 'finance_read_only_access', NULL, NULL, 'finance_read_only_access', NULL, '');

INSERT INTO cjams.permissiongroup
(permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('finance_read_only_access', '', 1, 'RBAC', 'RBAC', now(), now(), NULL);


