/*
Issue: CJAMS-63874 ISSUE WITH AN OVERPAYMENT FROM 11-18-24 TO 11-17-25-$249
Category/Module: Payments/GAP subsidy
Root cause: 3128824:GUARDIAN RECEIVED AN OVERPAYMENT FROM 11-18-2024 TO 11-17-2025 IN THE AMOUNT OF $249, PLEASE ENTER A SUBSIDY RATE FOR 11-18 -2024 TO 11-17-2025 FOR AMOUNT OF $585 A MONTH.
Fix provided:  Data fix has been done to Add subsidy rate slab for 11/18/2024 to 11/17/2025 for an amount of $585
Data/Code fix ticket#: CJAMS-63874 
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: The next period subsidy rate is already approved and payment has been generated. We just need a data fix to insert a subsidy rate slab.
*/

INSERT INTO cjams.gapagreementrate
(gapagreementrateid, gapagreementid, startdate, enddate, paymentamout, isoverride, paymenttypekey, notes, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, old_id, provider_id, alternateid, status, negotiateddate, rateapprovaldate, etl_userid, etl_load_date, ssaapprovaldate)
VALUES(gen_random_uuid(), '19fdab28-89a8-41d6-ba50-cd325de45273'::uuid, '2024-11-18 01:00:00.000', '2025-11-17 00:00:00.000', 585, NULL, NULL, NULL, 1, now(), 'CJAMS-63874', now(), 'CJAMS-63874', now(), NULL, 5028217, 1399842, 'Approved', now(), NULL, NULL, NULL, NULL);


INSERT INTO cjams.gapratesrevision
(gapratesrevisionid, transactiondate, ratestartdate, rateenddate, paymentamt, "comments", approvalstatustypekey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, gaprateid, guardiansubsidyid, providerid, alternateid, etl_userid, etl_load_date)
VALUES(gen_random_uuid(), now(), '2024-11-18 01:00:00.000', '2025-11-17 00:00:00.000', 585, NULL, '3047', now(), NULL, now(), 'CJAMS-63874', now(), 'CJAMS-63874', 1, (select gapagreementrateid from gapagreementrate where gapagreementid = '19fdab28-89a8-41d6-ba50-cd325de45273' and startdate = '2024-11-18 01:00:00.000' and enddate = '2025-11-17 00:00:00.000')::uuid, '4bc45729-58da-4301-8956-e1656267f6f8'::uuid, 5028217, 1411033, NULL, NULL);


INSERT INTO cjams.gapratesrevision
(gapratesrevisionid, transactiondate, ratestartdate, rateenddate, paymentamt, "comments", approvalstatustypekey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, gaprateid, guardiansubsidyid, providerid, alternateid, etl_userid, etl_load_date)
VALUES(gen_random_uuid(), now(), '2024-11-18 01:00:00.000', '2025-11-17 00:00:00.000', 585, NULL, '3045', now(), NULL, now(), 'CJAMS-63874', now(), 'CJAMS-63874', 0, (select gapagreementrateid from gapagreementrate where gapagreementid = '19fdab28-89a8-41d6-ba50-cd325de45273' and startdate = '2024-11-18 01:00:00.000' and enddate = '2025-11-17 00:00:00.000')::uuid, '4bc45729-58da-4301-8956-e1656267f6f8'::uuid, 5028217, 1409871, NULL, NULL);


INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES((gen_random_uuid()), 'GARR', '65184bef-4775-4122-9bf0-45e2761b9292', '3ca8e63d-f885-445b-aab9-24456e91ad4a', 'b50f2419-42ba-4ab6-84ab-5172917d2d77'::uuid, 'CWCW', 'CWSP', (select gapagreementrateid from gapagreementrate where gapagreementid = '19fdab28-89a8-41d6-ba50-cd325de45273' and startdate = '2024-11-18 01:00:00.000' and enddate = '2025-11-17 00:00:00.000'), 15, 0, '65184bef-4775-4122-9bf0-45e2761b9292', now(), '65184bef-4775-4122-9bf0-45e2761b9292',now(), true, 'Guardianship Agreement Submitted for review as part of CJAMS-63874', NULL, 'Guardianship Agreement Submitted for review', '3128824', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'GARR', '3ca8e63d-f885-445b-aab9-24456e91ad4a', '65184bef-4775-4122-9bf0-45e2761b9292', 'b50f2419-42ba-4ab6-84ab-5172917d2d77'::uuid, 'CWSP', 'CWCW', (select gapagreementrateid from gapagreementrate where gapagreementid = '19fdab28-89a8-41d6-ba50-cd325de45273' and startdate = '2024-11-18 01:00:00.000' and enddate = '2025-11-17 00:00:00.000'), 16, 1, '3ca8e63d-f885-445b-aab9-24456e91ad4a', now(), '3ca8e63d-f885-445b-aab9-24456e91ad4a', now(), true, 'Guardianship Agreement approved as part of CJAMS-63874', NULL, 'Guardianship Rate Approved ', '3128824', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


update gapratesrevision
set updatedby='CJAMS-63874',
    updatedon = now(),
    approvaldate =now() -- To trigger payments batch for last two payments
where gaprateid in ('f7e8f913-5bc4-4e95-a22f-769ca4cf8d3e',(select gapagreementrateid from gapagreementrate where gapagreementid = '19fdab28-89a8-41d6-ba50-cd325de45273' and startdate = '2024-11-18 01:00:00.000' and enddate = '2025-11-17 00:00:00.000')) and activeflag=1;