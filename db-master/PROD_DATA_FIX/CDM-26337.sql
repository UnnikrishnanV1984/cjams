/*
   Issue Description: CDM-26337
   Category/ Module  : CJAMS - Intake
   Root cause: user wants to screen out intake
   Pull request# for code fix: 
   Reason why no related code fix: only Data fix is needed
*/
UPDATE intakesnapshot 
SET updatedby = 'CDM-26337', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
            jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I221010333611' AND activeflag=1;

Update routing set 
updatedby = 'CDM-26337', updatedon = now(),
activeflag =0, routingstatustypeid = 8
WHERE objectid = 'I221010333611' and activeflag =1;

update intakeDAStatus set status = 8, updatedby = 'CDM-26337', updatedon = now() 
where intakenumber = 'I221010333611' and activeflag =1;

update intakedastaging 
set status = 'Closed', updatedby = 'CDM-26337', updatedon = now()
where intakenumber = 'I221010333611' and activeflag = 1;

update intakeservicerequest 
set activeflag = 0, updatedby = 'CDM-26337', updatedon = now() 
where intakenumber = 'I221010333611';