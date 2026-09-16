/* 
    Issue Description: CJAMS-68693
  Category/ Module  : Service log and PA
  Root cause: User request to add servicelog end date
        Please do the needful Data fix for the Kid
            Client Name
            TATIANA CARDENAS
            Client ID: 3706147
            Provider ID - 5084756 / start date 7/22/2019 needs to be end dated
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: 
  Backup before update/ delete: 
*/



UPDATE tb_service_log
SET end_dt = '2019-07-22',
    update_ts = now(),
    update_user_id = 'CJAMS-68693',
    end_service_reason_cd = '1824'  
WHERE service_log_id IN (937649)
    and case_id = 3246211
    and delete_sw = 'N';



update caseassignment
set enddate ='2019-07-22 00:00:00',
updatedby='CJAMS-68693',updatedon=now()
where caseassignmentid='c65ef765-e901-4806-806c-6d85a96d3ddd' and activeflag=1;

UPDATE servicecase 
SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2019-07-22 00:00:00', updatedby = 'CJAMS-68693',updatedon = now() 
WHERE servicecaseid = 'cb66ffbe-7be0-4733-aaae-e830be821a1f' and activeflag = 1;

INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date, supervisorcomment, reopenreasonkey)
VALUES(gen_random_uuid(), 'cb66ffbe-7be0-4733-aaae-e830be821a1f', '2019-07-22 00:00:00', 'Closed', 'Closed', 'Case is closed with ticket CJAMS-68693', '2019-07-22 00:00:00', 1, '6f7ced34-fb5b-4ed5-b382-85b2f48fdac5',now(), 'CJAMS-68693', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '6f7ced34-fb5b-4ed5-b382-85b2f48fdac5', 'de75a458-f28a-402d-9405-a62d440eda9b', '07c4e2d4-bad1-4da1-8e54-6a03a987307f', 'CWCW', 'CWSP', '', 15, 0, 'CJAMS-68693',now(), 'CJAMS-68693', now(), true, 'case is closed with ticket CJAMS-68693', NULL, (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68693'), '3246211', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', 'de75a458-f28a-402d-9405-a62d440eda9b', '6f7ced34-fb5b-4ed5-b382-85b2f48fdac5','07c4e2d4-bad1-4da1-8e54-6a03a987307f', 'CWSP', 'CWCW', (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68693'), 16, 1, 'CJAMS-68693', now(), 'CJAMS-68693', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', '3246211', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);