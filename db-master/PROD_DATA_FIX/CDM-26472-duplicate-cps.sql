/*
   Issue Description: CDM-26472
   Category/ Module  : Duplicate CPS 
   Root cause: user wants to remove the duplicate intake and delete service case
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

UPDATE intakesnapshot 
SET updatedby = 'CDM-26472', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
            jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I221010323591' AND activeflag=1;

update intakeservicerequest set activeflag =0, updatedby = 'CDM-26472', updatedon = now() 
where servicerequestnumber = '221020261162' and activeflag =1;

update intakedastaging 
set status = 'Closed', updatedby = 'CDM-26472', updatedon = now()
where intakenumber = 'I221010323591' and activeflag = 1;

update personprogramarea set activeflag = 0, updatedby = 'CDM-26472', updatedon = now()
where objectid in (select intakeserviceid::character varying
    from intakeservicerequest where servicerequestnumber = '221020261162'
        )
and activeflag = 1;