-- CDM-32640 - Case needs to be screened out
/*
-- Issue Description: 
	User Request to update Migrated Incomplete Intake status as screened-out# CW9939508
	
-- Category/ Module: Intake Referral (Intake Management) 
-- Root cause: Migrated Data issue (Incomplete Intake) 
-- Fix Provided: Datafix has been promoted to update Intake # CW9939508 status as screened-out 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Intake Number: CW9939508
update intakedastaging
set jsondata = replace(jsondata::text, 
	'"DaTypeKey": "00000000-0000-0000-0000-000000000000"', '"DaTypeKey": "247a8b26-cdee-4ce8-b36e-b37e49fd0103"')::json  
where intakenumber = 'CW9939508'
	and activeflag = 1 ;

update intakedastaging
set jsondata = replace(jsondata::text, 
	'"DAStatus": "Draft"', '"DAStatus": "Approved"')::json  
where intakenumber = 'CW9939508'
	and activeflag = 1 ;

update intakedastaging
set jsondata = replace(jsondata::text, 
	'"DADisposition": "Scrnin"', '"DADisposition": "ScreenOUT"')::json  
where intakenumber = 'CW9939508'
	and activeflag = 1 ;

update intakedastaging
set jsondata = replace(jsondata::text, 
	'"supDisposition": "Scrnin"', '"supDisposition": "ScreenOUT"')::json  
where intakenumber = 'CW9939508'
	and activeflag = 1 ;

update intakedastaging
set jsondata = replace(jsondata::text, 
	'"Purpose": "00000000-0000-0000-0000-000000000000~CW"', '"Purpose": "247a8b26-cdee-4ce8-b36e-b37e49fd0103~CW"')::json  
where intakenumber = 'CW9939508'
	and activeflag = 1 ;
	
select objectid, routingstatustypeid, updatedby, updatedon, activeflag
from routing 
where routingid = '394148ff-0eef-4670-9967-69b74af2a207' ;

update routing
	set routingstatustypeid = 8
where routingid = '394148ff-0eef-4670-9967-69b74af2a207' ;

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, 
	tosecurityusersid, teamid, 
	fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, 
	isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
values
(cjams.gen_random_uuid(), 'XXXX', 'fab84a8e-2e81-4699-a435-285c577e008b', 
	'fab84a8e-2e81-4699-a435-285c577e008b', 'd88fbd55-35e8-4dea-8b25-c032e0849de4', 
	'CWSP', 'CWCW', 'CW9939508', 1, 0, 'MTO165430', '2017-10-15 21:17:17', 'MTO165430', '2017-10-15 21:17:17', 
	false, NULL, 'CW9939508', NULL, NULL, NULL, '6008048', '6008048', NULL, NULL, NULL, NULL, NULL, NULL);
	