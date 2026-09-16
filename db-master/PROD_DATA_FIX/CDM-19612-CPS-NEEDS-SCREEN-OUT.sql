/*
   Issue Description: CDM-19612
   Category/ Module  : Approval screen
   Root cause: user asked to remove
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE intakesnapshot 
SET updatedby = 'CDM-19612', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202000566014' AND activeflag=1;

update intakeservicerequest 
set activeflag = 0, updatedby = 'CDM-19612', updatedon = now() 
where intakenumber = 'I202000566014';

update intakedastaging 
set status = 'Closed', updatedby = 'CDM-19612', updatedon = now()
where intakenumber = 'I202000566014' and activeflag = 1;
	
update intakedastatus 
set status = 8, updatedby = 'CDM-19612', updatedon = now()
where intakenumber = 'I202000566014' and activeflag = 1;
