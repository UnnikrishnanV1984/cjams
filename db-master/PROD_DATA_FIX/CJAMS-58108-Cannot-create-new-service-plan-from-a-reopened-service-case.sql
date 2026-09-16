/*
Issue Description: Case looks like reopened but does not show on blue ribbon as re opened and user not able to create service plan for a re opened case
Category/Module: Bug
Root cause: Case seems to be reopened but not correctly
Fix provided: DB queries to properly reopen the case
Data/Code fix ticket#: CDM-43902
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#: N/A
Reason why no related code fix: Data error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR

Backup before update/ delete:Query:
delete from routing where objectid = '353f824a-9468-4230-9e23-ebb253f77634' and insertedby = 'CDM-42157' and activeflag = 1;
*/

/*
select * from servicecasedisposition where servicecasedispositionid = 'ee47d4d0-ee2d-4676-9855-a4646cf0e9d4' --open --> reopen
*/

update servicecasedisposition 
set		intakeserreqstatustypekey = 'Reopen',
		updatedby = 'CJAMS-58108',
		updatedon = now()
where servicecasedispositionid = 'ee47d4d0-ee2d-4676-9855-a4646cf0e9d4' --open --> reopen
and activeflag =1;

--reverting code
/*
update servicecasedisposition 
set		intakeserreqstatustypekey = 'Open',
		updatedby = 'CJAMS-58108',
		updatedon = now()
where servicecasedispositionid = 'ee47d4d0-ee2d-4676-9855-a4646cf0e9d4' --open --> reopen
and activeflag =1;
*/


INSERT INTO cjams.routing
(routingid,
eventcode,
fromsecurityusersid,
tosecurityusersid,
teamid,
fromroleid,
toroleid,
objectid,
routingstatustypeid,
activeflag, 
insertedby,
insertedon,
updatedby,
updatedon,
isreviewrequest,
remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
values
(gen_random_uuid(), 
'SCDR', 
'ef3032b3-2f5a-4b48-8b27-c33cf654abf6',
NULL, 
NULL,
NULL, 
NULL, 
'ee47d4d0-ee2d-4676-9855-a4646cf0e9d4',
16, 
1, 
'0d221a83-4a79-47b0-9e9a-ec7dccaa8844',
'2025-01-17 15:19:25', 
'CJAMS-58108', 
now(), 
false, 
NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL); 
--routingid: 98ac1634-83f1-468c-8ee8-4be061d6ad9a

--reverting code
/*update routing 
set activeflag =0,
	updatedby ='CJAMS-58108',
	updatedon = now()
where routingid = '98ac1634-83f1-468c-8ee8-4be061d6ad9a'
and activeflag =1;*/
