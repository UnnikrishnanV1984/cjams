INSERT INTO resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('163db570-7143-4f7a-a59a-f19b81ecf8a9', NULL, 'manage_ldss_transfer', 4, 1, 'admin', '2019-09-20 05:30:37.000', 'admin', '2019-09-20 05:30:37.000', 'manage_ldss_transfer', NULL, NULL, 'Manage LDSS Transfer', NULL, 'ldsstransrer')ON CONFLICT DO NOTHING;
INSERT INTO resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('8a997f8e-4a39-4d16-909f-408657a2afe9', NULL, 'LDSS Inbox', 1, 1, 'admin', '2019-09-20 05:29:51.000', 'admin', '2019-09-20 05:29:51.000', 'ldssinbox', NULL, NULL, 'LDSS Inbox', NULL, 'ldsstransfer')ON CONFLICT DO NOTHING;

