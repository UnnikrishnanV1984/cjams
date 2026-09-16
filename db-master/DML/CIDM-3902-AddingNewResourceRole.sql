 INSERT INTO cjams.permissiongroup
(permissiongroupid, permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('7e53df93-9632-4dcb-9e35-c580f1d5680e', 'SSA Placement Manager Role', 'SSA Placement Manager Role', 1, 'CIDM-3902', 'CIDM-3902', NOW(), NOW(), NULL) ON CONFLICT DO NOTHING;

INSERT INTO cjams.resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('bcc82fc4-2094-477a-acb5-d3fb003bd24c', NULL, 'SSA_Placement_Manager', 1, 1, 'CIDM-3902', NOW(), 'CIDM-3902', NOW(), 'SSA_Placement_Manager', NULL, NULL, 'SSA_Placement_Manager', NULL, 'SSA_Placement_Manager') ON CONFLICT DO NOTHING;
      

INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('0d2427d8-8a19-4e46-b309-e997ad6f1117', '7e53df93-9632-4dcb-9e35-c580f1d5680e', 'bcc82fc4-2094-477a-acb5-d3fb003bd24c', 1, 'CIDM-3902', NOW(), 'CIDM-3902', NOW(), true, true, true, NULL)ON CONFLICT DO NOTHING;


-- tennille.thomas@maryland.gov 
INSERT INTO cjams.userresource
(userresourceid, userid, permissiongroupid, roleid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('7efff7e8-87e1-4a06-a30f-fa604552b6e0'::uuid, 3261, '7e53df93-9632-4dcb-9e35-c580f1d5680e'::uuid, 2451, NULL, 1, 'CIDM-3902', NOW(), 'CIDM-3902', NOW(), true, true, true, NULL) ON CONFLICT DO NOTHING;

--debralynn.pierson@maryland.gov
INSERT INTO cjams.userresource
(userresourceid, userid, permissiongroupid, roleid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('c60834d1-f658-4597-bbdc-4f013cf9fcab'::uuid, 14032, '7e53df93-9632-4dcb-9e35-c580f1d5680e'::uuid, 3150, NULL, 1, 'CIDM-3902', NOW(), 'CIDM-3902', NOW(), true, true, true, NULL) ON CONFLICT DO NOTHING;

