INSERT INTO cjams."resource"
(parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES(NULL, 'IV-E Search', 2, 1, 'RBAC', now(), 'RBAC', now(), 'IV-E Search', NULL, NULL, 'IV-E Search', NULL, '');

INSERT INTO cjams.permissiongroup
(permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('IV-E Search', '', 1, 'RBAC', 'RBAC', now(), now(), NULL);

INSERT INTO cjams."resource"
(parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES(NULL, 'IV-E Dashboard', 2, 1, 'RBAC', now(), 'RBAC', now(), 'IV-E Dashboard', NULL, NULL, 'IV-E Dashboard', NULL, '');

INSERT INTO cjams.permissiongroup
(permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('IV-E Dashboard', '', 1, 'RBAC', 'RBAC', now(), now(), NULL);
