UPDATE cjams.intakesnapshot 
SET 
updatedby = 'CDM-10305', 
updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202000575044' AND activeflag=1;


update cjams.intakeservicerequest set activeflag = 0, updatedby = 'CDM-10305', updatedon = now() where intakeserviceid = '24a587a6-8a0f-4889-a516-01150dd6920b' and servicerequestnumber = '20200234030357' and activeflag = 1;

update cjams.intakedastaging set activeflag = 1, updatedby = 'CDM-10305', updatedon = now()
where intakenumber = 'I202000575044' and  id = '353519' and activeflag = 0;