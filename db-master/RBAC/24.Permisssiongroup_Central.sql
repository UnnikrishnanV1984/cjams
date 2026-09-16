

-- permissiongroup

INSERT INTO cjams.permissiongroup
(permissiongroupid, permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('acbe007a-28e3-4e8d-abb6-70650febe34f', 'CENTRAL OFFICE FISCAL SUPERVISOR', '', 1, 'S-1-5-21-152097760-152508613-1969071786-500', 'admin', '2019-08-29 06:27:33.000', '2019-08-29 09:36:47.000', NULL)ON CONFLICT DO NOTHING;
INSERT INTO cjams.permissiongroup
(permissiongroupid, permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('59bcd395-be08-4856-8958-65cb17f5a6c4', 'CENTRAL OFFICE FISCAL STAFF ', '', 1, 'admin', 'admin', '2019-08-29 06:26:39.000', '2019-08-29 09:53:58.000', NULL)ON CONFLICT DO NOTHING;




-- resource mapping 


INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('161b1c99-a42f-42ea-a71b-47aa632a6fa9', '59bcd395-be08-4856-8958-65cb17f5a6c4', 'a158f2c7-c1dc-40cd-b603-a4c82d3b5d9c', 1, 'admin', '2019-08-30 09:32:27.000', 'admin', '2019-08-30 09:32:27.000', true, NULL, false, NULL)ON CONFLICT DO NOTHING;
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('bbfae31d-fd9e-4f03-ba01-e534d961ec98', '59bcd395-be08-4856-8958-65cb17f5a6c4', '2e83f277-9e09-4dd6-be2a-7191a7ed3305', 1, 'admin', '2019-08-30 09:32:27.000', 'admin', '2019-08-30 09:32:27.000', true, NULL, false, NULL)ON CONFLICT DO NOTHING;
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('497d9b78-0b1a-414c-90d8-1dd779ca1369', '59bcd395-be08-4856-8958-65cb17f5a6c4', '68f62424-b6cc-48ed-8820-b34107022162', 1, 'admin', '2019-08-30 09:32:27.000', 'admin', '2019-08-30 09:32:27.000', false, false, false, NULL)ON CONFLICT DO NOTHING;
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('22311406-043b-4ddb-a77c-5099a77258c0', '59bcd395-be08-4856-8958-65cb17f5a6c4', 'c68d8222-3dfc-4f51-9713-a6784fd44889', 1, 'admin', '2019-08-30 09:32:27.000', 'admin', '2019-08-30 09:32:27.000', true, true, false, NULL)ON CONFLICT DO NOTHING;
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('3cee2328-54a5-4e8e-bcdb-c6cf391fa928', '59bcd395-be08-4856-8958-65cb17f5a6c4', 'f924dede-7242-4011-9364-feb7a1181540', 1, 'admin', '2019-08-30 09:32:27.000', 'admin', '2019-08-30 09:32:27.000', true, NULL, false, NULL)ON CONFLICT DO NOTHING;
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('60c59201-6f7e-42bc-be5b-978d5be35f4d', '59bcd395-be08-4856-8958-65cb17f5a6c4', 'c09dfb90-ea02-439e-9e32-baf4591c75d9', 1, 'admin', '2019-08-30 09:37:45.000', 'admin', '2019-08-30 09:37:45.000', NULL, NULL, true, NULL)ON CONFLICT DO NOTHING;
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('aae881ec-1f26-4b4e-a07b-50485d7a12f0', '59bcd395-be08-4856-8958-65cb17f5a6c4', 'bbdd2b08-e961-4c63-9080-0cebf7c7bef2', 1, 'admin', '2019-08-30 09:37:45.000', 'admin', '2019-08-30 09:37:45.000', NULL, NULL, true, NULL)ON CONFLICT DO NOTHING;
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('ca1c0f04-c63d-4697-bd8f-d4b7923ca15e', '59bcd395-be08-4856-8958-65cb17f5a6c4', '77e0d145-e81f-4dac-a746-fa0633ae5f17', 1, 'admin', '2019-08-30 09:37:45.000', 'admin', '2019-08-30 09:37:45.000', NULL, NULL, true, NULL)ON CONFLICT DO NOTHING;
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('3bedbdbf-9867-471a-849c-c79b7d661199', '59bcd395-be08-4856-8958-65cb17f5a6c4', 'dfc869c5-41d1-499c-98bc-b36d5e50a6b9', 1, 'admin', '2019-08-30 09:37:45.000', 'admin', '2019-08-30 09:37:45.000', NULL, NULL, true, NULL)ON CONFLICT DO NOTHING;
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('ab3102a7-88c3-45d0-a00a-ae692cb4ba7e', '59bcd395-be08-4856-8958-65cb17f5a6c4', '214990a3-c173-4cb3-a6ab-188b53d0b4f7', 1, 'admin', '2019-08-30 09:37:45.000', 'admin', '2019-08-30 09:37:45.000', NULL, NULL, true, NULL)ON CONFLICT DO NOTHING;
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('38da1640-afda-4ee4-a481-a010b0e71e33', '59bcd395-be08-4856-8958-65cb17f5a6c4', 'd6cc707f-3cbe-4e3e-a287-bbffa38cd18d', 1, 'admin', '2019-08-30 09:37:45.000', 'admin', '2019-08-30 09:37:45.000', NULL, NULL, true, NULL)ON CONFLICT DO NOTHING;
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('6e018bb7-fd03-495f-819a-4d53efe7ee41', '59bcd395-be08-4856-8958-65cb17f5a6c4', '8747271e-172f-439c-b899-7b63c3ae99b9', 1, 'admin', '2019-08-30 09:37:45.000', 'admin', '2019-08-30 09:37:45.000', NULL, NULL, true, NULL)ON CONFLICT DO NOTHING;
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('6583e1e1-c1e3-46b4-965b-7cabb1f56383', '59bcd395-be08-4856-8958-65cb17f5a6c4', '4d84fbcd-d48a-4096-9bc6-20e8f161cf7e', 1, 'admin', '2019-08-30 09:37:45.000', 'admin', '2019-08-30 09:37:45.000', NULL, NULL, true, NULL)ON CONFLICT DO NOTHING;
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('d51f9ffb-135e-465c-962f-b9516bd9bfae', '59bcd395-be08-4856-8958-65cb17f5a6c4', '16fb6de8-e2ba-440f-a803-256135eece72', 1, 'admin', '2019-08-30 09:38:04.000', 'admin', '2019-08-30 09:38:04.000', true, true, false, NULL)ON CONFLICT DO NOTHING;
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('62560283-7ac1-4212-b5b7-d772dc7e2cf7', '59bcd395-be08-4856-8958-65cb17f5a6c4', '9746dbbe-eac3-4c14-ab9b-87aab37c1cb9', 1, 'admin', '2019-08-30 09:38:04.000', 'admin', '2019-08-30 09:38:04.000', true, true, false, NULL)ON CONFLICT DO NOTHING;
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('9cd1dc64-0577-4bf1-be59-b69ca6ee6be8', '59bcd395-be08-4856-8958-65cb17f5a6c4', '37b64154-d7b8-4219-ac47-7497aa3c06d1', 1, 'admin', '2019-08-30 09:38:04.000', 'admin', '2019-08-30 09:38:04.000', true, true, false, NULL)ON CONFLICT DO NOTHING;


INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('4020397b-8a9b-4363-bb38-1aaca99363fc', 'acbe007a-28e3-4e8d-abb6-70650febe34f', 'a158f2c7-c1dc-40cd-b603-a4c82d3b5d9c', 1, 'admin', '2019-08-30 09:39:06.000', 'admin', '2019-08-30 09:39:06.000', true, NULL, false, NULL)ON CONFLICT DO NOTHING;
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('c00748a2-fe1d-42e1-b00f-8a63e9c2dafe', 'acbe007a-28e3-4e8d-abb6-70650febe34f', '2e83f277-9e09-4dd6-be2a-7191a7ed3305', 1, 'admin', '2019-08-30 09:39:06.000', 'admin', '2019-08-30 09:39:06.000', true, NULL, false, NULL)ON CONFLICT DO NOTHING;
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('9f57f374-f00a-4fac-86e0-4c95b970a35c', 'acbe007a-28e3-4e8d-abb6-70650febe34f', 'c68d8222-3dfc-4f51-9713-a6784fd44889', 1, 'admin', '2019-08-30 09:39:06.000', 'admin', '2019-08-30 09:39:06.000', true, NULL, false, NULL)ON CONFLICT DO NOTHING;
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('8824675e-b5a5-4dc1-ba3a-aafab6ebd44a', 'acbe007a-28e3-4e8d-abb6-70650febe34f', '68f62424-b6cc-48ed-8820-b34107022162', 1, 'admin', '2019-08-30 09:39:06.000', 'admin', '2019-08-30 09:39:06.000', false, false, false, NULL)ON CONFLICT DO NOTHING;
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('d0cb1ab9-1260-4fe9-97e3-aa1eca8548f2', 'acbe007a-28e3-4e8d-abb6-70650febe34f', 'f924dede-7242-4011-9364-feb7a1181540', 1, 'admin', '2019-08-30 09:39:06.000', 'admin', '2019-08-30 09:39:06.000', true, NULL, false, NULL)ON CONFLICT DO NOTHING;
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('302e8343-4cb6-42f3-b6f8-884af34bf495', 'acbe007a-28e3-4e8d-abb6-70650febe34f', '0aa75df0-a7c5-4a5b-8d76-3e1a21c1dd76', 1, 'admin', '2019-08-30 09:39:06.000', 'admin', '2019-08-30 09:39:06.000', true, NULL, false, NULL)ON CONFLICT DO NOTHING;
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('af00f8e2-53fc-4bbe-9247-bc90b62ddc8e', 'acbe007a-28e3-4e8d-abb6-70650febe34f', '4d84fbcd-d48a-4096-9bc6-20e8f161cf7e', 1, 'admin', '2019-08-30 09:39:34.000', 'admin', '2019-08-30 09:39:34.000', NULL, NULL, true, NULL)ON CONFLICT DO NOTHING;
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('420e44e9-0538-44d6-97c0-0895bd1763db', 'acbe007a-28e3-4e8d-abb6-70650febe34f', '8747271e-172f-439c-b899-7b63c3ae99b9', 1, 'admin', '2019-08-30 09:39:34.000', 'admin', '2019-08-30 09:39:34.000', NULL, NULL, true, NULL)ON CONFLICT DO NOTHING;
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('4983d758-7162-4cb6-9f67-2733aeb85055', 'acbe007a-28e3-4e8d-abb6-70650febe34f', '3c5b1136-690e-430a-8a47-71597b082237', 1, 'admin', '2019-08-30 09:39:34.000', 'admin', '2019-08-30 09:39:34.000', NULL, NULL, true, NULL)ON CONFLICT DO NOTHING;
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('afe80c16-d089-430d-a2dd-b12984398e36', 'acbe007a-28e3-4e8d-abb6-70650febe34f', '214990a3-c173-4cb3-a6ab-188b53d0b4f7', 1, 'admin', '2019-08-30 09:39:34.000', 'admin', '2019-08-30 09:39:34.000', NULL, NULL, true, NULL)ON CONFLICT DO NOTHING;
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('297f25b4-8d30-4edd-8f1b-1a0b155b23de', 'acbe007a-28e3-4e8d-abb6-70650febe34f', 'd6cc707f-3cbe-4e3e-a287-bbffa38cd18d', 1, 'admin', '2019-08-30 09:39:34.000', 'admin', '2019-08-30 09:39:34.000', NULL, NULL, true, NULL)ON CONFLICT DO NOTHING;
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('836bb95e-6dca-4775-8f88-c36cc89d640c', 'acbe007a-28e3-4e8d-abb6-70650febe34f', 'dfc869c5-41d1-499c-98bc-b36d5e50a6b9', 1, 'admin', '2019-08-30 09:39:34.000', 'admin', '2019-08-30 09:39:34.000', NULL, NULL, true, NULL)ON CONFLICT DO NOTHING;
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('d6c9fc12-9c24-42e4-af86-cdcfa1916475', 'acbe007a-28e3-4e8d-abb6-70650febe34f', 'bbdd2b08-e961-4c63-9080-0cebf7c7bef2', 1, 'admin', '2019-08-30 09:39:34.000', 'admin', '2019-08-30 09:39:34.000', NULL, NULL, true, NULL)ON CONFLICT DO NOTHING;
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('17edf079-028f-48e4-bdce-72706c1c838f', 'acbe007a-28e3-4e8d-abb6-70650febe34f', '77e0d145-e81f-4dac-a746-fa0633ae5f17', 1, 'admin', '2019-08-30 09:39:34.000', 'admin', '2019-08-30 09:39:34.000', NULL, NULL, true, NULL)ON CONFLICT DO NOTHING;
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('6840bbbc-6e13-4bfc-8a9f-cde4cb0ecc2c', 'acbe007a-28e3-4e8d-abb6-70650febe34f', 'c09dfb90-ea02-439e-9e32-baf4591c75d9', 1, 'admin', '2019-08-30 09:39:34.000', 'admin', '2019-08-30 09:39:34.000', NULL, NULL, true, NULL)ON CONFLICT DO NOTHING;
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('0e0785a8-30de-4120-9c4d-4c69c0fdf3ec', 'acbe007a-28e3-4e8d-abb6-70650febe34f', '16fb6de8-e2ba-440f-a803-256135eece72', 1, 'admin', '2019-08-30 09:39:52.000', 'admin', '2019-08-30 09:39:52.000', true, true, false, NULL)ON CONFLICT DO NOTHING;
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('15522ed5-e12c-4d95-94e7-2ed24a101a5f', 'acbe007a-28e3-4e8d-abb6-70650febe34f', '9746dbbe-eac3-4c14-ab9b-87aab37c1cb9', 1, 'admin', '2019-08-30 09:39:52.000', 'admin', '2019-08-30 09:39:52.000', true, true, false, NULL)ON CONFLICT DO NOTHING;
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('9796ff2c-a652-49f7-a86e-79133e90fb19', 'acbe007a-28e3-4e8d-abb6-70650febe34f', '37b64154-d7b8-4219-ac47-7497aa3c06d1', 1, 'admin', '2019-08-30 09:39:52.000', 'admin', '2019-08-30 09:39:52.000', true, true, false, NULL)ON CONFLICT DO NOTHING;
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('b6e3a2c0-a254-4c78-a40b-ac287bb5a536', '59bcd395-be08-4856-8958-65cb17f5a6c4', '73b814dc-59d5-468d-9b89-d594ef2b597e', 1, 'admin', '2019-08-30 09:40:02.000', 'admin', '2019-08-30 09:40:02.000', true, NULL, false, NULL)ON CONFLICT DO NOTHING;
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('8ded2248-2207-4575-812c-95a94147db44', '59bcd395-be08-4856-8958-65cb17f5a6c4', '3c5b1136-690e-430a-8a47-71597b082237', 1, 'admin', '2019-08-30 09:37:45.000', 'admin', '2019-08-30 09:37:45.000', NULL, NULL, true, NULL)ON CONFLICT DO NOTHING;
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('109e21e5-0b09-44d6-a56c-a609fa9144a5', '59bcd395-be08-4856-8958-65cb17f5a6c4', 'a180e74e-6a33-4522-a86d-dfacf46daa48', 1, 'admin', '2019-08-30 09:45:18.000', 'admin', '2019-08-30 09:45:18.000', NULL, NULL, true, NULL)ON CONFLICT DO NOTHING;
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('4ff31046-8f8b-4868-ab57-2304147ab48e', 'acbe007a-28e3-4e8d-abb6-70650febe34f', 'a180e74e-6a33-4522-a86d-dfacf46daa48', 1, 'admin', '2019-08-30 09:45:30.000', 'admin', '2019-08-30 09:45:30.000', NULL, NULL, true, NULL)ON CONFLICT DO NOTHING;
