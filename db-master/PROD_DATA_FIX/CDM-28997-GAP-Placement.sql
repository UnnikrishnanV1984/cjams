/*
   Issue Description: CDM-28997
   Category/ Module  : Placement
   Root cause: user wants to delete the record under review
   Pull request# for data fix: 8217
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: Need data fix
*/
update routing set activeflag = 0, updatedby = 'CDM-28997', updatedon = now()
where routingid in ('7c13a5a8-bbc9-4130-b6d1-15778255ddce', '3837cc50-0184-44e2-b256-1785505627ed');

delete from placementrevision where placementrevisionid in ('2af9a866-9bbd-44d5-93fb-2055d75c5dba', '9af865d6-5e3d-4db6-93f3-b9acc9ea1735');

/*
INSERT INTO cjams.placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status, primaryrelationship, leastrestrictiveplacement, transferagency, otherpublicagency)
VALUES('2af9a866-9bbd-44d5-93fb-2055d75c5dba', '8c0d02c8-6726-4432-be99-94391a80ad28', '2023-03-08 00:00:00.000', '2021-06-24 00:00:00.000', '20:00', NULL, NULL, NULL, NULL, '', '3045', '2023-03-08 00:00:00.000', '1', '2023-02-21 16:04:57.509', '3ca8e63d-f885-445b-aab9-24456e91ad4a', '2023-03-08 12:42:07.057', '3ca8e63d-f885-445b-aab9-24456e91ad4a', 0, 1264318, NULL, NULL, NULL, NULL, NULL, 'C&G was granted to Geneva Harkless on 02/10/23.', NULL, NULL, '3ca8e63d-f885-445b-aab9-24456e91ad4a', '2023-02-21 16:04:57.509', NULL, NULL, NULL, NULL, NULL, NULL, 'Review', NULL, 'OHP made the decision.', NULL, NULL);


INSERT INTO cjams.placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status, primaryrelationship, leastrestrictiveplacement, transferagency, otherpublicagency)
VALUES('9af865d6-5e3d-4db6-93f3-b9acc9ea1735', '8c0d02c8-6726-4432-be99-94391a80ad28', '2023-03-08 00:00:00.000', '2021-06-24 00:00:00.000', '20:00', '2023-02-10 00:00:00.000', NULL, NULL, NULL, '', '3045', '2023-03-08 00:00:00.000', '1', '2023-02-21 16:01:42.731', 'ceca7825-35d6-41bb-bfc9-df3256d9a1d9', '2023-03-08 12:42:07.057', '3ca8e63d-f885-445b-aab9-24456e91ad4a', 0, 1264283, NULL, NULL, NULL, NULL, 'PLCC', 'C&G was granted to Geneva Harkless on 02/10/23.', 0, NULL, 'ceca7825-35d6-41bb-bfc9-df3256d9a1d9', '2023-02-21 16:01:42.731', NULL, NULL, NULL, NULL, NULL, NULL, 'Review', NULL, 'OHP made the decision.', NULL, NULL);
*/