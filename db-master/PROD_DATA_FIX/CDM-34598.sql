 /* 
    Issue Description: CDM-34598
   Category/ Module  : intake
   Root cause: user wants to update intake I231011262516 to  ScreenOUT and servicecase need to remove
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/

UPDATE intakesnapshot
SET
updatedby = 'CDM-34598', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I231011262516' AND activeflag=1;

UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CDM-34598', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I231011262516' AND activeflag=1;


update routing
set routingstatustypeid = 8
where routingid = 'f5040576-ae51-4d00-81ee-0479f1f1d18e' and objectid = 'I231011262516';


update 	servicecase 
set 	activeflag = 0, 
		updatedby = 'CDM-34598', 
		updatedon = now() 
where 	servicecaseid = '768a5bbf-26e6-498d-93d8-c4a237e2a5e3' and activeflag = 1;


update routing
set activeflag = 0, 
		updatedby = 'CDM-34598', 
		updatedon = now() 
where objectid = '768a5bbf-26e6-498d-93d8-c4a237e2a5e3';



update 	servicecasedisposition 
set 	activeflag = 0, updatedby = 'CDM-34598', updatedon = now() 
where 	servicecaseid = '768a5bbf-26e6-498d-93d8-c4a237e2a5e3' and activeflag = 1;