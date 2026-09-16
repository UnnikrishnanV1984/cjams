/*
Issue Description: Case looks like reopened but does not show on blue ribbon as re opened and user not able to create service plan for a re opened case
Category/Module: Bug
Root cause: Case seems to be reopened but not correctly
Fix provided: DB queries to properly reopen the case
Data/Code fix ticket#: CDM-42157
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR

Backup before update/ delete:Query:
delete from routing where objectid = '353f824a-9468-4230-9e23-ebb253f77634' and insertedby = 'CDM-42157' and activeflag = 1;
*/

--Updating servicecase
update servicecase
set statustypekey = 'Open', dispositioncode = 'Open', updatedby = 'CDM-42157', updatedon = now()
where servicecaseid = '0b39c356-c582-4346-abcd-dd2562c5d715' and activeflag = 1;

--Updating servicecasedisposition
--UPDATE: corrected the incorrect reasonkey
update servicecasedisposition
set intakeserreqstatustypekey = 'Reopen', updatedby = 'CDM-42157', reopenreasonkey = null, updatedon = now()
where activeflag = 1 and servicecasedispositionid in (
'9eca27cc-b84a-4e9c-b443-bb8f7f6230db',
'07fc8617-9520-4260-8705-7963e5c92c16',
'353f824a-9468-4230-9e23-ebb253f77634');

insert into routing
	(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag,
	insertedby, insertedon, updatedby, updatedon, isreviewrequest, routeddescription, objecttypekey)
values (gen_random_uuid(), 'SCDR', 'ba51d587-d94f-4b54-8225-78af2eab1214', 'd8a2c4ce-3d4e-47d2-9abb-a3a32eadc293',
	'2083200e-1403-4c14-8788-0a6937c2122f', 'CWSP', 'CWCW', '353f824a-9468-4230-9e23-ebb253f77634', 16, 1, 'CDM-42157', now(), 'CDM-42157', now(),
	false, 'Disposition Auto Approved', 'servicecase');