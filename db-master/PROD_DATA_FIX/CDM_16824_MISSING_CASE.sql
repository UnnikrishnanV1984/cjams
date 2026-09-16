/*-- Took reference from defect CDM-10587 fix */
	
    
    UPDATE intakesnapshot
	SET
	updatedby = 'CDM-16824', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
	jsonb_set(jsondata->'DAType', '{DATypeDetail}',
	jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
	jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
	WHERE intakenumber = 'I211010172219' AND activeflag=1;

	update intakeservicerequest set activeflag=0,updatedby = 'CDM-16824',updatedon = now() where servicerequestnumber=211020123145;