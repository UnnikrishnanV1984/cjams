---- CDM-9541

UPDATE intakesnapshot 
SET 
updatedby = 'CDM-9541', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202000587455' AND activeflag=1;

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-9541', updatedon = now() where intakeserviceid = 'b77d4003-a8f7-40d2-a5dd-9a358a18202d';

update intakedastaging 
	
	set status = 'Closed', updatedby = 'CDM-9541', updatedon = now()
	
	where intakenumber = 'I202000587455'
	and activeflag = 1;

---- CDM-9540

UPDATE intakesnapshot 
SET 
updatedby = 'CDM-9540', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202000575058' AND activeflag=1;

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-9540', updatedon = now() where intakeserviceid = 'bee1cc64-acdf-4d7c-bf27-d53f59401d45';

update intakedastaging 
	
	set status = 'Closed', updatedby = 'CDM-9540', updatedon = now()
	
	where intakenumber = 'I202000575058'
	and activeflag = 1;

    ---- CDM-9539

    UPDATE intakesnapshot 
SET 
updatedby = 'CDM-9539', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202000174234' AND activeflag=1;

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-9539', updatedon = now() where intakeserviceid = '1cdcd933-e3a1-4764-b9d3-1254b49a319a';

update intakedastaging 
	
	set status = 'Closed', updatedby = 'CDM-9539', updatedon = now()
	
	where intakenumber = 'I202000174234'
	and activeflag = 1;

    ----- CDM-9450

    UPDATE intakesnapshot 
SET 
updatedby = 'CDM-9450', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202000201863' AND activeflag=1;

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-9450', updatedon = now() where intakeserviceid = '40c7ddcf-3398-47a6-a577-6167a0cf103e';

update intakedastaging 
	
	set status = 'Closed', updatedby = 'CDM-9450', updatedon = now()
	
	where intakenumber = 'I202000201863'
	and activeflag = 1;


------------------------------------------------------

UPDATE intakesnapshot 
SET 
updatedby = 'CDM-9450', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202000101836' AND activeflag=1;

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-9450', updatedon = now() where intakeserviceid = '85b0fd1f-72e2-484a-81f7-9b3b7bd9aab0';

update intakedastaging 
	
	set status = 'Closed', updatedby = 'CDM-9450', updatedon = now()
	
	where intakenumber = 'I202000101836'
	and activeflag = 1;

----------------------------------------------------------

UPDATE intakesnapshot 
SET 
updatedby = 'CDM-9450', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202000202089' AND activeflag=1;

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-9450', updatedon = now() where intakeserviceid = '4cbf25b2-cafa-4713-aba9-e5e552cf72f0';

update intakedastaging 
	
	set status = 'Closed', updatedby = 'CDM-9450', updatedon = now()
	
	where intakenumber = 'I202000202089'
	and activeflag = 1;
