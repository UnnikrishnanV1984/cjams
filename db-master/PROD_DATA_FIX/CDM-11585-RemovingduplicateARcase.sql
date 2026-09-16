update intakeservicerequest set activeflag = 0, updatedby = 'CDM-11585', updatedon = now() where servicerequestnumber = '2021077093068' and intakeserviceid = '52ff5c23-df1b-41f6-852e-ece9c6c4ca4e';

UPDATE intakesnapshot 
SET 
updatedby = 'CDM-11585', 
updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202100129690' AND activeflag=1;