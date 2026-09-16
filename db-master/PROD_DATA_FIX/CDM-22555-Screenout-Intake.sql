/*
   Issue Description: CDM-22555
   Category/ Module  : Intake screen out and delete the case
   Root cause: user wants to delete case and decision is screenout 
   Pull request# for code fix: 5491
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
UPDATE intakesnapshot 
SET updatedby = 'CDM-22555', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
            jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I221010271247' AND activeflag=1;

update intakedastaging 
set status = 'Closed', updatedby = 'CDM-22555', updatedon = now()
where intakenumber = 'I221010271247' and activeflag = 1;

update intakeservicerequest set activeflag =0, updatedby = 'CDM-22622', updatedon = now() 
where servicerequestnumber = '221020212309' and activeflag =1;

update personprogramarea set activeflag = 0, updatedby = 'CDM-22555', updatedon = now()
where objectid in (select intakeserviceid::character varying
    from intakeservicerequest where servicerequestnumber = 221020212309
        )
and activeflag = 1;