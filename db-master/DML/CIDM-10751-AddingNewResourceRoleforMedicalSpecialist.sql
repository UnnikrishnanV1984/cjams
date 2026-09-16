/*
CDM-44498 - Adding Medical Specialist resource - Veera Nadimpalli 08/29
*/


INSERT INTO cjams.resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('17e7b12b-a526-4783-aa92-4149d3c8c845', NULL, 'Medical Specialist', 2, 1, 'CIDM-10751', now(), 'CIDM-10751', now(), 'Medical Specialist', NULL, NULL, 'Medical Specialist', NULL, '') ON CONFLICT DO NOTHING;



INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('4e5a8248-1922-426f-8e78-baefc59d3725', '0c2282d4-4df0-47a5-baac-fbc14077bfb1', '17e7b12b-a526-4783-aa92-4149d3c8c845', 1, 'CIDM-10751', NOW(), 'CIDM-10751', NOW(), true, true, true, NULL) ON CONFLICT DO NOTHING;


-- 36af683c-2258-4f39-838f-3c0d48590c85
--  ae54f681-1576-4dfa-bdb4-8e65f867534b these 2 other duplicate pgresourceid mapping to "person.involved.edit"
  update pgresource set isallowed = true, isvisible = true, isenabled = true , updatedby = 'CIDM-10751', updatedon = now()
  where pgresourceid = '1ba386b8-98d4-42e3-b42c-5ba73bb5a916' and permissiongroupid = '0c2282d4-4df0-47a5-baac-fbc14077bfb1' and activeflag = 1;
  