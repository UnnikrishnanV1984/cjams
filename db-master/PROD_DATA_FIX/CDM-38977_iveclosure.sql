-- CDM-38977 - Case closure
/* Issue Description:User not able to close the case #3124680

-- caseid: 3124680
-- clientid: 1413188
-- servicecaseid: cf313db6-9d08-465b-a6b4-49074bcd5b41

-- Category/ Module: IVE Case Clouser 

-- Root cause: User not able to close the case #3124680 
-- Fix Provided: Datafix has been provided to update client elibility where case id is null for the client
-- Pull request# N/A

*/

--reverting case closure request
UPDATE cjams.ivecaseclosurereview
SET activeflag=0,
updatedby='CDM-38977',
updatedon=now()
WHERE objectid='cf313db6-9d08-465b-a6b4-49074bcd5b41';

UPDATE cjams.routing
SET activeflag=0,
updatedby='CDM-38977',
updatedon=now()
WHERE objectid='3f1d542c-9b72-4546-9660-8c3bf549720e';

--close case
INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date)
VALUES('e4e6f963-a68a-404c-bf4b-2b74ed8155a9', 'cf313db6-9d08-465b-a6b4-49074bcd5b41', now(), 'Closed', 'Closed', 'Closed', now(), 1, '86230c1f-0923-4501-9d80-0661a3c5d060', now(), '86230c1f-0923-4501-9d80-0661a3c5d060', now(), NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('SCDR', 'bd2be887-3873-4ff2-b6a9-8bafa585aba0', NULL, NULL, NULL, NULL, 'e4e6f963-a68a-404c-bf4b-2b74ed8155a9', 16, 1, 'bd2be887-3873-4ff2-b6a9-8bafa585aba0', now(), 'bd2be887-3873-4ff2-b6a9-8bafa585aba0', now(), false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

UPDATE cjams.servicecase 
SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = now(), updatedby = 'CDM-38977',updatedon = now() WHERE servicecaseid = 'cf313db6-9d08-465b-a6b4-49074bcd5b41' and activeflag = 1;


