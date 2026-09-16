/*
-- CDM-22807 - Referral screened in in error.
*/

UPDATE intakesnapshot 
SET 
updatedby = 'CDM-22807', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
            jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I221010279833' AND activeflag=1;

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-22807', updatedon = now() where intakenumber = 'I221010279833';

update servicecase 
set activeflag =0, updatedon =now(), updatedby ='CDM-22807'
where servicecaseid ='1131a30d-b112-4129-9c0d-db98063de6b0';

update intakedastaging 
set status = 'Closed', updatedby = 'CDM-22807', updatedon = now()
where intakenumber = 'I221010279833' and activeflag = 1;