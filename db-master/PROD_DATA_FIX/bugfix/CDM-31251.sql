/*
   Issue Description: CDM-31251
   Category/ Module  : Intake screen out 
   Root cause: user wants to  decision is screenout 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

UPDATE intakedastaging 
SET 
updatedby = 'CDM-31251', 
updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I231010599199' AND activeflag=1;



update intakeservicerequest 
set activeflag = 0, updatedby = 'CDM-31251', updatedon = now() 
where intakenumber = 'I231010599199';