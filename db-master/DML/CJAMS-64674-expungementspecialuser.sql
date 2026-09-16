-- select id from muser where email in ('andrea.barbosa1@maryland.gov','caitlin.miller@maryland.gov','elise.song@maryland.gov');

-- 13350
-- 70047
-- 81163

delete from cjams.userresource where permissiongroupid = 'd7d5a3d9-ecce-40a4-86bd-913cac1a9ad9' and userid in (13350, 70047, 81163);

INSERT INTO cjams.userresource ( userid, permissiongroupid, roleid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id) 
VALUES( 13350, 'd7d5a3d9-ecce-40a4-86bd-913cac1a9ad9'::uuid, NULL, NULL, 1, 'CJAMS-64674', now(), 'CJAMS-64674', now(), NULL, NULL, NULL, NULL);

INSERT INTO cjams.userresource ( userid, permissiongroupid, roleid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id) 
VALUES( 70047, 'd7d5a3d9-ecce-40a4-86bd-913cac1a9ad9'::uuid, NULL, NULL, 1, 'CJAMS-64674', now(), 'CJAMS-64674', now(), NULL, NULL, NULL, NULL);

INSERT INTO cjams.userresource ( userid, permissiongroupid, roleid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id) 
VALUES( 81163, 'd7d5a3d9-ecce-40a4-86bd-913cac1a9ad9'::uuid, NULL, NULL, 1, 'CJAMS-64674', now(), 'CJAMS-64674', now(), NULL, NULL, NULL, NULL);