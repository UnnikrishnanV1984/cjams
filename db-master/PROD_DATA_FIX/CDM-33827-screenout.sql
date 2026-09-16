/*
   Issue Description:CDM-33827
   Category/ Module  :Intake
   Root cause: user request.
  Fix Provided: Did data fix to screenout intake and changed routing 
*/  
 
 UPDATE intakesnapshot 
SET 
updatedby = 'CDM-33827', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I231011004718' AND activeflag=1;



UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CDM-33827', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I231011004718' AND activeflag=1;
 

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-33827', updatedon = now()  
where intakenumber = 'I231011004718' and activeflag = 1;
 

update cjams.routing set activeflag  =0, routingstatustypeid  =8
where routingid  ='95cf2840-14db-414c-aeb0-8c213d104288';