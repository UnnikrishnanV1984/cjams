
/*
   Issue Description: CDM-17625
   Category/ Module  :  Removing Case plan pending records
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- CDM-17625 - close service case

INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date)
VALUES('a83650a5-af46-46d5-9922-3f8eb56e7495', 'c86d0083-1792-424d-a3ab-51030f8eeff3', '2021-10-15'::date, 'Closed', 'Closed', 'ICPC case needing to be closed. Supervisor TL is closing due to the worker being out on leave.', '2021-10-15'::date, 1, '547109cd-10d4-4d38-8da0-ad5060b1e9e7', now(), '547109cd-10d4-4d38-8da0-ad5060b1e9e7', now(), NULL, NULL, NULL, NULL) ON CONFLICT DO NOTHING;

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('SCDR', 'a37cfda9-e898-4c94-8eef-7f565e129bf2', NULL, NULL, NULL, NULL, 'a83650a5-af46-46d5-9922-3f8eb56e7495', 16, 1, 'a37cfda9-e898-4c94-8eef-7f565e129bf2', now(), 'a37cfda9-e898-4c94-8eef-7f565e129bf2', now(), false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL) ON CONFLICT DO NOTHING;

UPDATE cjams.servicecase 
SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2021-10-15'::date, updatedby = 'CDM-17625',updatedon = now() WHERE servicecaseid = 'c86d0083-1792-424d-a3ab-51030f8eeff3' and activeflag = 1;
