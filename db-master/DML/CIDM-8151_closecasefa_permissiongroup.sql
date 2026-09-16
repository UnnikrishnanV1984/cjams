INSERT INTO cjams.permissiongroup
(permissiongroupid, permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('05b1e8d6-9f89-43c2-9138-52bde88f2f16', 'closed_servicecase_fullaccess', '', 1, 'RBAC', 'CIDM-8151', now(), now(), NULL) ON CONFLICT DO NOTHING;

INSERT INTO cjams.resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('010f6b83-5a5a-44ef-85d0-a6515564c663', NULL, 'closed_servicecase_fullaccess', 2, 1, 'RBAC', now(), 'CIDM-8151', now(), 'closed_servicecase_fullaccess', NULL, NULL, 'closed_servicecase_fullaccess', NULL, '') ON CONFLICT DO NOTHING;

INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('7851f804-10f9-46fa-908a-fa86efbb4a31', '05b1e8d6-9f89-43c2-9138-52bde88f2f16', '010f6b83-5a5a-44ef-85d0-a6515564c663', 1, 'RBAC', now(), 'CIDM-8151',now(), true, NULL, NULL, NULL) ON CONFLICT DO NOTHING;

-- INSERT INTO cjams.userresource
-- (userid, permissiongroupid, roleid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
-- VALUES(2969, '05b1e8d6-9f89-43c2-9138-52bde88f2f16', 36, NULL, 1, 'd2791049-8752-486a-b972-47a4375386a4', now(), 'd2791049-8752-486a-b972-47a4375386a4', now(), NULL, NULL, NULL, NULL);
