/*Resource Insert*/
INSERT INTO resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('7e4f64ee-c6df-430a-8671-f0eb004e4f9b', NULL, 'manage_fostercare_rates', 4, 1, 'admin', '2019-07-25 18:29:22.000', 'admin', '2019-07-25 18:29:22.000', 'manage_fostercare_rates', NULL, NULL, 'Manage Fostercare Rate', NULL, 'Finance') ON CONFLICT DO NOTHING;

/*permissiongroup and Resource map*/
INSERT INTO permissiongroup
(permissiongroupid, permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('5c81cf55-9a90-4c4c-8047-279632dfe02f', 'MANAGE FOSTERCARE', '', 1, 'admin', 'admin', '2019-07-25 18:29:39.000', '2019-07-25 18:34:27.000', NULL)ON CONFLICT DO NOTHING;

INSERT INTO pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('5626025d-83ff-4946-b3e9-6eeeb6437711', '5c81cf55-9a90-4c4c-8047-279632dfe02f', '7e4f64ee-c6df-430a-8671-f0eb004e4f9b', 1, 'admin', '2019-07-25 18:34:27.000', 'admin', '2019-07-25 18:34:27.000', true, NULL, NULL, NULL)ON CONFLICT DO NOTHING;
