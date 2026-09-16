/*
 Issue Description:  CDM-42940
 Category/ Module: Placement
 Root cause: As supervisor is approved the placement. Request to show approved in the form. Datafix is given accordingly
 Pull request# for code fix: NA
 Reason why no related code fix: NA
 Status of the code fix if already submitted and expected prod fix date: NO
 Backup before update/ delete: NA
 */

 update placementrevision
set status =  'Approved',
approvedby = '62b59775-e1f4-4940-b80b-be7a2df3d8b7',
approveddate = '2024-10-21 14:55:13.233',
updatedby='CDM-42940',updatedon=now()
where placementid = 'b207f411-a512-4297-a5f8-bca40dc94504' and activeflag = 1;

update placementrevision
set status =  'Approved',
approvedby = '62b59775-e1f4-4940-b80b-be7a2df3d8b7',
approveddate = '2024-10-21 14:56:12.901',
updatedby='CDM-42940',updatedon=now()
where placementid = '713d6e40-47c0-4d74-a74d-ec19a4c7a25a' and activeflag = 1;

update placementrevision
set status =  'Approved',
approvedby = '62b59775-e1f4-4940-b80b-be7a2df3d8b7',
approveddate = '2024-10-21 15:09:07.474',
updatedby='CDM-42940',updatedon=now()
where placementid = '87679f23-ff36-42ab-a520-a0c8ca6367b8' and activeflag = 1;

update placementrevision
set status =  'Approved',
approvedby = '62b59775-e1f4-4940-b80b-be7a2df3d8b7',
approveddate = '2024-10-15 13:27:09.270',
updatedby='CDM-42940',updatedon=now()
where placementrevisionid = 'ae16118b-ec9f-4b97-84df-9cd341cd371c' and activeflag = 1;

update placementrevision
set status =  'Approved',
approvedby = '62b59775-e1f4-4940-b80b-be7a2df3d8b7',
approveddate = '2024-10-15 00:00:00.000',
updatedby='CDM-42940',updatedon=now()
where placementrevisionid = '84e821f9-e79a-456f-909b-e41266b4c6d2';