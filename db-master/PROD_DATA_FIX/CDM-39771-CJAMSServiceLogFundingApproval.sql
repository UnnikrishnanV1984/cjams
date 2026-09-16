/*
Issue Description: The user is having director approval role but her name is displayed under the purchase auth approval history for funding approval.
Category/Module: routing table
Root cause: Data fix to remove Abbey Niland's record from the purchase auth flow.
Fix provided: Yes, write db query
Code fix ticket#: CDM-39771
Reason why no related code fix: Status of the code fix already submitted
Status of the code fix if already submitted and expected prod fix date: N/A
Backup before update/ delete:
*/

--Reactivate previous approval request to pending
update routing
set 
	activeflag = 1,
	updatedby = 'CDM-39771',
	updatedon = now()
where routingid = 'd5c29189-7fb5-4d80-8264-1e3510825c40' and activeflag = 0;

--Hard deleting the Abbey Niland's approval request record from routing
delete from routing where routingid = '30b82257-b06a-4ffa-8867-db47e969c6b8';

--Insert the record back if required
/*
insert into routing
		(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid,
		activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, routeddescription, servicerequestnumber,
		objecttypekey)
values ('30b82257-b06a-4ffa-8867-db47e969c6b8', 'PCAUTH', '7476006c-1958-4c31-9f15-f9e6ad15dbb9', '362086ed-9366-451c-b7c1-b623d6de193b',
		'62f4f141-d1fe-4d68-8f88-60db503863c6', 'CWSP', 'CWSP', '3245956', 40, 0, '7476006c-1958-4c31-9f15-f9e6ad15dbb9',
		'2024-06-12 16:07:02', 'CDM-39771', '2024-06-25 14:39:15', true, 'Forwarded to Funding Approval',
		'Purchase Authorization Forwarded to Funding Approval', '3274809', 'ServiceCase');
*/