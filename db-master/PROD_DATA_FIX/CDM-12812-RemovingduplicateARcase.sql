update intakeservicerequest set activeflag = 0, updatedby = 'CDM-12812', updatedon = now() where servicerequestnumber = '20200153019833' and intakenumber = 'I202000562691';

UPDATE intakesnapshot 
SET 
updatedby = 'CDM-12812', 
updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202000562691' AND activeflag=1;

update intakedastaging set status = 'Closed', updatedby = 'CDM-12812', updatedon = now()
where intakenumber = 'I202000562691' and activeflag = 1;

update intakedastatus 
set status = 8, updatedby = 'CDM-12812', updatedon = now()
where intakenumber = 'I202000562691'
and activeflag = 1;
