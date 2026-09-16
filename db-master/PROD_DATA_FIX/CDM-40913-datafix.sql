/*
  Issue Description: CDM-40913
   Category/ Module  :placement
   Root cause:  Data fix to approve the placement
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 1
*/

update placement  
set enddatetime = '2021-03-02 00:00:00.000', 
    updatedon = now(), 
    updatedby = 'CDM-40913'
where placementid = '599830d7-741a-4abe-ad92-1f1dd1b3aed4'
    and activeflag = 1 ;
    

INSERT INTO cjams.placementrevision
(    placementrevisionid, placementid, transactiondate, entrydate, entrytime, 
    exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, 
    approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, 
    updatedon, updatedby, activeflag, alternateid, voidreasontypekey, 
    voidremarks, enddate, endtime, exittypekey, remarks, 
    isvoided, voiddate, requestedby, requesteddate, approvedby, 
    approveddate, etl_userid, etl_load_date, ischangepreadoptive, status
)
VALUES
(    gen_random_uuid(), '599830d7-741a-4abe-ad92-1f1dd1b3aed4', current_date, '2020-09-22 00:00:00.000', '12:00', 
    '2021-03-02 00:00:00.000', '08:00', NULL, 'CIPO', '', 
    '3047', current_date, NULL, now(), 'CDM-40913', 
    now(), 'CDM-40913', 1, nextval('sequence_placementrevision'::regclass), NULL, 
    NULL, NULL, NULL, 'CIP', NULL, 
    0, now(), '831b6bfe-c3cf-43ec-9f55-5272d945c024', now(), 'd636ac2f-53ff-43e0-adbf-35c97e0427ec', 
    now(), NULL, NULL, NULL, 'Approved'
);

update placementrevision
set activeflag = 0,
    status =  'Approved',
    approvedby = 'd636ac2f-53ff-43e0-adbf-35c97e0427ec',
    approveddate = now(),
    updatedon = now(), 
    updatedby = 'CDM-40913'    
where placementid  = '599830d7-741a-4abe-ad92-1f1dd1b3aed4'
    and placementrevisionid = '701d8191-cc36-4802-b247-3b4180a6d503' 
    and activeflag = 1;

 delete from placementrevision 
