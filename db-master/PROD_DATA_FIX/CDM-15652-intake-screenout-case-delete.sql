/*
   Issue Description: CDM-15652
   Category/ Module  :  intake screenout and case delete
   Root cause: User error
   Pull request# for code fix: 
   Reason why no related code fix: 
    user requested data fix
*/

UPDATE intakesnapshot 
SET 
updatedby = 'CDM-15652', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber in ('I211010178904') AND activeflag=1;

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-15652', updatedon = now() where intakenumber in ('I211010178904');

update intakedastaging 
	
	set status = 'Closed', updatedby = 'CDM-15652', updatedon = now()
	
	where intakenumber in ('I211010178904')
	and activeflag = 1;
	
update intakedastatus 
	set status = 8, updatedby = 'CDM-12959', updatedon = now()
	where intakenumber in ('I211010178904')
	and activeflag = 1;
