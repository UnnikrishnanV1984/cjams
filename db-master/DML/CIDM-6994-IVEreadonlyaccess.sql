INSERT INTO cjams.permissiongroup
(permissiongroupid, permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('05b1e8d6-9f89-43c2-9138-52bde88f2f16', 'titleive_read_only_access', '', 1, 'RBAC', 'CIDM-6994', now(), now(), NULL) ON CONFLICT DO NOTHING;

INSERT INTO cjams.resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('59e2c031-ba4b-488a-a937-dd2a6ba03796', NULL, 'titleive_read_only_access', 2, 1, 'RBAC', now(), 'CIDM-6994', now(), 'titleive_read_only_access', NULL, NULL, 'titleive_read_only_access', NULL, '') ON CONFLICT DO NOTHING;


INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('98927218-248d-4fd0-bb7f-7efbc927897a', '2acd8eca-7916-4994-b601-43cb05e7758f', '59e2c031-ba4b-488a-a937-dd2a6ba03796', 1, 'RBAC', now(), 'CIDM-6994',now(), true, NULL, NULL, NULL) ON CONFLICT DO NOTHING;
