/*
  Issue Description: CDM-26389
   Category/ Module  : Referral change and delete case
   Root cause: user wants to change referral
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/
---- checked person program area, assignment, dispostion as well 

UPDATE intakesnapshot 
SET updatedby = 'CDM-26389', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
            jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I221010334174' AND activeflag=1;


update intakedastaging 
set status = 'Closed', updatedby = 'CDM-26389', updatedon = now()
where intakenumber = 'I221010334174' and activeflag = 1;


update cjams.routing set activeflag =0, updatedby = 'CDM-26389', updatedon = now() 
where routingid in ('adf54c0d-a8db-40d8-a21c-43502484f440');


update servicecase  set activeflag =0, updatedby = 'CDM-26389', updatedon = now() 
where servicecasenumber = '221030019491' and activeflag =1;



  update servicecasedisposition
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-26389'
where servicecaseid = 'c16451df-80f5-42aa-b93d-ce28e6b2c01f'
	and activeflag = 1 ;