where placementrevisionid  
    in (    'db7bf9ed-98e5-4579-8fe5-e768589d84fa',
            'abc587a6-51cf-42b6-817f-a5f223f3c9ce',
            'c0fa4890-064c-41cc-aacd-cbf9dccf9a87',
            'd3b0d3d6-618c-4b51-a409-3a654418bd9c'
        ) ;
       
       /*
         INSERT INTO cjams.placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status, primaryrelationship, leastrestrictiveplacement, transferagency, otherpublicagency)
VALUES('abc587a6-51cf-42b6-817f-a5f223f3c9ce', '599830d7-741a-4abe-ad92-1f1dd1b3aed4', '2024-08-08 00:00:00.000', '2020-09-22 00:00:00.000', '12:00', '2021-03-02 00:00:00.000', '08:00', NULL, 'CIPO', '', '3045', '2024-08-08 00:00:00.000', '1', '2024-05-31 13:52:49.576', '317da7b0-5a39-4f26-bcd1-9947984e2fbe', '2024-05-31 13:52:49.576', '317da7b0-5a39-4f26-bcd1-9947984e2fbe', 0, 2018463, NULL, NULL, NULL, NULL, 'CIP', 'De''asia transitioned from a diagnostic placement to Arrows'' Ascension place high intensity group home. ', 0, NULL, '317da7b0-5a39-4f26-bcd1-9947984e2fbe', '2024-05-31 13:52:49.576', NULL, NULL, NULL, NULL, NULL, 'Incorrect exit date', 'Review', NULL, 'Not a change in placement ', NULL, NULL);

INSERT INTO cjams.placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status, primaryrelationship, leastrestrictiveplacement, transferagency, otherpublicagency)
VALUES('c0fa4890-064c-41cc-aacd-cbf9dccf9a87', '599830d7-741a-4abe-ad92-1f1dd1b3aed4', '2024-08-08 00:00:00.000', '2020-09-22 00:00:00.000', '12:00', '2021-03-02 00:00:00.000', '08:00', NULL, 'CIPO', '', '3045', '2024-08-08 00:00:00.000', '1', '2024-05-31 13:50:48.165', '0df3e7ac-4476-4dde-bf04-af2c7063d102', '2024-05-31 13:50:48.165', '0df3e7ac-4476-4dde-bf04-af2c7063d102', 0, 2018430, NULL, NULL, NULL, NULL, 'CIP', 'De''asia transitioned from a diagnostic placement to Arrows'' Ascension place high intensity group home. ', 0, NULL, '0df3e7ac-4476-4dde-bf04-af2c7063d102', '2024-05-31 13:50:48.165', NULL, NULL, NULL, NULL, NULL, 'Incorrect exit date', 'Review', NULL, 'Not a change in placement ', NULL, NULL);

INSERT INTO cjams.placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status, primaryrelationship, leastrestrictiveplacement, transferagency, otherpublicagency)
VALUES('d3b0d3d6-618c-4b51-a409-3a654418bd9c', '599830d7-741a-4abe-ad92-1f1dd1b3aed4', '2024-08-08 00:00:00.000', '2020-09-22 00:00:00.000', '12:00', '2021-03-02 00:00:00.000', '08:00', NULL, 'CIPO', '', '3045', '2024-08-08 00:00:00.000', '1', '2023-09-08 11:09:50.503', 'ba2dbc8f-3213-4b1b-9905-d643e1692db1', '2023-09-08 11:09:50.503', 'ba2dbc8f-3213-4b1b-9905-d643e1692db1', 0, 1555030, NULL, NULL, NULL, NULL, 'CIP', 'De''asia transitioned from a diagnostic placement to Arrows'' Ascension place high intensity group home. ', 0, NULL, 'ba2dbc8f-3213-4b1b-9905-d643e1692db1', '2023-09-08 11:09:50.503', NULL, NULL, NULL, NULL, NULL, 'Incorrect exit date', 'Review', NULL, 'Not a change in placement ', NULL, NULL);

INSERT INTO cjams.placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status, primaryrelationship, leastrestrictiveplacement, transferagency, otherpublicagency)
VALUES('db7bf9ed-98e5-4579-8fe5-e768589d84fa', '599830d7-741a-4abe-ad92-1f1dd1b3aed4', '2024-08-08 00:00:00.000', '2020-09-22 00:00:00.000', '12:00', '2021-03-02 00:00:00.000', '08:00', NULL, 'CIPO', '', '3045', '2024-08-08 00:00:00.000', '1', '2024-06-05 14:10:38.260', '3f8e38e7-3667-4181-9659-345a717d38a1', '2024-06-05 14:10:38.260', '3f8e38e7-3667-4181-9659-345a717d38a1', 0, 2029782, NULL, NULL, NULL, NULL, 'CIP', 'De''asia transitioned from a diagnostic placement to Arrows'' Ascension place high intensity group home. ', 0, NULL, '3f8e38e7-3667-4181-9659-345a717d38a1', '2024-06-05 14:10:38.260', NULL, NULL, NULL, NULL, NULL, 'Incorrect exit date', 'Review', NULL, 'Not a change in placement ', NULL, NULL);
*/
       
      
update cjams.routing
set activeflag = 0,
    updatedon = now(), 
    updatedby = 'CDM-40913'        
where routingid = 'd3300b2a-0f7d-429b-a41d-ec803b6ade47'
    and activeflag = 1 ;


INSERT INTO cjams.routing
    (    routingid, eventcode, fromsecurityusersid, tosecurityusersid, 
        teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
        insertedby, insertedon, updatedby, updatedon, isreviewrequest, 
        remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, 
        old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, 
        etl_load_date, entityid, reassignnotes
    )
