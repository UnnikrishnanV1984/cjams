/*
Issue Description: Please do a data fix to populate the supervisor decision as 'screen out' and make sure the approve button is not displayed after updating the supervisor decision.
Category/Module: Error
Root cause: Seems the case worker submitted another screenout request after supervisor already approved
Fix provided: DB queries to screen the case out
Data/Code fix ticket#:CDM-42244
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating intakesnapshot
update intakesnapshot 
set jsondata = jsonb_set(
		jsonb_set(
			jsonb_set(jsondata, '{DAType, DATypeDetail, 0, supDisposition}', '"ScreenOUT"', false),
			'{disposition, 0, supDisposition}', '"ScreenOUT"', false),
		'{intakeDATypeDetails, 0, supDisposition}', '"ScreenOUT"', false),
	updatedby = 'CDM-42244', updatedon = now()
where intakesnapshotid = '340498ac-47ab-4ef8-aab8-28e3cf2387a1' and activeflag = 1;

--Updating intakedastatus
update intakedastatus
set status = 8, updatedby = 'CDM-42244', updatedon = now()
where intakedastatusid = '8bbda67b-2ad3-481e-b37c-41884b2e2360' and activeflag = 1;

--Updating routing (cannot change updatedby because that affects submission history)
update routing
set activeflag = 0, routingstatustypeid = 8, supervisordecision = 'screenout', updatedon = now()
where routingid in ('7dac36a6-1ab8-4f40-9e6c-96a3ab66cab1', 'c4cb8c68-be89-4680-9006-b933d1b6f7dd');