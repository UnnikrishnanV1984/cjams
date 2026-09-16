INSERT INTO cjams.permissiongroup
(permissiongroupid, permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('76e4d307-fc54-491f-a28c-e8417bfa7881', 'MANAGE WORKLOAD', '', 1, 'admin', 'admin', '2019-11-05 06:57:56.000', '2019-11-05 07:03:16.000', NULL) ON CONFLICT DO NOTHING;

INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('27271719-b087-46eb-85c5-1aafba11b9c8', '76e4d307-fc54-491f-a28c-e8417bfa7881', 'b2d1a3fb-3d0c-43a8-8284-900f551e9382', 1, 'admin', '2019-11-05 07:03:16.000', 'admin', '2019-11-05 07:03:16.000', true, true, true, NULL)ON CONFLICT DO NOTHING;
