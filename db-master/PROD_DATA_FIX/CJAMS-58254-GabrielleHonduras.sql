
/*
Issue Description: Need data fix to screened out and close the intake # I251013200859 and remove the service case # 241030441157.
Category/Module: Bug
Root cause: Users cannot change the intake status or remove a service case
Fix provided: DB queries to screen the intake out,  and remove the service case
Data/Code fix ticket#: CJAMS-58254
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error 
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--1. update intakesnapshot, intakedastaging and routing (supervisordecision = screenOUT and routingstatustype = 2
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
	'{intakeDATypeDetails, 0, dispositioncode}', '"ScreenOUT"', true), updatedby = 'CJAMS-58254', updatedon = now()
where intakesnapshotid  = '716fa9ca-67ff-45f6-b1fb-39517921f354';


update intakedastaging
set jsondata = jsonb_set(
		jsonb_set(
			jsonb_set(
				jsonb_set(
					jsonb_set(
						jsonb_set(
							jsonb_set(jsondata, '{DAType, DATypeDetail, 0, supDisposition}', '"ScreenOUT"', true),
						'{DAType, DATypeDetail, 0, dispositioncode}', '"ScreenOUT"', true),
					'{disposition, 0, supDisposition}', '"ScreenOUT"', true),
				'{disposition, 0, dispositioncode}', '"ScreenOUT"', true),
			'{intakeDATypeDetails, 0, supDisposition}', '"ScreenOUT"', true),
		'{intakeDATypeDetails, 0, dispositioncode}', '"ScreenOUT"', true),
	'{General, addendumNarrative}', '"After additional review this referral has been sent to the Family Preservation Team for additional supports and services.<br><p>Additional services documented in Service Case #251030444867</p>"'),
updatedby = 'CJAMS-58254', updatedon = now()
where intakenumber = 'I251013200859' and activeflag = 1; 

update routing
set routingstatustypeid = 8, supervisordecision = 'ScreenOUT',updatedby = 'e4bcec66-b8ef-476f-915c-375f6c71a5d1', updatedon = now()
where objectid  = '82c95957-0e96-46a8-8f76-1320fd4fc6fb' and activeflag =1;
--2.
update intakeservicerequest 
set activeflag = 0,updatedon = now(),updatedby = 'CJAMS-58254'
where servicerequestnumber = '251022974941' and activeflag =1; 

update intakeservicerequestdispositioncode 
set activeflag = 0,updatedon = now(),updatedby = 'CJAMS-58254'
where intakeservicerequestdispositioncodeid = '8ae0de00-29a2-4d04-9d69-3a62151e3f9b' and activeflag = 1; 

update intakeservicerequestactor
set activeflag = 0,updatedon = now(),updatedby = 'CJAMS-58254'
where intakeservicerequestactorid in (
'510d6c76-8049-4c74-a355-2d2eb69ef493',
'38c71615-6b09-4303-be1e-417da85ac2ac',
'c4bfbbeb-5df3-436b-a721-1a84c1ae8317',
'88f7fa0a-e61d-49a1-8e0a-6fb62cfd14da',
'6e50ef94-c81b-41d1-862f-f7697d0183a3',
'a2396b41-35dd-4fc7-b8eb-58882eb5454d') and activeflag = 1; 

update caseassignment
set activeflag = 0,updatedon = now(),updatedby = 'CJAMS-58254'
where caseassignmentid = '76f49d8a-b3fc-4f51-97ff-bc750ea572da' and activeflag = 1;
