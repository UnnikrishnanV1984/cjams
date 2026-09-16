delete from cjams.routingconfig where targetrolekey='LDSSPM' and eventcode in ('PCAUTH','PCAUTHR') ;
INSERT INTO cjams.routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES(gen_random_uuid(), 'PCAUTH', 'LDSSPM', 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, 'CWSP', NULL, NULL, 'USER', '608dfb64-f5eb-41df-932f-1f538417791b');

 INSERT INTO cjams.routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES(gen_random_uuid(), 'PCAUTHR', 'LDSSPM', 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, 'CWSP', NULL, NULL, 'ROLE', '608dfb64-f5eb-41df-932f-1f538417791b');

delete from cjams."resource" where resourcename='bc_approval_manage_over1000';
INSERT INTO cjams."resource"
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('608dfb64-f5eb-41df-932f-1f538417791b', NULL, 'bc_approval_manage_over1000', 4, 1, 'd2791049-8752-486a-b972-47a4375386a4', '2020-05-21 10:37:18.000', 'd2791049-8752-486a-b972-47a4375386a4', '2020-05-21 10:37:18.000', 'manage_over1000_approval_bc', NULL, NULL, 'manage over1000 approval bc', NULL, 'manage_over1000_approval_bc');

delete from cjams."permissiongroup" where permissiongroupname='PROGRAM MANAGER APPROVAL';
INSERT INTO cjams.permissiongroup
(permissiongroupid, permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('5c760141-a1ff-4ae2-bbc8-5692391e3dc1', 'PROGRAM MANAGER APPROVAL', '', 1, 'd2791049-8752-486a-b972-47a4375386a4', 'd2791049-8752-486a-b972-47a4375386a4', '2020-05-21 10:47:21.000', '2020-05-21 10:47:21.000', NULL);
