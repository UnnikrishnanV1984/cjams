UPDATE intakesnapshot 
SET 
updatedby = 'CDM-13358', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202000486832' AND activeflag=1;

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-13358', updatedon = now() where intakenumber = 'I202000486832';

update intakedastaging 
	
	set status = 'Closed', updatedby = 'CDM-13358', updatedon = now()
	
	where intakenumber = 'I202000486832'
	and activeflag = 1;
	
update personprogramarea set 
activeflag = 0,
updatedby = 'CDM-13358',
updatedon = now()
where personprogramid in ('ac9a253b-29d2-40f9-9456-043adfd768ea','3c4b0980-f4d3-41a9-b45b-c0c20375088b');

update intakedastatus 
	set status = 8, updatedby = 'CDM-13358', updatedon = now()
	where intakenumber = 'I202000486832'
	and activeflag = 1;


update servicecase set activeflag = 0,  updatedby = 'CDM-13358', updatedon = now()
where servicecaseid = '7beeb9d7-05a6-4145-aba7-5ddafb370fdd';