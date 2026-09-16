delete from cjams.permissiongroup where permissiongroupname='CJAMS_CW_CASE_MGMT_SPECIALIST' and permissiongroupid='0388441d-afe8-4aff-9553-a192e6fca30f';

INSERT INTO cjams.permissiongroup
(permissiongroupid, permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('0388441d-afe8-4aff-9553-a192e6fca30f', 'CJAMS_CW_CASE_MGMT_SPECIALIST', 'Case Management Specialist,CW', 1, 'CIDM-7971', 'CIDM-7971', now(), now(), NULL);

delete from cjams.role_resource where roleid=135 and resourceid='0388441d-afe8-4aff-9553-a192e6fca30f' and activeflag=1 ;
INSERT INTO cjams.role_resource
(id, roleid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, permissiontype, old_id)
VALUES(gen_random_uuid(), 135, '0388441d-afe8-4aff-9553-a192e6fca30f', 1, 'CIDM-7971', now(), 'CIDM-7971', now(), true, true, true, 1, NULL);

delete from cjams.resource where resourcename='CJAMS_CW_CASE_MGMT_SPECIALIST' and resourceid='CJAMS_CW_CASE_MGMT_SPECIALIST' and activeflag=1;

INSERT INTO cjams.resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('9a9bba68-5a6d-4db5-8515-4f8156f00d0f', NULL, 'CJAMS_CW_CASE_MGMT_SPECIALIST', 2, 1, 'CIDM-7971', now(), 'CIDM-7971', now(), 'CJAMS_CW_CASE_MGMT_SPECIALIST', NULL, NULL, 'CJAMS_CW_CASE_MGMT_SPECIALIST', NULL, '');

delete from cjams.pgresource where permissiongroupid='0388441d-afe8-4aff-9553-a192e6fca30f' and resourceid='9a9bba68-5a6d-4db5-8515-4f8156f00d0f' and activeflag=1;
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES(gen_random_uuid(), '0388441d-afe8-4aff-9553-a192e6fca30f', '9a9bba68-5a6d-4db5-8515-4f8156f00d0f', 1, 'CIDM-7971', now(), 'CIDM-7971', now(), true, NULL, NULL, NULL);



--troy.robinson@maryland.gov
delete from cjams.userresource where roleid=135 and userid=7049 and permissiongroupid='0388441d-afe8-4aff-9553-a192e6fca30f' and activeflag=1;
INSERT INTO cjams.userresource
(userresourceid, userid, permissiongroupid, roleid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES(gen_random_uuid(), 7049, '0388441d-afe8-4aff-9553-a192e6fca30f', 135, NULL, 1, 'CIDM-7971', now(), 'CIDM-7971', now(), true, true, true, NULL);

--ataylor@maryland.gov

delete from cjams.userresource where roleid=135 and userid=7111 and permissiongroupid='0388441d-afe8-4aff-9553-a192e6fca30f' and activeflag=1;
INSERT INTO cjams.userresource
(userresourceid, userid, permissiongroupid, roleid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES(gen_random_uuid(), 7111, '0388441d-afe8-4aff-9553-a192e6fca30f', 135, NULL, 1, 'CIDM-7971', now(), 'CIDM-7971', now(), true, true, true, NULL);

--alvin.winn@maryland.gov

delete from cjams.userresource where roleid=135 and userid=7692 and permissiongroupid='0388441d-afe8-4aff-9553-a192e6fca30f' and activeflag=1;
INSERT INTO cjams.userresource
(userresourceid, userid, permissiongroupid, roleid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES(gen_random_uuid(), 7692, '0388441d-afe8-4aff-9553-a192e6fca30f', 135, NULL, 1, 'CIDM-7971', now(), 'CIDM-7971', now(), true, true, true, NULL);