VALUES
    (    gen_random_uuid(), 'PLTR', '3f8e38e7-3667-4181-9659-345a717d38a1', 'd636ac2f-53ff-43e0-adbf-35c97e0427ec', 
        '6629c2a6-9d4d-4d3f-b6c2-0d842f161cc6', 'CWCW', 'CWSP', '599830d7-741a-4abe-ad92-1f1dd1b3aed4', 16, 1, 
        'CDM-40913', now(), 'CDM-40913', now(), true, 
        '', NULL, 'Child Placement Approved', '3179727', 'Servicecase', 
        NULL, NULL, NULL, NULL, NULL, 
        NULL, NULL, NULL
    );
    
 delete from routing
 where routingid in ('65594861-759c-4a7f-99b1-09fb67cfd757',
 'e738c6e3-164f-4c2a-85e9-17d4c4cc1f35','c0d6d030-56dd-48f0-a370-1f93bbf421e7',
 '3bca7e72-2172-454c-ae06-6e99d96a5e30','a5c66b78-a96a-4ba9-8def-06e38fbb760c',
 '094d5df7-0f57-4abe-baa0-d23984cdd80d','dfe4013c-6237-4e21-add6-ae741be64055') 
  and eventcode='PLTR' and activeflag=0;
   
 /* 
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('65594861-759c-4a7f-99b1-09fb67cfd757', 'PLTR', '831b6bfe-c3cf-43ec-9f55-5272d945c024', '9f80d4f6-09f6-49ff-b892-c1474c4c2ec7', 'dafa95a0-8fb4-455c-b75c-7ca8ecdaf363', 'CWCW', 'CWSP', '599830d7-741a-4abe-ad92-1f1dd1b3aed4', 15, 0, '831b6bfe-c3cf-43ec-9f55-5272d945c024', '2020-11-08 16:28:46.629', '9f80d4f6-09f6-49ff-b892-c1474c4c2ec7', '2020-11-08 20:16:56.696', true, '', NULL, 'Provider placement submitted for review', '3179727', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('e738c6e3-164f-4c2a-85e9-17d4c4cc1f35', 'PLTR', '831b6bfe-c3cf-43ec-9f55-5272d945c024', '9f80d4f6-09f6-49ff-b892-c1474c4c2ec7', 'dafa95a0-8fb4-455c-b75c-7ca8ecdaf363', 'CWCW', 'CWSP', '599830d7-741a-4abe-ad92-1f1dd1b3aed4', 15, 0, '831b6bfe-c3cf-43ec-9f55-5272d945c024', '2021-02-02 09:46:55.372', '9f80d4f6-09f6-49ff-b892-c1474c4c2ec7', '2021-02-02 11:34:49.759', true, '', NULL, 'Placement Exit Submitted for review', '3179727', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('c0d6d030-56dd-48f0-a370-1f93bbf421e7', 'PLTR', 'ba2dbc8f-3213-4b1b-9905-d643e1692db1', '056865a7-2a58-494e-9993-ccc6fd9aae58', '6629c2a6-9d4d-4d3f-b6c2-0d842f161cc6', 'CWSP', 'CWSP', '599830d7-741a-4abe-ad92-1f1dd1b3aed4', 15, 0, 'ba2dbc8f-3213-4b1b-9905-d643e1692db1', '2023-05-26 16:15:56.396', 'ba2dbc8f-3213-4b1b-9905-d643e1692db1', '2023-05-26 16:16:59.258', true, '', NULL, 'Placement Exit Submitted for review', '3179727', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('3bca7e72-2172-454c-ae06-6e99d96a5e30', 'PLTR', 'ba2dbc8f-3213-4b1b-9905-d643e1692db1', '056865a7-2a58-494e-9993-ccc6fd9aae58', '6629c2a6-9d4d-4d3f-b6c2-0d842f161cc6', 'CWSP', 'CWSP', '599830d7-741a-4abe-ad92-1f1dd1b3aed4', 15, 0, 'ba2dbc8f-3213-4b1b-9905-d643e1692db1', '2023-09-08 11:09:49.975', '0df3e7ac-4476-4dde-bf04-af2c7063d102', '2024-05-31 13:50:47.619', true, '', NULL, 'Placement Exit Submitted for review', '3179727', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('a5c66b78-a96a-4ba9-8def-06e38fbb760c', 'PLTR', '0df3e7ac-4476-4dde-bf04-af2c7063d102', '37740f7a-c5f8-41c3-9b29-22410a457604', '5570254a-59cb-46e6-a1ce-92b21c3cfd08', 'CWCW', 'CWSP', '599830d7-741a-4abe-ad92-1f1dd1b3aed4', 15, 0, '0df3e7ac-4476-4dde-bf04-af2c7063d102', '2024-05-31 13:50:47.619', '317da7b0-5a39-4f26-bcd1-9947984e2fbe', '2024-05-31 13:52:49.014', true, '', NULL, 'Placement Exit Submitted for review', '3179727', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('094d5df7-0f57-4abe-baa0-d23984cdd80d', 'PLTR', '317da7b0-5a39-4f26-bcd1-9947984e2fbe', '0df3e7ac-4476-4dde-bf04-af2c7063d102', '5570254a-59cb-46e6-a1ce-92b21c3cfd08', 'CWCW', 'CWSP', '599830d7-741a-4abe-ad92-1f1dd1b3aed4', 15, 0, '317da7b0-5a39-4f26-bcd1-9947984e2fbe', '2024-05-31 13:52:49.014', '3f8e38e7-3667-4181-9659-345a717d38a1', '2024-06-05 14:10:37.729', true, '', NULL, 'Placement Exit Submitted for review', '3179727', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('dfe4013c-6237-4e21-add6-ae741be64055', 'PLTR', '3f8e38e7-3667-4181-9659-345a717d38a1', 'd636ac2f-53ff-43e0-adbf-35c97e0427ec', '6629c2a6-9d4d-4d3f-b6c2-0d842f161cc6', 'CWCW', 'CWSP', '599830d7-741a-4abe-ad92-1f1dd1b3aed4', 15, 0, '3f8e38e7-3667-4181-9659-345a717d38a1', '2024-06-05 14:10:37.729', '3f8e38e7-3667-4181-9659-345a717d38a1', '2024-08-08 10:15:44.247', true, '', NULL, 'Placement Exit Submitted for review', '3179727', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/