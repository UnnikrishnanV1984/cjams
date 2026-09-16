
INSERT INTO cjams.resource (id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey) 
VALUES('e6b7f7ca-7750-11e9-8248-2a86e4085a59', NULL, 'Inquiries', 1, 1, 'admin', now(), 'admin',now(), NULL, NULL, NULL, NULL, NULL, NULL) ;
INSERT INTO cjams.resource (id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey) 
VALUES('e6b7faae-7750-11e9-8248-2a86e4085a59', NULL, 'Pre-Apps/Applications', 1, 1, 'admin', now(), 'admin',now(), NULL, NULL, NULL, NULL, NULL, NULL) ;
INSERT INTO cjams.resource (id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey) 
VALUES('e6b7fc0c-7750-11e9-8248-2a86e4085a59', NULL, 'Providers', 1, 1, 'admin', now(), 'admin',now(), NULL, NULL, NULL, NULL, NULL, NULL) ;
INSERT INTO cjams.resource (id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey) 
VALUES('e6b8009e-7750-11e9-8248-2a86e4085a59', NULL, 'Training', 1, 1, 'admin', now(), 'admin',now(), NULL, NULL, NULL, NULL, NULL, NULL) ;
INSERT INTO cjams.resource (id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey) 
VALUES('e6b8021a-7750-11e9-8248-2a86e4085a59', NULL, 'Complaints', 1, 1, 'admin', now(), 'admin',now(), NULL, NULL, NULL, NULL, NULL, NULL) ;
INSERT INTO cjams.resource (id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey) 
VALUES('e59c551c-091c-4ee6-86b9-946f99926224', NULL, 'Provider Admin', 1, 1, 'admin', now(), 'admin',now(), NULL, NULL, NULL, NULL, NULL, NULL) ;


