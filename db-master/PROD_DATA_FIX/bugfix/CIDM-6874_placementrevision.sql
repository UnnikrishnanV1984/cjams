/*
-- CIDM-6874 - 

-- Issue Description: 
 Remove Duplicate placement revision records
  
-- Customer Email ID: felicia.atueyi@maryland.gov

-- Root cause: Data fix to remove duplicate placement revision records
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/
-- INSERT INTO cjams.placementrevision
-- (placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status, primaryrelationship, leastrestrictiveplacement, transferagency, otherpublicagency)
-- VALUES('38bc72d4-f819-4b66-b941-0d41f5e1f306', '588629b6-6885-4441-b7be-3da34ae4cbc3', '2023-03-14 00:00:00.000', '2022-11-22 00:00:00.000', '20:00', '2023-03-07 00:00:00.000', '03:03', NULL, 'CIPPWR', '', '3045', NULL, '1', '2023-03-14 11:04:09.605', 'f6f95c13-d3b3-4ceb-bd19-0a8e54dc93ae', '2023-03-14 11:04:09.605', 'f6f95c13-d3b3-4ceb-bd19-0a8e54dc93ae', 1, 1289969, NULL, NULL, NULL, NULL, 'CIP', NULL, 0, NULL, 'f6f95c13-d3b3-4ceb-bd19-0a8e54dc93ae', '2023-03-14 11:04:09.605', NULL, NULL, NULL, NULL, NULL, NULL, 'Review', NULL, 'Stepping down and Moving to relative caregiver', NULL, NULL);
-- INSERT INTO cjams.placementrevision
-- (placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status, primaryrelationship, leastrestrictiveplacement, transferagency, otherpublicagency)
-- VALUES('c39ec879-28f9-4211-b45f-a7d2c0df3e73', '588629b6-6885-4441-b7be-3da34ae4cbc3', '2023-03-14 00:00:00.000', '2022-11-22 00:00:00.000', '20:00', '2023-03-07 00:00:00.000', '03:03', NULL, 'CIPPWR', '', '3045', '2023-03-14 00:00:00.000', '1', '2023-03-09 08:34:27.713', '3f8e38e7-3667-4181-9659-345a717d38a1', '2023-03-09 10:51:33.208', 'd636ac2f-53ff-43e0-adbf-35c97e0427ec', 0, 1285178, NULL, NULL, NULL, NULL, 'CIPS', 'Moved to relative caretaker', 0, NULL, '3f8e38e7-3667-4181-9659-345a717d38a1', '2023-03-09 08:34:27.713', NULL, NULL, NULL, NULL, NULL, NULL, 'Review', NULL, 'Stepping down and Moving to relative caregiver', NULL, NULL);
-- INSERT INTO cjams.placementrevision
-- (placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status, primaryrelationship, leastrestrictiveplacement, transferagency, otherpublicagency)
-- VALUES('a715ee5a-c121-4913-9b66-b5662d647993', '588629b6-6885-4441-b7be-3da34ae4cbc3', '2023-03-14 00:00:00.000', '2022-11-22 00:00:00.000', '20:00', '2023-03-07 00:00:00.000', '03:03', NULL, 'CIPPWR', '', '3045', '2023-03-14 00:00:00.000', '1', '2023-03-08 10:46:06.327', 'f6f95c13-d3b3-4ceb-bd19-0a8e54dc93ae', '2023-03-09 10:51:33.208', 'd636ac2f-53ff-43e0-adbf-35c97e0427ec', 0, 1284080, NULL, NULL, NULL, NULL, 'CIPS', NULL, 0, NULL, 'f6f95c13-d3b3-4ceb-bd19-0a8e54dc93ae', '2023-03-08 10:46:06.327', NULL, NULL, NULL, NULL, NULL, NULL, 'Review', NULL, 'This GH is the most appropriate placement to meet her needs', NULL, NULL);


DELETE FROM cjams.placementrevision
WHERE placementrevisionid='38bc72d4-f819-4b66-b941-0d41f5e1f306';
DELETE FROM cjams.placementrevision
WHERE placementrevisionid='c39ec879-28f9-4211-b45f-a7d2c0df3e73';
DELETE FROM cjams.placementrevision
WHERE placementrevisionid='a715ee5a-c121-4913-9b66-b5662d647993';

-- INSERT INTO cjams.placementrevision
-- (placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status, primaryrelationship, leastrestrictiveplacement, transferagency, otherpublicagency)
-- VALUES('67267291-faf1-43bc-b7ec-7e8b685966de', 'ccdc7ed7-6c51-458d-ba98-5a353eabc9f7', '2023-03-15 00:00:00.000', '2023-03-07 00:00:00.000', NULL, '2023-03-13 00:00:00.000', '10:36', NULL, NULL, '', '3045', '2023-03-15 00:00:00.000', '1', '2023-03-14 11:06:00.863', 'f6f95c13-d3b3-4ceb-bd19-0a8e54dc93ae', '2023-03-14 11:06:00.863', 'f6f95c13-d3b3-4ceb-bd19-0a8e54dc93ae', 0, 1290004, NULL, NULL, NULL, NULL, 'CIPS', NULL, 0, NULL, 'f6f95c13-d3b3-4ceb-bd19-0a8e54dc93ae', '2023-03-14 11:06:00.863', NULL, NULL, NULL, NULL, NULL, NULL, 'Review', NULL, 'Regular foster care', NULL, NULL);
-- INSERT INTO cjams.placementrevision
-- (placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status, primaryrelationship, leastrestrictiveplacement, transferagency, otherpublicagency)
-- VALUES('fef28517-678e-48ba-9735-5b9702fb9654'::uuid, 'ccdc7ed7-6c51-458d-ba98-5a353eabc9f7'::uuid, '2023-03-15 00:00:00.000', '2023-03-07 00:00:00.000', NULL, '2023-03-13 00:00:00.000', '11:00', NULL, NULL, '', '3045', NULL, '1', '2023-03-15 09:32:58.418', '3f8e38e7-3667-4181-9659-345a717d38a1', '2023-03-15 09:32:58.418', '3f8e38e7-3667-4181-9659-345a717d38a1', 1, 1291355, NULL, NULL, NULL, NULL, 'CIPS', 'The maternal aunt requested for her removal yesterday for not going to school.', 0, NULL, '3f8e38e7-3667-4181-9659-345a717d38a1', '2023-03-15 09:32:58.418', NULL, NULL, NULL, NULL, NULL, NULL, 'Review', NULL, 'Stepped up to Regular foster care as there have been ongoing behavior issues', NULL, NULL);

DELETE FROM cjams.placementrevision
WHERE placementrevisionid='67267291-faf1-43bc-b7ec-7e8b685966de';
DELETE FROM cjams.placementrevision
WHERE placementrevisionid='fef28517-678e-48ba-9735-5b9702fb9654';

update cjams.routing 
set activeflag = 0, updatedby = 'CIDM-6874', updatedon = now()
where routingid = '947787fd-d83c-42e2-8c82-912a7f801e87' and objectid = '588629b6-6885-4441-b7be-3da34ae4cbc3' and routingstatustypeid = 15 and activeflag = 1;
