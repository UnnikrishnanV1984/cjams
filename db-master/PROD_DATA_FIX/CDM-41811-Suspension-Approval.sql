/*
Issue Description: Approve GAP suspension from reviewed
Category/Module: Bug
Root cause: GAP suspension couldn't be approved because this is a migration case with incomplete fields
Fix provided: DB query to approve GAP suspension approval request
Data/Code fix ticket#: CDM-41811
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating routing
update routing
set activeflag = 0, updatedby = 'CDM-41811', updatedon = now()
where routingid = 'e7c09cc8-a4ad-41ff-8173-ffb7f1b818d4' and activeflag = 1;

update routing
set activeflag = 0, updatedby = 'CDM-41811', updatedon = now()
where objectid in ('a584b13f-ff51-41a1-978f-15d861530251', '33bcf6b9-414e-4f5d-be16-92933ff3147c') and activeflag = 1;

insert into routing
	(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag,
	insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, routeddescription, servicerequestnumber, objecttypekey)
values (gen_random_uuid(), 'GASR', '3ca8e63d-f885-445b-aab9-24456e91ad4a', 'b9c2e801-a3c9-4ad4-8ba2-698be7659c46',
	'b50f2419-42ba-4ab6-84ab-5172917d2d77', 'CWSP', 'CWCW', '1151d204-af20-4ee4-a4fd-96b66c6f9d15', 16, 1, 'CDM-41811', now(), 
	'CDM-41811', now(), false, 'GAP Suspension Approved', 'GAP Suspension Approved', '3111128', 'Servicecase');
	
--Updating gapsuspension
update gapsuspension
set enddate = '2024-08-21 04:00:00', updatedby = 'CDM-41811', updatedon = now()
where gapsuspensionid = '1151d204-af20-4ee4-a4fd-96b66c6f9d15' and activeflag = 1;

--Updating gapsuspensionrevision
update gapsuspensionrevision
set approvalstatustypekey = '3047', approvaldate = now(), updatedby = 'CDM-41811', updatedon = now()
where gapsuspensionrevisionid = '3e9c73de-65a6-46e1-a468-01c4a807ee2b' and activeflag = 1;

update gapsuspension
set activeflag = 0, updatedby = 'CDM-41811', updatedon = now()
where gapsuspensionid in ('a584b13f-ff51-41a1-978f-15d861530251', '33bcf6b9-414e-4f5d-be16-92933ff3147c') and activeflag = 1;

--Updating gapraterevision
update gapratesrevision 
set approvaldate = now(), updatedby = 'CDM-41811', updatedon = now()
where gaprateid in ('58a56fc6-5305-4aec-8354-bd2d8b79f5e9', '9600f854-255f-4d98-8e78-a1e587c3be9c');