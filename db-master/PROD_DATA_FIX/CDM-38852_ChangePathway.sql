/*
Issue Description: CDM-38852: 241022072570:Trying to change the Pathway from AR to IR and the select reason button has no reasons to select populating. I tried to do it as did my co-supervisor in screening was not able to either.
Category/ Module : Bug
Root cause: 241022072570 case is CPS-AR but wasn't recorded as such
Fix provided :yes, write Db query 
Code fix ticket#:CDM-38852
Reason why no related code fix: Status of the code fix  already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--UPDATE Service Case to CPS-AR

update intakeservicerequestsdm
set
	isar = true,
	updatedby = 'CDM-38852',
	updatedon = now()
where intakeserviceid = 'f34a6d14-117c-4ffb-815e-4cf930d62bb0';

--UPDATE Intake to CPS-AR

update intakedastaging
set 
	jsondata = jsonb_set(jsondata, '{sdm}', jsonb_set(jsondata->'sdm', '{isar}', 'true')),
	updatedby = 'CDM-38852',
	updatedon = now()
where intakenumber = 'I241012243828' and activeflag = 1;

update intakedastaging
set
	jsondata = jsonb_set(jsondata, '{sdm}', jsonb_set(jsondata->'sdm', '{cpsResponseType}', '"CPS-AR"')),
	updatedby = 'CDM-38852',
	updatedon = now()
where intakenumber = 'I241012243828' and activeflag = 1;

update intakedastaging
set
	jsondata = jsonb_set(jsondata, '{sdm}',
	jsonb_set(jsondata->'sdm', '{screenOut}',
	jsonb_set(jsondata->'sdm'->'screenOut', '{isscrnoutrecovr_otherspecify}', 'null' )))
where intakenumber = 'I241012243828' and activeflag = 1;

update intakesnapshot 
set 
	jsondata = jsonb_set(jsondata, '{sdm}', jsonb_set(jsondata->'sdm', '{isar}', 'true')),
	updatedby = 'CDM-38852',
	updatedon = now()
where intakenumber = 'I241012243828' and activeflag = 1;

update intakesnapshot 
set
	jsondata = jsonb_set(jsondata, '{sdm}', jsonb_set(jsondata->'sdm', '{cpsResponseType}', '"CPS-AR"')),
	updatedby = 'CDM-38852',
	updatedon = now()
where intakenumber = 'I241012243828' and activeflag = 1;

update intakesnapshot 
set
	jsondata = jsonb_set(jsondata, '{sdm}',
	jsonb_set(jsondata->'sdm', '{screenOut}',
	jsonb_set(jsondata->'sdm'->'screenOut', '{isscrnoutrecovr_otherspecify}', 'null' )))
where intakenumber = 'I241012243828' and activeflag = 1;