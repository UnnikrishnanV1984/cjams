/*
   Issue Description:  CDM-5834 -- Investigation Findings Confusion
   Category/ Module  :  Case disposition
   Root cause: Applicatoin is working fine and unabale to reproduce it.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 

Back up data for deletion:
INSERT INTO cjams.intakeservicerequestdispositioncode
(intakeservicerequestdispositioncodeid, intakeserviceid, insertedby, insertedon, updatedby, updatedon, "timestamp", statusdate, description, expirationdate, effectivedate, activeflag, intakeserreqstatustypeid, servicerequesttypeconfigiddispostionid, dateofsubpoena, subpoenareason, lastfacetofacedate, seenwithin, dateseen, reviewcomments, reasonfordelay, old_id, closingcodetypekey, servicerequestdispositionsubtypeconfigid, servicerequestdispositionsubtypenotes, approvalid, approvalnaturetypekey, entitytypetypekey, additionalkey, entitykeyid1, entitykeyid2, requestdate, actiondueddate, approvestaffid, approvalstatustypekey, denialreasontypekey, requestorcomments, approvalcomments, currentstatustypekey, forwardcountytypekey, forwardunitid, administratorid, datavalidflag, clientmergeid, etl_userid, etl_load_date, adultassignedsecurityid)
VALUES('b117e6a7-ff70-4f51-a015-d1e6a46c1cb5', 'af4edb82-b36d-4fd7-8c9a-b4654d036e17', '8e635e01-b9fa-498d-920e-96cce9c03496', '2020-10-16 14:59:43.000', '8e635e01-b9fa-498d-920e-96cce9c03496', '2020-10-16 14:59:43.000', NULL, '2020-10-16 14:59:43.602', NULL, NULL, '2020-10-16 14:59:43.000', 1, '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690', 'c59200ea-033c-4ce0-b156-294955f1d62b', NULL, NULL, NULL, NULL, '2020-10-16 18:59:43.336', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.intakeservicerequestdispositioncode
(intakeservicerequestdispositioncodeid, intakeserviceid, insertedby, insertedon, updatedby, updatedon, "timestamp", statusdate, description, expirationdate, effectivedate, activeflag, intakeserreqstatustypeid, servicerequesttypeconfigiddispostionid, dateofsubpoena, subpoenareason, lastfacetofacedate, seenwithin, dateseen, reviewcomments, reasonfordelay, old_id, closingcodetypekey, servicerequestdispositionsubtypeconfigid, servicerequestdispositionsubtypenotes, approvalid, approvalnaturetypekey, entitytypetypekey, additionalkey, entitykeyid1, entitykeyid2, requestdate, actiondueddate, approvestaffid, approvalstatustypekey, denialreasontypekey, requestorcomments, approvalcomments, currentstatustypekey, forwardcountytypekey, forwardunitid, administratorid, datavalidflag, clientmergeid, etl_userid, etl_load_date, adultassignedsecurityid)
VALUES('de65d72f-6aed-4b82-b2c7-b9e648672ccf', 'af4edb82-b36d-4fd7-8c9a-b4654d036e17', '8e635e01-b9fa-498d-920e-96cce9c03496', '2020-10-16 14:58:32.000', '8e635e01-b9fa-498d-920e-96cce9c03496', '2020-10-16 14:58:32.000', NULL, '2020-10-16 14:58:32.104', NULL, NULL, '2020-10-16 14:58:32.000', 1, '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690', 'c59200ea-033c-4ce0-b156-294955f1d62b', NULL, NULL, NULL, NULL, '2020-10-16 18:58:31.640', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/

update routing set activeflag=1, updatedby='CDM-5834', updatedon=now() where objectid in ('bdec383d-f94b-4b57-8877-90cf0e927582')
and routingid='22549bea-b84d-4d78-a0b1-e07cdf387c3b';

delete from intakeservicerequestdispositioncode where intakeserviceid='af4edb82-b36d-4fd7-8c9a-b4654d036e17'
and intakeservicerequestdispositioncodeid in ('b117e6a7-ff70-4f51-a015-d1e6a46c1cb5','de65d72f-6aed-4b82-b2c7-b9e648672ccf');