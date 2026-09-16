/*
-- CDM-23899-- 

-- Issue Description: 
 Unable to close the case

-- Customer Email ID: adrianne.saba@maryland.gov

-- Root cause: Data fix to close the servicecase
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

UPDATE servicecase SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2022-07-18 10:52:02.342',
updatedby = 'CDM-23899',updatedon = now() WHERE servicecaseid = 'ab6d1da9-c877-4ad3-ac8c-756831f88901';


INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date, supervisorcomment, reopenreasonkey)
VALUES('bc0eb445-3a14-4a31-b5de-2f663c3b2bac', 'ab6d1da9-c877-4ad3-ac8c-756831f88901'::uuid, '2022-07-18 10:52:02.342', 'Closed', 'Closed', 'Case Closed', '2022-07-18 10:52:02.342', 1, 'CDM-23899', NOW(), 'CDM-23899', NOW(), NULL, NULL, NULL, NULL, NULL, NULL);


INSERT INTO cjams.routing
( eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES( 'SCDR', '0f8fbcb4-bc95-4005-9c54-4747eb2dc6b6', NULL, NULL, NULL, NULL, 'bc0eb445-3a14-4a31-b5de-2f663c3b2bac', 16, 1, 'CDM-23899', NOW(), 'CDM-23899', NOW(), false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);