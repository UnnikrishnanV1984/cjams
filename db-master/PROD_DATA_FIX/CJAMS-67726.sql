/* 
    Issue Description: CJAMS-67726
  Category/ Module: Services: Other
  Root cause: This is not a defect as per the system design , if the permanency plan review is selected as NO, the system would automatically end date the permanency  plan and the worker need to create new permanency plan,
              requested to do a data fix to remove the Permanency plan "End date" 
              for the Client ID: 4316949,200901679 in the Case# 3295064.
  Fix provided : Data fix has been done to remove the Permanency plan "End date" for the Client ID: 4316949,200901679 in the Case# 3295064.
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: 
*/

update permanencyplan
set enddate = null,
updatedon = now(),
updatedby = 'CJAMS-67726'
where permanencyplanid in ('8855bba8-94a5-4f11-a410-a175fe89c3b0','7864a471-eb0e-4e57-a841-0cd48266553f')
and activeflag = 1;

/*
 INSERT INTO cjams.permanencyplanhistory
(permanencyplanhistoryid, permanencyplanid, intakeservicerequestactorid, intakeserviceid, servicecaseid, placementid, projecteddate, establisheddate, enddate, caseworkername, status, insertedon, insertedby, updatedon, updatedby, primarypermanencytype, concurrentpermanencytype, permanencyplanremainssame, reviewdate, objectid)
VALUES('13d51c85-a0ac-420c-b551-9abe9dffb2eb', '8855bba8-94a5-4f11-a410-a175fe89c3b0', '37b998d0-0fb0-43ce-905a-7edd0cdef47b', NULL, 'e8caed46-38d9-44ba-bcb8-594c16b8fdfc', '114f9fcb-b840-4303-868f-6faa70a9831b', '2026-04-10 04:00:00.000', '2026-04-10 04:00:00.000', '2026-05-01 00:00:00.000', 'ConsolateSmith', 'Review', '2026-05-01 13:44:32.644', '7cf63fcc-449b-4870-b31a-e3701640451b', '2026-05-01 13:44:32.644', '7cf63fcc-449b-4870-b31a-e3701640451b', NULL, NULL, NULL, NULL, '02dbe5e0-6bec-4c17-8f42-d2ce2b6a237e');
*/

DELETE FROM cjams.permanencyplanhistory
WHERE permanencyplanhistoryid='13d51c85-a0ac-420c-b551-9abe9dffb2eb';



/*
 INSERT INTO cjams.permanencyplanhistory
(permanencyplanhistoryid, permanencyplanid, intakeservicerequestactorid, intakeserviceid, servicecaseid, placementid, projecteddate, establisheddate, enddate, caseworkername, status, insertedon, insertedby, updatedon, updatedby, primarypermanencytype, concurrentpermanencytype, permanencyplanremainssame, reviewdate, objectid)
VALUES('c915c887-2a61-4071-8d21-2d4d0f1de97e', '8855bba8-94a5-4f11-a410-a175fe89c3b0', '37b998d0-0fb0-43ce-905a-7edd0cdef47b', NULL, 'e8caed46-38d9-44ba-bcb8-594c16b8fdfc', '114f9fcb-b840-4303-868f-6faa70a9831b', '2026-04-10 04:00:00.000', '2026-04-10 04:00:00.000', '2026-05-01 00:00:00.000', 'ConsolateSmith', 'Approved', '2026-05-04 10:05:49.840', '2744f6af-eb3c-4523-8179-e737d58d908e', '2026-05-04 10:05:49.840', '2744f6af-eb3c-4523-8179-e737d58d908e', NULL, NULL, NULL, NULL, '4b29c279-b7a2-464a-8d4f-57e7907f6c41');

 */

DELETE FROM cjams.permanencyplanhistory
WHERE permanencyplanhistoryid='c915c887-2a61-4071-8d21-2d4d0f1de97e';

/*
 INSERT INTO cjams.permanencyplanhistory
(permanencyplanhistoryid, permanencyplanid, intakeservicerequestactorid, intakeserviceid, servicecaseid, placementid, projecteddate, establisheddate, enddate, caseworkername, status, insertedon, insertedby, updatedon, updatedby, primarypermanencytype, concurrentpermanencytype, permanencyplanremainssame, reviewdate, objectid)
VALUES('a7dbe89e-6470-44ce-a9cc-5ed7e39ed03e', '7864a471-eb0e-4e57-a841-0cd48266553f', '6a5ce5bb-0e52-40fd-8447-00fc53094436', NULL, 'e8caed46-38d9-44ba-bcb8-594c16b8fdfc', 'f9284db5-be6c-41ff-a196-e7294e3d0061', '2026-04-10 04:00:00.000', '2026-04-10 04:00:00.000', '2026-05-01 00:00:00.000', 'ConsolateSmith', 'Review', '2026-05-01 13:45:07.641', '7cf63fcc-449b-4870-b31a-e3701640451b', '2026-05-01 13:45:07.641', '7cf63fcc-449b-4870-b31a-e3701640451b', NULL, NULL, NULL, NULL, '660eb401-191d-4d7a-b7e0-f05154abc77a');
 
 */
DELETE FROM cjams.permanencyplanhistory
WHERE permanencyplanhistoryid='a7dbe89e-6470-44ce-a9cc-5ed7e39ed03e';

/*
INSERT INTO cjams.permanencyplanhistory
(permanencyplanhistoryid, permanencyplanid, intakeservicerequestactorid, intakeserviceid, servicecaseid, placementid, projecteddate, establisheddate, enddate, caseworkername, status, insertedon, insertedby, updatedon, updatedby, primarypermanencytype, concurrentpermanencytype, permanencyplanremainssame, reviewdate, objectid)
VALUES('f465e42f-8100-4a72-920e-bd7d5e4cc09e', '7864a471-eb0e-4e57-a841-0cd48266553f', '6a5ce5bb-0e52-40fd-8447-00fc53094436', NULL, 'e8caed46-38d9-44ba-bcb8-594c16b8fdfc', 'f9284db5-be6c-41ff-a196-e7294e3d0061', '2026-04-10 04:00:00.000', '2026-04-10 04:00:00.000', '2026-05-01 00:00:00.000', 'ConsolateSmith', 'Approved', '2026-05-04 10:05:56.126', '2744f6af-eb3c-4523-8179-e737d58d908e', '2026-05-04 10:05:56.126', '2744f6af-eb3c-4523-8179-e737d58d908e', NULL, NULL, NULL, NULL, 'd0445dcc-5a74-4497-9f95-80f263abc92e');

*/

DELETE FROM cjams.permanencyplanhistory
WHERE permanencyplanhistoryid='f465e42f-8100-4a72-920e-bd7d5e4cc09e';