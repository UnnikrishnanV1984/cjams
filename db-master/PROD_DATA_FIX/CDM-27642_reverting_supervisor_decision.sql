
/*
   Issue Description : CDM-27642
   Category/ Module : Intake
   Root cause: Prod data fix for reverting the supervisor decision 
*/

UPDATE intakesnapshot 
SET 
updatedby = 'CDM-27642', 
updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}', 
            jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '""'))))
WHERE intakenumber = 'I221010336128' AND activeflag=1;

UPDATE intakedastaging 
SET updatedby = 'CDM-27642', 
	updatedon = now(), 
	jsondata = jsonb_set(jsondata, '{DAType}', 
	            jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
	            jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
	            jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '""'))))
WHERE intakenumber = 'I221010336128' AND activeflag=1;

update routing set routingstatustypeid = 1,updatedby = 'CDM-27642', updatedon = now() where objectid = 'I221010336128' and activeflag = 1;

--status = 2
update intakedastatus set status = null, updatedby = 'CDM-27642' , updatedon = now() where intakenumber = 'I221010336128' and activeflag = 1;

-- Delete CPS case
update intakeservicerequest set activeflag = 0, updatedby = 'CDM-27642', updatedon = now() where intakeserviceid = '1b79cac1-8b2b-46c0-8f22-c0e534a7992d';

-- Program assignment
update personprogramarea set activeflag = 0, updatedon = now(), updatedby = 'CDM-27642'
where personprogramid in ('5c005924-a533-403d-8678-d6e2c1ddcab9', 'aa7dce6e-efb0-4e7e-8ee5-fd1bb255a55d', '8db1bafa-6a75-481c-b732-264b95b8c931');


