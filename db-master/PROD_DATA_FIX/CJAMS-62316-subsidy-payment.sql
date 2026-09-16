/*
Issue Description: CJAMS-62316 Payments issue
Category/Module: GAP/Payments
Root cause: As part of data fix on ticket CJAMS-61257, We need another data fix to trigger under payment for June & July 2025.
Fix provided: Data fix has been done trigger payments for GAP agreement.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error and data fix should correct it.
*/

-- To Trigger the payments batch
update gapratesrevision
set approvaldate = now(),
    updatedby = 'CJAMS-62316'
where gaprateid = '0a04474d-5623-4303-8194-6a2c9877d454'
and activeflag = 1;

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'GAAR', 'e4271184-e42a-4639-88a5-4168eb1814f7', '282bce60-d6fd-43f1-aa89-a602387dcd5b', 'c785fb5e-b0f4-4f4a-acf8-f9a563c10fc1', 'CWSP', 'CWCW', 'f2572507-8759-4900-a60c-77f3750a35ad', 16, 1, 'e4271184-e42a-4639-88a5-4168eb1814f7', '2025-07-15 09:03:00.864', 'CJAMS-62316', '2025-08-21 09:03:00.000', false, NULL, NULL, 'Guardianship Application Approved ', '3164722', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

--Deactivating the 3045 record

update gapagreementrevision
set activeflag = 0,
    updatedby = 'CJAMS-62316',
    updatedon = now()
where gapagreementrevisionid = '31406c08-5f7a-4307-955e-0f1a79503d5e'
and activeflag = 1;

--Inserting 3047 record in gapagreementrevision to trigger the payments

INSERT INTO cjams.gapagreementrevision
(gapagreementrevisionid, gapagreementid, gapid, iscomprehensivehomestudy, iscgawardedcustody, isplacementenddate, ischildreceivetca, startdate, enddate, signaturedate, guardianonedate, guardiantwodate, ldssdate, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, old_id, tcaamount, isfianotified, fianotifieddate, isrcnotifiedcontact, iscsnotifiedtocustody, approvalstatustypekey, approvaldate, guardian1signature, guardian2signature, ldssdirectorsignature, signaturecheck)
VALUES(gen_random_uuid(), 'f2572507-8759-4900-a60c-77f3750a35ad', '6dd14a26-4aae-47dd-945c-1859b849d75d', NULL, NULL, NULL, false, '2015-12-15 00:00:00.000', '2028-06-03 04:00:00.000', '2015-12-14 00:00:00.000', '2015-12-14 00:00:00.000', NULL, '2015-12-14 00:00:00.000', 1, '2025-07-15 09:02:48.000', 'CJAMS-62316', '2025-07-15 09:02:48.000', 'CJAMS-62316', now(), NULL, NULL, NULL, NULL, NULL, NULL, '3047', NULL, NULL, NULL, NULL, false);