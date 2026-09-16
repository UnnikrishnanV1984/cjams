UPDATE intakesnapshot 
SET 
updatedby = 'CDM-13253', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202100356405' AND activeflag=1;

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-13253', updatedon = now() where intakenumber = 'I202100356405';

update intakedastaging 
	
	set status = 'Closed', updatedby = 'CDM-13253', updatedon = now()
	
	where intakenumber = 'I202100356405'
	and activeflag = 1;
	
update personprogramarea set 
activeflag = 0,
updatedby = 'CDM-13253',
updatedon = now()
where personprogramid in ('4807bfcb-b6ac-4367-988d-6b926af50039','81eddf71-62c9-4751-85c8-0c2c7876f082','73c885e8-3ef4-4ff1-9124-9c5d34f0aeb9', '7b91fc9b-eb1f-4590-bbb6-1e802086a030', '85cc2ec8-38e7-4058-9bed-d79ed2b871e1', '4af95e0c-12ec-457c-a288-a0861fd17bf5');

update intakedastatus 
	set status = 8, updatedby = 'CDM-13253', updatedon = now()
	where intakenumber = 'I202100356405'
	and activeflag = 1;

update caseassignment 
set
activeflag = 0,
updatedby = 'CDM-13253', 
updatedon = now()
where caseassignmentid in ('663367dd-fb4e-40e7-9035-f4132b329e1d', '6776cbaa-c4cf-4fd8-9559-a1337750367f');

update servicecase 
set
activeflag = 0,
updatedby = 'CDM-13253', 
updatedon = now()
where servicecaseid = '275fad80-324e-44fa-b66e-87a0b329996c';

	

