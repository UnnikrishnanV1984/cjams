
/*
   Issue Description: CDM-18039
   Category/ Module  : Reopening case closure
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


UPDATE servicecase SET statustypekey ='Open', dispositioncode = 'Open', enddate = null, updatedby = 'CDM-18039',updatedon = now() 
WHERE servicecaseid = '3079cb67-3454-4fc3-b412-421b8aedbf77';


INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date)
VALUES('74fe43a9-8917-4b05-9c6c-369a21d9995a'::uuid, '3079cb67-3454-4fc3-b412-421b8aedbf77'::uuid, NOW(), 'Open', 'Inprogress', 'Case Reopened', NOW(), 1, 'CDM-18039', Now(), 'CDM-18039', Now(), NULL, NULL, NULL, NULL) ON CONFLICT DO NOTHING;

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('SCDR', '8c0e1774-c485-4f55-a1a1-8ca6a7323a46', NULL, NULL, NULL, NULL, '74fe43a9-8917-4b05-9c6c-369a21d9995a', 16, 1, 'CDM-18039', now(), 'CDM-18039', now(), false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL) ON CONFLICT DO NOTHING;
