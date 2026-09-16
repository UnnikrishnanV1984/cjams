/*
   Issue Description: CDM-40338
   Category/ Module  : Screenout referral
   Root cause: Data fix request by User
   Pull request# for code fix: 
   Reason why no related code fix:
*/  
 
UPDATE intakesnapshot 
SET 
updatedby = 'CDM-40338', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I241012773725' AND activeflag=1;



UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CDM-40338', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I241012773725' AND activeflag=1;
 

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-40338', updatedon = now()  
where intakenumber = 'I241012773725' and activeflag = 1;
 

update cjams.routing set activeflag  =0, routingstatustypeid  = 8, supervisordecision = 'screenout'
where routingid  ='50dfe4b1-018e-4878-adab-2214ef67058c' and activeflag = 1;