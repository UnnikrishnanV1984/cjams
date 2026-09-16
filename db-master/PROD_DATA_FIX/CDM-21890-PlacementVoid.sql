/*
   Issue Description: CDM-21890
   Category/ Module  :Placement
   Root cause: user wants to void placement 
   Pull request# for code fix: 5343
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
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
(    gen_random_uuid(), '41c29e85-9668-4035-bb1c-c3ee6a3c6e27', current_date, '2021-03-31 00:00:00', '08:00',
    NULL, NULL, NULL, NULL, '',
    '3045', current_date, '1', now(), 'CDM-21890',
    now(), 'CDM-21890', 1, nextval('sequence_placementrevision'::regclass), 'WKER',
    'Placement void Request.', NULL, NULL, NULL, NULL,
    1, now(), '0d92814e-d679-4778-b59d-036caf921998', now(), 'cbcdca4f-040a-4210-96ec-871b466d1188',
    now(), NULL, NULL, NULL, 'Approved'
);
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
(    gen_random_uuid(), '41c29e85-9668-4035-bb1c-c3ee6a3c6e27', current_date, '2021-03-31 00:00:00', '08:00',
    NULL, NULL, NULL, NULL, '',
    '3047', current_date, '1', now(), 'CDM-21890',
    now(), 'CDM-21890', 1, nextval('sequence_placementrevision'::regclass), 'WKER',
    'Placement void Request.', NULL, NULL, NULL, NULL,
    1, now(), '0d92814e-d679-4778-b59d-036caf921998', now(), 'cbcdca4f-040a-4210-96ec-871b466d1188',
    now(), NULL, NULL, NULL, 'Approved'
);
-- placement update
update placement
set isvoided = 1,
    voidapprovaldate = current_date,
    voidapprovalstatustypekey = '3047',
    voiddate = current_date,
    enddatetime = current_date,
    voidreasontypekey = 'WKER',
    updatedby = 'CDM-21890',
    updatedon = now()
where placementid = '41c29e85-9668-4035-bb1c-c3ee6a3c6e27'
    and activeflag = 1;


-- rounting
INSERT INTO cjams.routing
    (    routingid, eventcode, fromsecurityusersid, tosecurityusersid,
        teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag,
        insertedby, insertedon, updatedby, updatedon, isreviewrequest,
        remarks, old_id, routeddescription, servicerequestnumber, objecttypekey,
        old_from_id, old_to_id, principaltype, actiondatetime, etl_userid,
        etl_load_date, entityid, reassignnotes
    )
VALUES
    (    gen_random_uuid(), 'PLTR', '0d92814e-d679-4778-b59d-036caf921998', 'cbcdca4f-040a-4210-96ec-871b466d1188',
        'b431ff54-c49b-4b06-9c1d-bef4b09c62b8', 'CWCW', 'CWSP', '41c29e85-9668-4035-bb1c-c3ee6a3c6e27', 15, 0,
        'CDM-21890', now(), 'CDM-21890', now(), true,
        '', NULL, 'Placement Void Submitted for review', '2020030703964', 'Servicecase',
        NULL, NULL, NULL, NULL, NULL,
        NULL, NULL, NULL
    );

INSERT INTO cjams.routing
    (    routingid, eventcode, fromsecurityusersid, tosecurityusersid,
        teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag,
        insertedby, insertedon, updatedby, updatedon, isreviewrequest,
        remarks, old_id, routeddescription, servicerequestnumber, objecttypekey,
        old_from_id, old_to_id, principaltype, actiondatetime, etl_userid,
        etl_load_date, entityid, reassignnotes
    )
VALUES
    (    gen_random_uuid(), 'PLTR', 'cbcdca4f-040a-4210-96ec-871b466d1188', '0d92814e-d679-4778-b59d-036caf921998',
        'b431ff54-c49b-4b06-9c1d-bef4b09c62b8', 'CWSP', 'CWCW', '41c29e85-9668-4035-bb1c-c3ee6a3c6e27', 16, 1,
        'CDM-21890', now(), 'CDM-21890', now(), true,
        '', NULL, 'Child Placement Void Approved', '2020030703964', 'Servicecase',
        NULL, NULL, NULL, NULL, NULL,
        NULL, NULL, NULL
    );
