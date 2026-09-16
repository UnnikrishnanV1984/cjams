/*
   Issue Description: CDM-18587
   Category/ Module  :  Screen out case
   Root cause: user asked to screenout case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


UPDATE intakesnapshot 
SET 
updatedby = 'CDM-18587', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I211010214250' AND activeflag=1;

update servicecase set activeflag =0, updatedby = 'CDM-18587', updatedon = now() where servicecasenumber = 211030012409 and activeflag =1;

update intakedastaging 
	
	set status = 'Closed', updatedby = 'CDM-18587', updatedon = now()
	
	where intakenumber = 'I211010214250'
	and activeflag = 1;
