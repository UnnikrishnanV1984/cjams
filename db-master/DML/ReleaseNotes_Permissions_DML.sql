DELETE FROM cjams.userresource WHERE permissiongroupid = '47f6e4ac-6482-4be8-8918-3f362d465012';
DELETE FROM cjams.userresource WHERE permissiongroupid = 'a0f20b7c-7567-4aa4-90ea-0284ed06ba04';
DELETE FROM cjams.permissiongroup WHERE permissiongroupid = '47f6e4ac-6482-4be8-8918-3f362d465012';
DELETE FROM cjams.permissiongroup WHERE permissiongroupid = 'a0f20b7c-7567-4aa4-90ea-0284ed06ba04';

INSERT INTO cjams.permissiongroup
(permissiongroupid, permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('47f6e4ac-6482-4be8-8918-3f362d465012', 'RELEASE_APPROVER', 'Release Approver', 1, 'admin', 'admin', now(), now(), NULL);

INSERT INTO cjams.permissiongroup
(permissiongroupid, permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('a0f20b7c-7567-4aa4-90ea-0284ed06ba04', 'RELEASE_ADMIN', 'Release Admin', 1, 'admin', 'admin', now(), now(), NULL);

INSERT INTO cjams.userresource
(userresourceid, userid, permissiongroupid, roleid, resourceid, activeflag, isallowed, isvisible, isenabled, insertedby, insertedon, updatedby, updatedon)
VALUES(gen_random_uuid(), (select id from cjams.muser where lower(email) like 'shan.chockalingam@maryland.gov' limit 1), '47f6e4ac-6482-4be8-8918-3f362d465012', NULL, NULL, 1, true, true, true, 'admin', now(), 'admin', now());

INSERT INTO cjams.userresource
(userresourceid, userid, permissiongroupid, roleid, resourceid, activeflag, isallowed, isvisible, isenabled, insertedby, insertedon, updatedby, updatedon)
VALUES(gen_random_uuid(), (select id from cjams.muser where lower(email) like 'sakthi.rajan@maryland.gov' limit 1), 'a0f20b7c-7567-4aa4-90ea-0284ed06ba04', NULL, NULL, 1, true, true, true, 'admin', now(), 'admin', now());

INSERT INTO cjams.userresource
(userresourceid, userid, permissiongroupid, roleid, resourceid, activeflag, isallowed, isvisible, isenabled, insertedby, insertedon, updatedby, updatedon)
VALUES(gen_random_uuid(), (select id from cjams.muser where lower(email) like 'vinod.erakkat@maryland.gov' limit 1), 'a0f20b7c-7567-4aa4-90ea-0284ed06ba04', NULL, NULL, 1, true, true, true, 'admin', now(), 'admin', now());

