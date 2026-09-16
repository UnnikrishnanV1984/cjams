  
--Permission Groups 
INSERT INTO permissiongroup
(permissiongroupid, permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('57a390b8-3387-428a-97a8-0b8559fd1f1e', 'DIRECTOR APPROVAL', '', 1, 'admin', 'admin', '2019-07-02 04:14:58.000', '2019-07-02 04:15:54.000', NULL);
INSERT INTO permissiongroup
(permissiongroupid, permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('2a2f16c1-3c3d-48cb-93ac-fb60956fa42a', 'FINANCE APPROVAL', '', 1, 'admin', 'admin', '2019-06-30 19:09:09.987', '2019-07-01 19:10:36.000', NULL);
 
--pgresource
INSERT INTO pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('a6a294eb-b56a-49fb-a0c8-3dc913d90b43', '2a2f16c1-3c3d-48cb-93ac-fb60956fa42a', '97eb840b-0102-4cae-b234-941ffeb14d67', 1, 'admin', '2019-06-30 19:10:10.000', 'admin', '2019-06-30 19:10:10.000', true, NULL, NULL, NULL);
INSERT INTO pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('a94eaed7-0c86-44ed-93b0-1c6522aafd85', '2a2f16c1-3c3d-48cb-93ac-fb60956fa42a', 'd5ca77df-42c1-4329-a09f-6b7d99b45143', 1, 'admin', '2019-06-30 19:10:10.000', 'admin', '2019-06-30 19:10:10.000', true, NULL, NULL, NULL);
INSERT INTO pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('1857542f-1485-4e81-a149-b679a1c19b4b', '57a390b8-3387-428a-97a8-0b8559fd1f1e', '031b845a-66e1-4e71-9585-eff2e17681d6', 1, 'admin', '2019-07-02 04:15:54.000', 'admin', '2019-07-02 04:15:54.000', true, NULL, NULL, NULL);

