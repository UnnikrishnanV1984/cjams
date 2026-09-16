/* 
    Issue Description: CJAMS-61034
  Category/ Module: Services: Other
  Root cause: User requested to do a data fix to remove the Permanency plan "End date" 
  for the Client ID: 200820748 (Ny'lah Prunty) in the Case# 221030017964.
  Fix provided : Data fix has been done to remove the Permanency plan "End date" for the Client ID: 200820748 (Ny'lah Prunty) in the Case# 221030017964.
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: 
*/

update permanencyplan
set enddate = null,
updatedon = now(),
updatedby = 'CJAMS-61034'
where permanencyplanid = 'db24fb78-1d3d-434c-a063-e5ea44b38903'
and activeflag = 1;

DELETE FROM cjams.permanencyplanhistory
WHERE permanencyplanhistoryid='d993a14b-d642-4c2e-ae38-ec08409c7bc8'::uuid;

/*
INSERT INTO cjams.permanencyplanhistory
(permanencyplanhistoryid, permanencyplanid, intakeservicerequestactorid, intakeserviceid, servicecaseid, placementid, projecteddate, establisheddate, enddate, caseworkername, status, insertedon, insertedby, updatedon, updatedby, primarypermanencytype, concurrentpermanencytype, permanencyplanremainssame, reviewdate, objectid)
VALUES('d993a14b-d642-4c2e-ae38-ec08409c7bc8'::uuid, 'db24fb78-1d3d-434c-a063-e5ea44b38903'::uuid, '420913c3-2fe8-48fb-b7b4-f81aaad9fca2'::uuid, NULL, '561c66bd-4a88-4fae-a065-a5821fae633d'::uuid, NULL, '2025-07-17 04:00:00.000', '2025-07-17 04:00:00.000', '2025-07-17 00:00:00.000', 'ChristalNelson', 'Review', '2025-07-30 11:27:46.528', 'de3a96f6-7cc7-43db-9d6d-cb3547418aec', '2025-07-30 11:27:46.528', 'de3a96f6-7cc7-43db-9d6d-cb3547418aec', NULL, NULL, NULL, NULL, '7cf43b9e-a85f-4bf6-a559-36e6473918ab'::uuid);
*/

DELETE FROM cjams.permanencyplanhistory
WHERE permanencyplanhistoryid='e0f25587-86ea-40f7-b7dc-b114f3b81ac9'::uuid;

/*
INSERT INTO cjams.permanencyplanhistory
(permanencyplanhistoryid, permanencyplanid, intakeservicerequestactorid, intakeserviceid, servicecaseid, placementid, projecteddate, establisheddate, enddate, caseworkername, status, insertedon, insertedby, updatedon, updatedby, primarypermanencytype, concurrentpermanencytype, permanencyplanremainssame, reviewdate, objectid)
VALUES('e0f25587-86ea-40f7-b7dc-b114f3b81ac9'::uuid, 'db24fb78-1d3d-434c-a063-e5ea44b38903'::uuid, '420913c3-2fe8-48fb-b7b4-f81aaad9fca2'::uuid, NULL, '561c66bd-4a88-4fae-a065-a5821fae633d'::uuid, NULL, '2025-07-17 04:00:00.000', '2025-07-17 04:00:00.000', '2025-07-17 00:00:00.000', 'ChristalNelson', 'Approved', '2025-07-30 11:28:26.667', 'bd636c33-0479-4d24-aec5-1556f307fe96', '2025-07-30 11:28:26.667', 'bd636c33-0479-4d24-aec5-1556f307fe96', NULL, NULL, NULL, NULL, '51a3b25d-30b7-412e-8562-704dbaf1788f'::uuid);
*/