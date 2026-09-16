delete from pgresource where pgresourceid in ('80a38a11-421d-4fb0-bbc8-344c0ef7ee40','76110113-c5bc-4277-8c2f-26079de1feec','0e3b8fea-7194-4aa3-84bd-d6f2709a1532',
'b8b07874-1dad-4ea8-88eb-6c18fbb1a0a3','18d4d175-b430-40e2-af20-cd7c2ae49e1f','5f3747a8-d703-46f1-b4e0-ca2b7670fdca','5f19216d-6fb1-4bd6-99f9-9d2d87e3fbac');
delete from resource where id in ('d52ffcea-94d7-48c4-9faf-9f8a443ce67e');
INSERT INTO cjams.resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('d52ffcea-94d7-48c4-9faf-9f8a443ce67e', NULL, 'Private-Provider', 1, 1, NULL, '2019-07-16 14:42:14.070', NULL, '2019-07-16 14:42:14.070', NULL, NULL, NULL, NULL, NULL, NULL);



INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('80a38a11-421d-4fb0-bbc8-344c0ef7ee40', '1f00ac77-2eb3-4366-b94e-0551c4db2ae3', 'd52ffcea-94d7-48c4-9faf-9f8a443ce67e', 1, 'admin', '2019-07-16 15:21:33.054', 'admin', '2019-07-16 15:21:33.054', true, true, true, NULL);
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('76110113-c5bc-4277-8c2f-26079de1feec', '2c7b54d6-8246-415a-ab6a-d6f79fdc4ca9', 'd52ffcea-94d7-48c4-9faf-9f8a443ce67e', 1, 'admin', '2019-07-16 15:34:19.842', 'admin', '2019-07-16 15:34:19.842', true, true, true, NULL);
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('0e3b8fea-7194-4aa3-84bd-d6f2709a1532', 'dd187b34-f57f-4f7a-9ec0-e23eb8588b04', 'd52ffcea-94d7-48c4-9faf-9f8a443ce67e', 1, 'admin', '2019-07-16 15:36:20.399', 'admin', '2019-07-16 15:36:20.399', true, true, true, NULL);
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('b8b07874-1dad-4ea8-88eb-6c18fbb1a0a3', '9ea6d3ed-8b2b-4e4e-b715-5e2eae0d705a', 'd52ffcea-94d7-48c4-9faf-9f8a443ce67e', 1, 'admin', '2019-07-16 15:37:11.451', 'admin', '2019-07-16 15:37:11.451', true, true, true, NULL);
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('18d4d175-b430-40e2-af20-cd7c2ae49e1f', '2ec826f1-d4e2-441c-8f6e-9fc679dfa20a', 'd52ffcea-94d7-48c4-9faf-9f8a443ce67e', 1, 'admin', '2019-07-16 15:40:45.094', 'admin', '2019-07-16 15:40:45.094', true, true, true, NULL);
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('5f3747a8-d703-46f1-b4e0-ca2b7670fdca', 'ebe5eaba-d3b9-4ad6-b89e-54af1f1f9575', 'd52ffcea-94d7-48c4-9faf-9f8a443ce67e', 1, 'admin', '2019-07-16 15:41:26.108', 'admin', '2019-07-16 15:41:26.108', true, true, true, NULL);
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('5f19216d-6fb1-4bd6-99f9-9d2d87e3fbac', 'd9ac5da2-3a63-4efd-bb13-ea4c9a9cf11b', 'd52ffcea-94d7-48c4-9faf-9f8a443ce67e', 1, 'admin', '2019-07-16 15:42:50.313', 'admin', '2019-07-16 15:42:50.313', true, true, true, NULL);




