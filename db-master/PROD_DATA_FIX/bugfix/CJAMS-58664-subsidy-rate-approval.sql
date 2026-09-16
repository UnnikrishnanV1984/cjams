/*
Issue Description:CJAMS-58664 211030012366:Hello, I am trying to put the subsidy in for 2025 for all three of the Baugham siblings. However, my supervisor has approve it but it keep saying review and not approved.
Category/Module: GAP rate 
Root cause: We are not able to find the subsidy rate for approval in the supervisor inbox and data fix needed to approve the rate for all the three children so that user can proceed with this subsidy rate.
Fix provided: Data fix to make the susidy rate as approved 
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
*/

--Inserting routing records for the child Asiah Baugham CJAMS PID #200822852 with gaprateid 3a373a73-f7c1-4b84-b437-859db39d7f74
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'GARR', 'e27575b1-783d-4b26-a4ad-0985f8ad4d6e', '46362254-be94-41ce-8b6b-4898090e8027', '6123c7a6-29a7-4252-ac6b-2018bf5a0bf8', 'CWSP', 'CWCW', '3a373a73-f7c1-4b84-b437-859db39d7f74', 16, 1, 'e27575b1-783d-4b26-a4ad-0985f8ad4d6e', now(), 'CJAMS-58664', now(), true, '', NULL, 'Guardianship Rate Approved ', '211030012366', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'GARR', 'e27575b1-783d-4b26-a4ad-0985f8ad4d6e', 'e27575b1-783d-4b26-a4ad-0985f8ad4d6e', '6123c7a6-29a7-4252-ac6b-2018bf5a0bf8', 'CWSP', 'CWSP', '3a373a73-f7c1-4b84-b437-859db39d7f74', 16, 1, 'e27575b1-783d-4b26-a4ad-0985f8ad4d6e', now(), 'CJAMS-58664', now(), true, '', NULL, 'Guardianship Rate Approved ', '211030012366', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


INSERT INTO cjams.gapratesrevision
(gapratesrevisionid, transactiondate, ratestartdate, rateenddate, paymentamt, "comments", approvalstatustypekey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, gaprateid, guardiansubsidyid, providerid, alternateid, etl_userid, etl_load_date)
VALUES(gen_random_uuid(), '2024-08-12 00:00:00.000', '2024-07-30 04:00:00.000', '2025-07-28 04:00:00.000', 926.79, NULL, '3047', now(), NULL, '2024-08-12 15:16:54.000', '46362254-be94-41ce-8b6b-4898090e8027', '2024-08-12 15:16:54.000', 'CJAMS-58664', 1, '3a373a73-f7c1-4b84-b437-859db39d7f74', '3a7e9214-4f5a-402a-aae9-0c4e4eeb9a1f', 6044962, 1283927, NULL, NULL);


update cjams.gapratesrevision
set approvaldate = now(),
    activeflag =0,
    updatedby = 'CJAMS-58664'
where gaprateid = '3a373a73-f7c1-4b84-b437-859db39d7f74' 
and gapratesrevisionid = '23b66f8a-c9b7-44a7-8d0e-c6485ebf135a'   
and activeflag=1;

--Inserting routing records for the child Alon Baugham CJAMS PID #200664320 with gaprateid aad181a6-d4ff-40b1-86c9-53cb84698771

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'GARR', 'e27575b1-783d-4b26-a4ad-0985f8ad4d6e', '46362254-be94-41ce-8b6b-4898090e8027', '6123c7a6-29a7-4252-ac6b-2018bf5a0bf8', 'CWSP', 'CWCW', 'aad181a6-d4ff-40b1-86c9-53cb84698771', 16, 1, 'e27575b1-783d-4b26-a4ad-0985f8ad4d6e', now(), 'CJAMS-58664', now(), true, '', NULL, 'Guardianship Rate Approved ', '211030012366', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'GARR', 'e27575b1-783d-4b26-a4ad-0985f8ad4d6e', 'e27575b1-783d-4b26-a4ad-0985f8ad4d6e', '6123c7a6-29a7-4252-ac6b-2018bf5a0bf8', 'CWSP', 'CWSP', 'aad181a6-d4ff-40b1-86c9-53cb84698771', 16, 1, 'e27575b1-783d-4b26-a4ad-0985f8ad4d6e', now(), 'CJAMS-58664', now(), true, '', NULL, 'Guardianship Rate Approved ', '211030012366', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


