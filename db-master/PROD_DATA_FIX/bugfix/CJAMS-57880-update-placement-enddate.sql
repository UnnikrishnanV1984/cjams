/*
Issue Description: CJAMS-57880: Need to fix the placement exit date.
Category/Module: Payments/ Adoption subsidy
Root cause: User has entered incorrect date for the placement as 2/20/2025 and Data fix to correct the end date of the placement to 02/19/2025 for below case
            Case: 3222680
            CJAMS PID: 3506034
            Client: NASIR D SUDLER
            Placement ID: 1997840
Fix provided: Data fix has been done to update the placement end date as requested by the user.
Regression Impacts: N/A
Data/Code fix ticket#: CJAMS-57880
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error and correction is needed as a data fix for the issue.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

-- INSERT INTO cjams.placementrevision
-- (activeflag, updatedon, placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status, primaryrelationship, leastrestrictiveplacement, transferagency, otherpublicagency, placementluggage, plluggagepurchased, plluggagecomments, objectid, objecttype)
-- VALUES(0, '2025-02-20 15:41:03.789', 'd0a19edd-a5ae-4c07-a6c6-01b3208216d3'::uuid, '8329c191-ce61-4388-bd10-f2236dcdee85'::uuid, '2025-02-20 00:00:00.000', '2024-06-24 00:00:00.000', '09:00', '2025-02-20 00:00:00.000', NULL, NULL, NULL, '', '3045', '2025-02-20 00:00:00.000', '1', '2025-02-20 12:48:15.150', '07a6565f-428d-473d-93c5-a7d20a42ad0f', '2025-02-20 15:41:03.789', '9208693f-7cdf-45ae-983b-e4eaa0a3cb7c', 0, 2363897, NULL, NULL, NULL, NULL, 'PLCC', 'Mr. Kevin W. Wright finalized the adoption of Nasir  Sudler on 2/19/25.

-- Judge Charles M. Blomquist presided over the adoption. ', 0, NULL, '07a6565f-428d-473d-93c5-a7d20a42ad0f', '2025-02-20 12:48:15.150', '9208693f-7cdf-45ae-983b-e4eaa0a3cb7c', '2025-02-20 13:03:54.284', NULL, NULL, NULL, NULL, 'Approved', NULL, 'Regular BCDSS Placement. Mr. Wright has developed a very close bond with Nasir.', NULL, NULL, true, NULL, NULL, NULL, NULL);

--Deleting duplicate placement revision record
delete from cjams.placementrevision where placementrevisionid='d0a19edd-a5ae-4c07-a6c6-01b3208216d3';


update cjams.placementrevision
set exitdate='2025-02-19 15:41:03.789',
    updatedby = 'CJAMS-57880',
    updatedon = now()
where placementrevisionid ='295dcb49-620e-48c0-9a30-69a970143345';


update placement 
set enddatetime='2025-02-19 15:41:03.789', 
    updatedby='CJAMS-57880',
    updatedon= now()
where placementid='8329c191-ce61-4388-bd10-f2236dcdee85'