INSERT INTO cjams.permissiongroup
(permissiongroupid, permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('0710b4c6-af95-4654-b0b0-e8ff798c0824', 'LDSS DIRECTOR', 'LDSS DIRECTOR', 1, 'admin', 'S-1-5-21-152097760-152508613-1969071786-500', '2019-04-29 16:52:29.855', '2019-04-29 13:51:19.000', NULL);
INSERT INTO cjams.permissiongroup
(permissiongroupid, permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('e9dc6a81-ba1f-4a37-874e-8221d732e71f', 'LDSS HOMESTUDY WORKER', 'LDSS HOMESTUDY WORKER', 1, 'admin', 'S-1-5-21-152097760-152508613-1969071786-500', '2019-04-29 16:52:29.855', '2019-04-29 13:51:19.000', NULL);
INSERT INTO cjams.permissiongroup
(permissiongroupid, permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('0f301e00-fe1b-4d82-ae59-2c8278e8b8ee', 'LDSS RECRUITER TRAINER', 'LDSS RECRUITER TRAINER', 1, 'admin', 'S-1-5-21-152097760-152508613-1969071786-500', '2019-04-29 16:52:29.855', '2019-04-29 13:51:19.000', NULL);
INSERT INTO cjams.permissiongroup
(permissiongroupid, permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('520f71a8-53f1-41b2-865a-cc08625cd2c4', 'LDSS RESOURCE WORKER', 'LDSS RESOURCE WORKER', 1, 'admin', 'S-1-5-21-152097760-152508613-1969071786-500', '2019-04-29 16:52:29.855', '2019-04-29 13:51:19.000', NULL);
INSERT INTO cjams.permissiongroup
(permissiongroupid, permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('07f78a48-b1d1-4209-82f2-e59d2aaf31c7', 'LDSS SUPERVISOR', 'LDSS SUPERVISOR', 1, 'admin', 'S-1-5-21-152097760-152508613-1969071786-500', '2019-04-29 16:52:29.855', '2019-04-29 13:51:19.000', NULL);

INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('ebe0251c-2917-44db-b0b4-9774b40ede59', '0710b4c6-af95-4654-b0b0-e8ff798c0824', 'e6b7f7ca-7750-11e9-8248-2a86e4085a59', 1, 'admin', '2019-04-29 16:53:16.551', 'admin', '2019-04-29 16:53:16.551', true, true, true, NULL);
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('00fef5b9-22a8-4b53-886b-8544a7af7fab', '0710b4c6-af95-4654-b0b0-e8ff798c0824', 'e6b7faae-7750-11e9-8248-2a86e4085a59', 1, 'admin', '2019-04-29 16:53:16.551', 'admin', '2019-04-29 16:53:16.551', true, true, true, NULL);
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('5c6158d7-a960-4477-b3c0-c02c80c9236c', '0710b4c6-af95-4654-b0b0-e8ff798c0824', 'e6b7fc0c-7750-11e9-8248-2a86e4085a59', 1, 'admin', '2019-04-29 16:53:16.551', 'admin', '2019-04-29 16:53:16.551', true, true, true, NULL);
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('ce80090c-ce82-4ba2-b83d-c306d5e97188', '0710b4c6-af95-4654-b0b0-e8ff798c0824', 'e6b8009e-7750-11e9-8248-2a86e4085a59', 1, 'admin', '2019-04-29 16:53:16.551', 'admin', '2019-04-29 16:53:16.551', true, true, true, NULL);
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('65604184-942b-426a-9b03-a62d41fdf86e', '0710b4c6-af95-4654-b0b0-e8ff798c0824', 'e6b8021a-7750-11e9-8248-2a86e4085a59', 1, 'admin', '2019-04-29 16:53:16.551', 'admin', '2019-04-29 16:53:16.551', true, true, true, NULL);
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('92b53b98-071f-4bca-b115-8216ec1271ec', '0710b4c6-af95-4654-b0b0-e8ff798c0824', 'e59c551c-091c-4ee6-86b9-946f99926224', 1, 'admin', '2019-04-29 16:53:16.551', 'admin', '2019-04-29 16:53:16.551', true, true, true, NULL);

INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('752429fb-c1fa-4b63-adf1-cd65d1f414fe', 'e9dc6a81-ba1f-4a37-874e-8221d732e71f', 'e6b7f7ca-7750-11e9-8248-2a86e4085a59', 1, 'admin', '2019-04-29 16:53:16.551', 'admin', '2019-04-29 16:53:16.551', true, true, true, NULL);
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('6f89dfbe-e786-478d-bfca-78cc873ca726', 'e9dc6a81-ba1f-4a37-874e-8221d732e71f', 'e6b7faae-7750-11e9-8248-2a86e4085a59', 1, 'admin', '2019-04-29 16:53:16.551', 'admin', '2019-04-29 16:53:16.551', true, true, true, NULL);
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('6b501c1f-39ba-4f7f-b395-ad507421ac5b', 'e9dc6a81-ba1f-4a37-874e-8221d732e71f', 'e6b7fc0c-7750-11e9-8248-2a86e4085a59', 1, 'admin', '2019-04-29 16:53:16.551', 'admin', '2019-04-29 16:53:16.551', true, true, true, NULL);
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('0dff8e96-81eb-4d4f-862f-387f0912963b', 'e9dc6a81-ba1f-4a37-874e-8221d732e71f', 'e6b8009e-7750-11e9-8248-2a86e4085a59', 1, 'admin', '2019-04-29 16:53:16.551', 'admin', '2019-04-29 16:53:16.551', true, true, true, NULL);
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('e7f23e96-806f-4765-8d10-f4abbc768ed5', 'e9dc6a81-ba1f-4a37-874e-8221d732e71f', 'e6b8021a-7750-11e9-8248-2a86e4085a59', 1, 'admin', '2019-04-29 16:53:16.551', 'admin', '2019-04-29 16:53:16.551', true, true, true, NULL);
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('171fa402-b615-4c02-a1d8-7aef61752a45', 'e9dc6a81-ba1f-4a37-874e-8221d732e71f', 'e59c551c-091c-4ee6-86b9-946f99926224', 1, 'admin', '2019-04-29 16:53:16.551', 'admin', '2019-04-29 16:53:16.551', true, true, true, NULL);


INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('76c8da9e-a4bb-48ea-b8f1-e329804deab7', '0f301e00-fe1b-4d82-ae59-2c8278e8b8ee', 'e6b7f7ca-7750-11e9-8248-2a86e4085a59', 1, 'admin', '2019-04-29 16:53:16.551', 'admin', '2019-04-29 16:53:16.551', true, true, true, NULL);
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('64ad4827-73af-4e03-b26c-9bdddc8a9e92', '0f301e00-fe1b-4d82-ae59-2c8278e8b8ee', 'e6b7faae-7750-11e9-8248-2a86e4085a59', 1, 'admin', '2019-04-29 16:53:16.551', 'admin', '2019-04-29 16:53:16.551', true, true, true, NULL);
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('1be93fa4-e498-402b-998d-a25cd5ad889b', '0f301e00-fe1b-4d82-ae59-2c8278e8b8ee', 'e6b7fc0c-7750-11e9-8248-2a86e4085a59', 1, 'admin', '2019-04-29 16:53:16.551', 'admin', '2019-04-29 16:53:16.551', true, true, true, NULL);
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('d45bada7-ad22-4a0f-a5cb-0c9abbe871dc', '0f301e00-fe1b-4d82-ae59-2c8278e8b8ee', 'e6b8009e-7750-11e9-8248-2a86e4085a59', 1, 'admin', '2019-04-29 16:53:16.551', 'admin', '2019-04-29 16:53:16.551', true, true, true, NULL);
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('46b25fa7-f15e-432a-9e04-0c2aafc1504f', '0f301e00-fe1b-4d82-ae59-2c8278e8b8ee', 'e6b8021a-7750-11e9-8248-2a86e4085a59', 1, 'admin', '2019-04-29 16:53:16.551', 'admin', '2019-04-29 16:53:16.551', true, true, true, NULL);
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('a835c420-621d-4d39-87d0-bf20cf51ff29', '0f301e00-fe1b-4d82-ae59-2c8278e8b8ee', 'e59c551c-091c-4ee6-86b9-946f99926224', 1, 'admin', '2019-04-29 16:53:16.551', 'admin', '2019-04-29 16:53:16.551', true, true, true, NULL);

INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('ae360b8e-01e9-44bc-bbe9-2695f298b919', '520f71a8-53f1-41b2-865a-cc08625cd2c4', 'e6b7f7ca-7750-11e9-8248-2a86e4085a59', 1, 'admin', '2019-04-29 16:53:16.551', 'admin', '2019-04-29 16:53:16.551', true, true, true, NULL);
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('e10ff0a1-a9d5-43f0-b625-82cde4044887', '520f71a8-53f1-41b2-865a-cc08625cd2c4', 'e6b7faae-7750-11e9-8248-2a86e4085a59', 1, 'admin', '2019-04-29 16:53:16.551', 'admin', '2019-04-29 16:53:16.551', true, true, true, NULL);
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('ca67f280-c22b-4137-b07a-901dd7d99c31', '520f71a8-53f1-41b2-865a-cc08625cd2c4', 'e6b7fc0c-7750-11e9-8248-2a86e4085a59', 1, 'admin', '2019-04-29 16:53:16.551', 'admin', '2019-04-29 16:53:16.551', true, true, true, NULL);
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('f3e2fdb5-bebf-4673-8ce5-81bfb19f4b21', '520f71a8-53f1-41b2-865a-cc08625cd2c4', 'e6b8009e-7750-11e9-8248-2a86e4085a59', 1, 'admin', '2019-04-29 16:53:16.551', 'admin', '2019-04-29 16:53:16.551', true, true, true, NULL);
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('aa5d99a4-0b69-4627-b397-700e1432799b', '520f71a8-53f1-41b2-865a-cc08625cd2c4', 'e6b8021a-7750-11e9-8248-2a86e4085a59', 1, 'admin', '2019-04-29 16:53:16.551', 'admin', '2019-04-29 16:53:16.551', true, true, true, NULL);
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('89726a02-c8b3-4ef7-a5fb-07d14ea6bacb', '520f71a8-53f1-41b2-865a-cc08625cd2c4', 'e59c551c-091c-4ee6-86b9-946f99926224', 1, 'admin', '2019-04-29 16:53:16.551', 'admin', '2019-04-29 16:53:16.551', true, true, true, NULL);


INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('9b5ec73c-a266-4d02-9e30-dbe4e0ca309f', '07f78a48-b1d1-4209-82f2-e59d2aaf31c7', 'e6b7f7ca-7750-11e9-8248-2a86e4085a59', 1, 'admin', '2019-04-29 16:53:16.551', 'admin', '2019-04-29 16:53:16.551', true, true, true, NULL);
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('10633a54-4e60-41bc-99cb-061d720231fe', '07f78a48-b1d1-4209-82f2-e59d2aaf31c7', 'e6b7faae-7750-11e9-8248-2a86e4085a59', 1, 'admin', '2019-04-29 16:53:16.551', 'admin', '2019-04-29 16:53:16.551', true, true, true, NULL);
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('e908edc8-6b12-43b7-9b8c-4792adc202fc', '07f78a48-b1d1-4209-82f2-e59d2aaf31c7', 'e6b7fc0c-7750-11e9-8248-2a86e4085a59', 1, 'admin', '2019-04-29 16:53:16.551', 'admin', '2019-04-29 16:53:16.551', true, true, true, NULL);
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('bd65567e-81b4-405d-b389-cea05b49602f', '07f78a48-b1d1-4209-82f2-e59d2aaf31c7', 'e6b8009e-7750-11e9-8248-2a86e4085a59', 1, 'admin', '2019-04-29 16:53:16.551', 'admin', '2019-04-29 16:53:16.551', true, true, true, NULL);
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('a2540e50-2847-4f79-abb8-904f925edc81', '07f78a48-b1d1-4209-82f2-e59d2aaf31c7', 'e6b8021a-7750-11e9-8248-2a86e4085a59', 1, 'admin', '2019-04-29 16:53:16.551', 'admin', '2019-04-29 16:53:16.551', true, true, true, NULL);
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('253cc855-9617-47ec-889b-af276ce2063c', '07f78a48-b1d1-4209-82f2-e59d2aaf31c7', 'e59c551c-091c-4ee6-86b9-946f99926224', 1, 'admin', '2019-04-29 16:53:16.551', 'admin', '2019-04-29 16:53:16.551', true, true, true, NULL);


INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('ecaa06aa-5ccd-4fba-ba22-c3352ed984dd', '07f78a48-b1d1-4209-82f2-e59d2aaf31c7', 'e96bd18c-52d6-416d-8d48-7a347d307149', 1, 'admin', '2019-04-29 16:53:16.551', 'admin', '2019-04-29 16:53:16.551', true, true, true, NULL);
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('d5329c03-5ac2-42f6-aa46-123c02679c63', '520f71a8-53f1-41b2-865a-cc08625cd2c4', 'e96bd18c-52d6-416d-8d48-7a347d307149', 1, 'admin', '2019-04-29 16:53:16.551', 'admin', '2019-04-29 16:53:16.551', true, true, true, NULL);
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('68a25a71-b1c3-4fa3-98f3-4760ad722bf9', '0f301e00-fe1b-4d82-ae59-2c8278e8b8ee', 'e96bd18c-52d6-416d-8d48-7a347d307149', 1, 'admin', '2019-04-29 16:53:16.551', 'admin', '2019-04-29 16:53:16.551', true, true, true, NULL);
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('9d7cc673-2213-4e25-94ab-51f4796bf520', 'e9dc6a81-ba1f-4a37-874e-8221d732e71f', 'e96bd18c-52d6-416d-8d48-7a347d307149', 1, 'admin', '2019-04-29 16:53:16.551', 'admin', '2019-04-29 16:53:16.551', true, true, true, NULL);
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('46e756e0-3604-43c4-be94-c79b4e30c0ef', '0710b4c6-af95-4654-b0b0-e8ff798c0824', 'e96bd18c-52d6-416d-8d48-7a347d307149', 1, 'admin', '2019-04-29 16:53:16.551', 'admin', '2019-04-29 16:53:16.551', true, true, true, NULL);


INSERT INTO cjams.role_resource
(id, roleid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, permissiontype, old_id)
VALUES('bd6eac4a-a988-45ca-8bc7-d0414a43a42a', 2450, '0710b4c6-af95-4654-b0b0-e8ff798c0824', 1, 'admin', '2019-04-29 16:53:58.298', 'admin', '2019-04-29 16:53:58.298', true, true, true, 1, NULL);

INSERT INTO cjams.role_resource
(id, roleid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, permissiontype, old_id)
VALUES('45b4fb43-63f2-4a3a-92f2-7a3ccca767cd', 2451, 'e9dc6a81-ba1f-4a37-874e-8221d732e71f', 1, 'admin', '2019-04-29 16:53:58.298', 'admin', '2019-04-29 16:53:58.298', true, true, true, 1, NULL);

INSERT INTO cjams.role_resource
(id, roleid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, permissiontype, old_id)
VALUES('d5c56a2a-60ff-4ea5-9d1f-f34a7214548b', 2452, '0f301e00-fe1b-4d82-ae59-2c8278e8b8ee', 1, 'admin', '2019-04-29 16:53:58.298', 'admin', '2019-04-29 16:53:58.298', true, true, true, 1, NULL);

INSERT INTO cjams.role_resource
(id, roleid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, permissiontype, old_id)
VALUES('f2d13483-a62e-43fe-88fc-acf56cbf8ef3', 2453, '520f71a8-53f1-41b2-865a-cc08625cd2c4', 1, 'admin', '2019-04-29 16:53:58.298', 'admin', '2019-04-29 16:53:58.298', true, true, true, 1, NULL);

INSERT INTO cjams.role_resource
(id, roleid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, permissiontype, old_id)
VALUES('d3bc25ae-acf0-46ec-9007-dfae8c7ba6de', 2454, '07f78a48-b1d1-4209-82f2-e59d2aaf31c7', 1, 'admin', '2019-04-29 16:53:58.298', 'admin', '2019-04-29 16:53:58.298', true, true, true, 1, NULL);


INSERT INTO cjams.rolemapping
(id, principaltype, principalid, roleid, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(49508, 'USER', '2634', 2451, 1, 'admin', 'admin', '2019-03-24 19:05:16.553', '2019-03-24 19:05:16.553', NULL) on conflict ON constraint rolemapping_pk do nothing;
INSERT INTO cjams.rolemapping
(id, principaltype, principalid, roleid, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(49509, 'USER', '2635', 2452, 1, 'admin', 'admin', '2019-03-24 19:05:16.553', '2019-03-24 19:05:16.553', NULL) on conflict ON constraint rolemapping_pk do nothing;
INSERT INTO cjams.rolemapping
(id, principaltype, principalid, roleid, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(49510, 'USER', '2636', 2453, 1, 'admin', 'admin', '2019-03-24 19:05:16.553', '2019-03-24 19:05:16.553', NULL) on conflict ON constraint rolemapping_pk do nothing;
INSERT INTO cjams.rolemapping
(id, principaltype, principalid, roleid, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(49511, 'USER', '2637', 2454, 1, 'admin', 'admin', '2019-03-24 19:05:16.553', '2019-03-24 19:05:16.553', NULL) on conflict ON constraint rolemapping_pk do nothing;