INSERT INTO cjams.gapratesrevision
(gapratesrevisionid, transactiondate, ratestartdate, rateenddate, paymentamt, "comments", approvalstatustypekey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, gaprateid, guardiansubsidyid, providerid, alternateid, etl_userid, etl_load_date)
VALUES(gen_random_uuid(), '2024-08-12 00:00:00.000', '2024-07-30 04:00:00.000', '2025-07-28 04:00:00.000', 926.79, NULL, '3047', now(), NULL, '2024-08-12 15:16:54.000', '46362254-be94-41ce-8b6b-4898090e8027', '2024-08-12 15:16:54.000', 'CJAMS-58664', 1, 'aad181a6-d4ff-40b1-86c9-53cb84698771', '3a7e9214-4f5a-402a-aae9-0c4e4eeb9a1f', 6044962, 1283927, NULL, NULL);


update cjams.gapratesrevision
set approvaldate = now(),
    activeflag =0,
    updatedby = 'CJAMS-58664'
where gaprateid = 'aad181a6-d4ff-40b1-86c9-53cb84698771' 
and gapratesrevisionid = '25971aad-d9d6-4527-bf42-8ee583aff837'   
and activeflag=1;


--Inserting routing records for the child ANDRETTI Baugham-Rhodes CJAMS PID #4288130 with gaprateid 9d34d256-e4cd-470d-9edb-37e88e4496be

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'GARR', 'e27575b1-783d-4b26-a4ad-0985f8ad4d6e', '46362254-be94-41ce-8b6b-4898090e8027', '6123c7a6-29a7-4252-ac6b-2018bf5a0bf8', 'CWSP', 'CWCW', '9d34d256-e4cd-470d-9edb-37e88e4496be', 16, 1, 'e27575b1-783d-4b26-a4ad-0985f8ad4d6e', now(), 'CJAMS-58664', now(), true, '', NULL, 'Guardianship Rate Approved ', '211030012366', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'GARR', 'e27575b1-783d-4b26-a4ad-0985f8ad4d6e', 'e27575b1-783d-4b26-a4ad-0985f8ad4d6e', '6123c7a6-29a7-4252-ac6b-2018bf5a0bf8', 'CWSP', 'CWSP', '9d34d256-e4cd-470d-9edb-37e88e4496be', 16, 1, 'e27575b1-783d-4b26-a4ad-0985f8ad4d6e', now(), 'CJAMS-58664', now(), true, '', NULL, 'Guardianship Rate Approved ', '211030012366', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


INSERT INTO cjams.gapratesrevision
(gapratesrevisionid, transactiondate, ratestartdate, rateenddate, paymentamt, "comments", approvalstatustypekey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, gaprateid, guardiansubsidyid, providerid, alternateid, etl_userid, etl_load_date)
VALUES(gen_random_uuid(), '2024-08-12 00:00:00.000', '2024-07-30 04:00:00.000', '2025-07-28 04:00:00.000', 926.79, NULL, '3047', now(), NULL, '2024-08-12 15:16:54.000', '46362254-be94-41ce-8b6b-4898090e8027', '2024-08-12 15:16:54.000', 'CJAMS-58664', 1, '9d34d256-e4cd-470d-9edb-37e88e4496be', '3a7e9214-4f5a-402a-aae9-0c4e4eeb9a1f', 6044962, 1283927, NULL, NULL);


update cjams.gapratesrevision
set approvaldate = now(),
    activeflag =0,
    updatedby = 'CJAMS-58664'
where gaprateid = '9d34d256-e4cd-470d-9edb-37e88e4496be' 
and gapratesrevisionid = '655f2f77-0eaf-4920-a05a-da709d3e6b28'   
and activeflag=1;
