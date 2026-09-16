/*
Issue Description: Payment has been interfaced but the Purchase Authorization status still showed as Pending Funding approval.
Category/Module: Error
Root cause: Purchase Authorization seems to have been approved without data entry
Fix provided: DB queries to change the pending status to approved
Data/Code fix ticket#: CDM-41185
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This error most likely happened from data entry
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating purchase authorization going to fiscal worker in routing
update routing
set tosecurityusersid = '93a6c41d-4e5a-4aca-9b5a-39e08c5ca1f7', activeflag = 0, updatedby = 'CDM-41185', updatedon = now()
where routingid = '1f3a0c2d-70f0-4f94-aabb-279d47c78203' and activeflag = 1;

--Inserting a new record in routing indicating the fiscal worker approved it
insert into routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid,
	activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, routeddescription, servicerequestnumber,
	objecttypekey)
values (gen_random_uuid(), 'PCAUTHR', '93a6c41d-4e5a-4aca-9b5a-39e08c5ca1f7', 'e4271184-e42a-4639-88a5-4168eb1814f7',
	'a7f4e8e4-a52e-4a5b-be32-07e18959cf9c', 'FNSFS', 'FNSFS', '1800969', 43, 1, 'CDM-41185', now(), 'CDM-41185', now(),
	true, 'Approved', 'Purchase Authorization Forwarded to Payment Approval', '3259780', 'ServiceCase');