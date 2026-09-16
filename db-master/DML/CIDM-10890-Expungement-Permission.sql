
DELETE FROM cjams.pgresource WHERE pgresourceid = 'e2e538b7-fc95-49b6-8cce-b59e669fc2b0';

DELETE FROM cjams.resource WHERE id = 'bd16d3e3-fd5e-4f25-8c75-3216ba3d4b6e';

DELETE FROM cjams.permissiongroup WHERE permissiongroupid = 'd7d5a3d9-ecce-40a4-86bd-913cac1a9ad9';





INSERT INTO cjams.permissiongroup
(permissiongroupid, permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('d7d5a3d9-ecce-40a4-86bd-913cac1a9ad9'::uuid, 'EXPUNGED_SEXUAL_ABUSE_DETAILS_VIEW', '', 1, 'CIDM-10890-', 'CIDM-10890', NOW(), NOW(), NULL) ON CONFLICT DO NOTHING;


INSERT INTO cjams.resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('bd16d3e3-fd5e-4f25-8c75-3216ba3d4b6e', NULL, 'EXPUNGED_SEXUAL_ABUSE_DETAILS_VIEW', 1, 1, 'CIDM-10890', NOW(), 'CIDM-10890', NOW(), 'EXPUNGED_SEXUAL_ABUSE_DETAILS_VIEW', NULL, NULL, 'EXPUNGED_SEXUAL_ABUSE_DETAILS_VIEW', NULL, 'EXPUNGED_SEXUAL_ABUSE_DETAILS_VIEW') ON CONFLICT DO NOTHING;
      

INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('e2e538b7-fc95-49b6-8cce-b59e669fc2b0'::uuid, 'd7d5a3d9-ecce-40a4-86bd-913cac1a9ad9'::uuid, 'bd16d3e3-fd5e-4f25-8c75-3216ba3d4b6e'::uuid, 1, 'CIDM-10890', NOW(), 'CIDM-10890', NOW(), true, true, NULL, NULL) ON CONFLICT DO NOTHING;