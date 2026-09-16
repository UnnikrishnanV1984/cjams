/* 
   Issue Description: CDM-40651 Revert GAP changes
   Category/ Module  : Permanency Plan
   Root cause: Case Worker accidentally end dated the permanency plan, rather than moving forward with setting up GAP.
               Data fix needed for the following items
               1. "Proceed" button needs to be displayed.
               2.Plan review due date (as shown in the stage4 screenshot below) needs to be displayed.
               3.Plan review status needs to be changed to "Approved".
   Fix Provided : Data fix has been provided to Revert the endated GAP and remove the record rejected by the supervisor
   Pull request# for code fix: N/A
   Reason why no related code fix: N/A 
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/

---delete below two records in permanencyplanhistory table
-- INSERT INTO cjams.permanencyplanhistory
-- (permanencyplanhistoryid, permanencyplanid, intakeservicerequestactorid, intakeserviceid, servicecaseid, placementid, projecteddate, establisheddate, enddate, caseworkername, status, insertedon, insertedby, updatedon, updatedby, primarypermanencytype, concurrentpermanencytype, permanencyplanremainssame, reviewdate, objectid)
-- VALUES('f8425460-9ab4-43e3-a6c4-90842e98d67e'::uuid, '000bdd9a-d53e-4d81-bcc5-825d596917c0'::uuid, '8736586a-b07e-4b84-b337-2068d9381757'::uuid, NULL, '64767987-0ae7-45b9-bbab-05452b9bdbab'::uuid, 'c503a883-55b9-43f0-b215-2979bbc312dd'::uuid, '2023-08-28 04:00:00.000', '2023-08-28 04:00:00.000', NULL, 'SamanthaStasen', 'Review', '2024-07-31 13:01:25.900', 'ab5963bc-43fe-4567-8487-62195fa3936b', '2024-07-31 13:01:25.900', 'ab5963bc-43fe-4567-8487-62195fa3936b', NULL, NULL, true, NULL, '0a190a2c-47da-4c3d-bb69-52f3dd6313e0'::uuid);

-- INSERT INTO cjams.permanencyplanhistory
-- (permanencyplanhistoryid, permanencyplanid, intakeservicerequestactorid, intakeserviceid, servicecaseid, placementid, projecteddate, establisheddate, enddate, caseworkername, status, insertedon, insertedby, updatedon, updatedby, primarypermanencytype, concurrentpermanencytype, permanencyplanremainssame, reviewdate, objectid)
-- VALUES('bc20d4f6-f9e9-4862-8982-8baf4b8498b1'::uuid, '000bdd9a-d53e-4d81-bcc5-825d596917c0'::uuid, '8736586a-b07e-4b84-b337-2068d9381757'::uuid, NULL, '64767987-0ae7-45b9-bbab-05452b9bdbab'::uuid, 'c503a883-55b9-43f0-b215-2979bbc312dd'::uuid, '2023-08-28 04:00:00.000', '2023-08-28 04:00:00.000', NULL, 'SamanthaStasen', 'Rejected', '2024-07-31 13:02:20.148', '8451ccf6-ceb6-4ce4-b888-b4f2ada4d9fb', '2024-07-31 13:02:20.148', '8451ccf6-ceb6-4ce4-b888-b4f2ada4d9fb', NULL, NULL, true, NULL, NULL);

delete from permanencyplanhistory where permanencyplanhistoryid in ('f8425460-9ab4-43e3-a6c4-90842e98d67e','bc20d4f6-f9e9-4862-8982-8baf4b8498b1');

update routing set activeflag = 0, updatedby = 'CDM-40651',updatedon = now() where routingid = '5a08b898-d4d1-4206-848f-7485b89be066';

update permanencyplan set reviewdate = '2024-01-05 05:00:00.000', enddate = null, achieveddate=null, reason=null, updatedby = 'CDM-40651',updatedon = now() where permanencyplanid ='000bdd9a-d53e-4d81-bcc5-825d596917c0';