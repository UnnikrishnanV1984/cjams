/*
   Issue Description: CDM-31553
   Category/ Module  : Intake 
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
UPDATE intakesnapshot 
SET 
updatedby = 'CDM-31553', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I231010611031' AND activeflag=1;



UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CDM-31553', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I231010611031' AND activeflag=1;




update intakeservicerequest set activeflag = 0, updatedby = 'CDM-31553', updatedon = now()  
where intakenumber = 'I231010611031' and activeflag = 1;


update cjams.routing set eventcode ='INTR', routingstatustypeid =8
where routingid ='f1a848b0-5421-4849-8e9a-2c63ebbebc3e';