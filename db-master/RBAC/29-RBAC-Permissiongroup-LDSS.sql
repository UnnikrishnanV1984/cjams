
INSERT INTO permissiongroup
(permissiongroupid, permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('2012ab8d-7b5b-43ba-821f-a991a091a567', 'LDSS TRANSFER', '', 1, 'admin', 'admin', '2019-09-20 05:34:35.000', '2019-09-20 05:35:18.000', NULL)ON CONFLICT DO NOTHING;

INSERT INTO pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('9f4d8958-fdd1-47d2-9a0e-cde699adf48f', '2012ab8d-7b5b-43ba-821f-a991a091a567', '8a997f8e-4a39-4d16-909f-408657a2afe9', 1, 'admin', '2019-09-20 05:35:18.000', 'admin', '2019-09-20 05:35:18.000', true, true, NULL, NULL)ON CONFLICT DO NOTHING;
INSERT INTO pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('c5f467c4-1dd7-4c2b-a850-d8b233a161be', '2012ab8d-7b5b-43ba-821f-a991a091a567', '163db570-7143-4f7a-a59a-f19b81ecf8a9', 1, 'admin', '2019-09-20 05:35:18.000', 'admin', '2019-09-20 05:35:18.000', true, true, NULL, NULL)ON CONFLICT DO NOTHING;
