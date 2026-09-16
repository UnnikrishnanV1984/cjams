
/*
  Issue Description:CDM-33370
  Root cause: User request 
  Fix Prrovided: Did data fix to screenout Intake
*/

UPDATE intakesnapshot 
SET 
    updatedby = 'CDM-33370', 
    updatedon = now(), 
    jsondata = replace(jsondata ::text , '"supDisposition": "Scrnin"', '"supDisposition": "ScreenOUT"')::jsonb
WHERE intakenumber = 'I231010890328' AND activeflag=1;



UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CDM-33370', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I231010890328' AND activeflag=1;


update intakeservicerequest set activeflag = 0, servicecaseid =null, updatedby = 'CDM-33370', updatedon = now()  
where intakenumber = 'I231010890328'; 


update cjams.routing set routingstatustypeid =8, activeflag =0,  updatedby = 'CDM-33370', updatedon = now() 
where routingid = '4a6837fa-3e33-4e65-b5c3-cc332843db82';