/*
   Issue Description: CDM-32397
   Category/ Module  :Intake Approval
   Root cause: Reopen intake should be available in user dashboard
   Pull request# for code fix: 
   Reason why no related code fix: 
   requested a data fix to resolve: 
*/

-- INSERT INTO cjams.routing
-- (routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
-- VALUES('e7b66607-7643-4b24-8f48-1f34d83bc6e2', 'INTR', 'c419fccf-f344-4c4d-8f40-7e130ce74ee4', 'b5b6357a-9742-441c-936e-65a3f737f152', 'fe8d081b-96de-4850-bbb8-888d00638fbc', 'CWIW', 'CWSP', 'I231010662149', 21, 0, 'c419fccf-f344-4c4d-8f40-7e130ce74ee4', '2023-06-21 11:06:17.807', 'b5b6357a-9742-441c-936e-65a3f737f152', '2023-06-21 14:23:43.431', true, 'Make this referral a risk of harm caregiver impairment. ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

DELETE FROM cjams.routing
WHERE routingid='e7b66607-7643-4b24-8f48-1f34d83bc6e2';

UPDATE cjams.routing
SET eventcode='INTR', activeflag=1
WHERE routingid='4bb42006-948e-4b0e-9fbf-b65af6b86110';

UPDATE intakedastaging
SET status = 'pending', ispreintake = FALSE, updatedon = now(), updatedby = 'CDM-32397',
jsondata = replace (jsondata::text,  '"ispreintake": true', '"ispreintake": false' )::jsonb
WHERE intakenumber = 'I231010662149' AND activeflag = 1;

UPDATE intakedastatus
SET status = 1, ispreintake = FALSE, updatedon = now(), updatedby = 'CDM-32397'
WHERE intakenumber = 'I231010662149' AND activeflag = 1;

UPDATE intakesnapshot
SET activeflag = 0, updatedon = now(), updatedby = 'CDM-32397'
WHERE intakenumber = 'I231010662149' AND activeflag = 1;


