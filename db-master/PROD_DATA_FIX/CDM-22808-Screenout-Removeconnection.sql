/*
   Issue Description: CDM-22808
   Category/ Module  : Referral change and Case connection removal
   Root cause: user wants to change referral
   Pull request# for code fix: 5597, 5696
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/


UPDATE intakesnapshot 
SET 
updatedby = 'CDM-22808', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
            jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I221010279849' AND activeflag=1;

UPDATE intakeservicerequest 
SET servicecaseid = null,
    servicerequestnumber = null,
    updatedon = now(),
    updatedby = 'CDM-22808'
WHERE intakenumber = 'I221010279849';

update intakedastaging 
set status = 'Closed', updatedby = 'CDM-22808', updatedon = now()
where intakenumber = 'I221010279849'
and activeflag = 1;

update servicecase 
set enddate='2019-09-24', statustypekey='Closed', updatedon=now(), updatedby='CDM-22808'
where servicecaseid ='ef1c9c60-8532-4c7f-80b5-96d113a5dc08';

update servicecasedisposition 
set activeflag = 0, updatedby = 'CDM-22808', updatedon = now() 
where servicecasedispositionid = 'ca459c3c-4e28-4574-b2fa-fdf0cb827956';