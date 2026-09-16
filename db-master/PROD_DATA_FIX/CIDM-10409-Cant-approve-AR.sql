-- Category/ Module: Finance
-- Please proceed with the data fix to re-route the write-off request to Pat Spann (patricia.spann@montgomerycountymd.gov)
-- Provider ID: 6194503 (William M Gigax)
-- Client ID: 4016763 (Hussan Felder)
-- Receivable Detail ID: 1755792
-- Root cause: User Request to forward Receivable Write-Off approval reuest to diff supervisor

-- Fix Provided: Datafix has been promoted to forward Receivable Write-Off approval request to Pat Spann (patricia.spann@montgomerycountymd.gov)
-- Pull request# N/A 
-- Is Code fix Required?: No
--    Code fix ticket#: N/A
--    Reason why no related code fix: This issue was fixed back in 2021.
--  Regression Impacts: N/A

INSERT INTO cjams.routing
(routingid,eventcode,fromsecurityusersid, tosecurityusersid,teamid, fromroleid,toroleid,
objectid,
routingstatustypeid,
activeflag,
insertedby,
insertedon,
updatedby,
updatedon,
isreviewrequest,
remarks,
old_id,
routeddescription,
servicerequestnumber,
objecttypekey,
old_from_id,
old_to_id, 
principaltype,
actiondatetime,
etl_userid, 
etl_load_date,
entityid, 
reassignnotes,
intakerecommendation,
supervisordecision,
approveddate)
VALUES(gen_random_uuid(),
'FNSWO','e4271184-e42a-4639-88a5-4168eb1814f7','49210800-530c-43cc-bd5c-7d045ba54883', 'c785fb5e-b0f4-4f4a-acf8-f9a563c10fc1','FNSFS','FNSFS',
'1755792',
30, 
1, 
'e4271184-e42a-4639-88a5-4168eb1814f7',
'2025-04-16 16:35:16',
'CJAMS-10409',
now(),
true,
'Write off request   Submitted for review',
NULL, 
'Write off request  Submitted for review',
NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);