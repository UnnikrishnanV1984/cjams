
/*
Issue Description: Need data fix to screened out and close the intake # I241013197097 and remove the service case # 241030441157.
Category/Module: Support
Root cause: Users cannot change the intake status or remove a service case
Fix provided: DB queries to screen the intake out, close it, and remove the service case
Data/Code fix ticket#: CDM-43449
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support ticket
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating intakesnapshot
update intakesnapshot
set jsondata = jsonb_set(
		jsonb_set(
			jsonb_set(
				jsonb_set(
					jsonb_set(
						jsonb_set(jsondata, '{DAType, DATypeDetail, 0, supDisposition}', '"ScreenOUT"', true),
					'{DAType, DATypeDetail, 0, dispositioncode}', '"ScreenOUT"', true),
				'{disposition, 0, supDisposition}', '"ScreenOUT"', true),
			'{disposition, 0, dispositioncode}', '"ScreenOUT"', true),
		'{intakeDATypeDetails, 0, supDisposition}', '"ScreenOUT"', true),
	'{intakeDATypeDetails, 0, dispositioncode}', '"ScreenOUT"', true), updatedby = 'CDM-43449', updatedon = now()
where intakesnapshotid = '6ea7ae50-468f-47ba-9ced-20b17a8c010d' and activeflag = 1;

--Updating routing
update routing
set routingstatustypeid = 8, supervisordecision = 'ScreenOUT', fromsecurityusersid = 'c132839a-76e5-498d-a8bd-306591287fc4',
	updatedon = now(), approveddate = now(), isreviewrequest = false, fromroleid = 'CWSP', activeflag = 0
where routingid = '34c0192b-6ec3-4c7a-90ef-744955c381a4' and activeflag =1;

update routing 
set activeflag = 0, updatedon = now()
where routingid = 'c404555b-222a-4463-a867-9dcd3553804a' and activeflag = 1;

--Updating intakeservicerequest
update intakeservicerequest
set intakeserreqstatustypeid = '642f18b0-ef6e-4d4b-9871-acc0734f3f5a', activeflag = 1, updatedby = 'CDM-43449', updatedon = now()
where intakeserviceid = '5d8b1bfe-d164-4b1f-98e5-9f4f5e6c303b';

--Updating intakedastaging
update intakedastaging
set status = 'Closed', updatedby = 'CDM-43449', updatedon = now()
where intakenumber = 'I241013197097' and activeflag = 1;

--Updating intakedastatus
update intakedastatus
set status = 8, updatedby = 'CDM-43449', updatedon = now()
where intakedastatusid = 'eb5390ab-2995-4c17-ae33-5a92cacd71d6' and activeflag = 1;

--Removing servicecase
update servicecase
set activeflag = 0, updatedby = 'CDM-43449', updatedon = now()
where servicecaseid = '5fcc7273-75b1-4dd5-926c-57e381a7b02c' and activeflag = 1;


--update servicecasedisposition 
update servicecasedisposition 
set activeflag = 0, updatedby = 'CD,M-43449', updatedon = now()
where servicecasedispositionid in ('096bdc05-be82-46c6-8c45-9e7008163161','0fd97ef6-1938-4841-891e-8e206284da36') and activeflag = 1;

--update caseassignment
update caseassignment
set activeflag = 0, updatedby = 'CDM-43449', updatedon = now()
where caseassignmentid ='7a7cea78-fbbf-47f7-8adf-1dd60318c7d1' and activeflag = 1;

--update routing
update routing
set activeflag = 0, updatedby = 'CDM-43449', updatedon = now()
where routingid = '5748c4e1-2c93-4e19-86b8-345d7220b306' and activeflag = 1;
