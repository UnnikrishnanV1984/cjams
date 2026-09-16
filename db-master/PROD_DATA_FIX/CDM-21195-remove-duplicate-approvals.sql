/*
-- CDM-21195 - 

-- Issue Description: 
 Remove Duplicate Approvals
  
-- Customer Email ID: rhonda.frankenberry@maryland.gov

-- Root cause: Data fix to remove duplicate approvals
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- INSERT INTO cjams.placementrevision
--(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status)
--VALUES('a7bb262d-1fef-4195-ba2f-3865db279d4f'::uuid, '1549ed14-8be2-4844-a46e-b737d3dec966'::uuid, '2022-03-15 00:00:00.000', '2022-02-04 00:00:00.000', '15:00', NULL, '10:00', NULL, 'CIPCOPC', '', '3045', '2022-03-15 00:00:00.000', '1', '2022-02-04 15:27:24.531', 'a9978c37-29cc-4b21-9bcb-0b04b53e5f46', '2022-03-15 10:22:31.629', '262f71d0-64d5-4eaf-bd7a-b0901803706c', 0, 1141964, NULL, NULL, NULL, NULL, NULL, 'Ayawna placed with her mother at Rainbow of Love Recovery.  DSS still has custody.  Shawna has physical custody.', 0, NULL, 'a9978c37-29cc-4b21-9bcb-0b04b53e5f46', '2022-02-04 15:27:24.531', NULL, NULL, NULL, NULL, NULL, NULL, 'Review');
--INSERT INTO cjams.placementrevision
--(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status)
--VALUES('e6c138f0-dce3-4aae-8a47-ebb88482f15b'::uuid, '1549ed14-8be2-4844-a46e-b737d3dec966'::uuid, '2022-03-15 00:00:00.000', '2022-02-04 15:00:00.000', '15:00', NULL, '10:00', NULL, 'CIPCOPC', '', '3045', '2022-03-15 00:00:00.000', 'Y', '2022-02-04 15:27:23.531', 'a9978c37-29cc-4b21-9bcb-0b04b53e5f46', '2022-03-15 10:22:31.629', '262f71d0-64d5-4eaf-bd7a-b0901803706c', 0, 1141962, NULL, NULL, NULL, NULL, NULL, 'Ayawna placed with her mother at Rainbow of Love Recovery.  DSS still has custody.  Shawna has physical custody.', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Approved');

DELETE FROM cjams.placementrevision
WHERE placementrevisionid='a7bb262d-1fef-4195-ba2f-3865db279d4f'::uuid;
DELETE FROM cjams.placementrevision
WHERE placementrevisionid='e6c138f0-dce3-4aae-8a47-ebb88482f15b'::uuid;