update intakeservicerequest set activeflag = 0, updatedby = 'CDM-11804', updatedon = now() where servicerequestnumber = '2021077093011' and intakeserviceid = '72bc707e-6ebb-449b-b6c2-f8cd006b1560';

UPDATE intakesnapshot 
SET 
updatedby = 'CDM-11804', 
updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202100438865' AND activeflag=1;