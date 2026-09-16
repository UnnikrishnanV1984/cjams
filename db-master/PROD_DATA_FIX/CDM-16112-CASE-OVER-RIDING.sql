/*
   Issue Description: CDM-16112
   Category/ Module  : Approval screen
   Root cause: user asked to remove
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE intakesnapshot 
SET updatedby = 'CDM-16112', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I211010180686' AND activeflag=1;

update intakeservicerequest 
set activeflag = 0, updatedby = 'CDM-16112', updatedon = now() 
where intakenumber = 'I211010180686';

update intakedastaging 
set status = 'Closed', updatedby = 'CDM-16112', updatedon = now()
where intakenumber = 'I211010180686' and activeflag = 1;
	
update intakedastatus 
set status = 8, updatedby = 'CDM-16112', updatedon = now()
where intakenumber = 'I211010180686' and activeflag = 1;