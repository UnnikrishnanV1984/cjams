/*
   Issue Description: CDM-24493
   Category/ Module  : case summary
   Root cause: user wants to screenout the decision to open the case
   Pull request# for code fix: 6502, 6507
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   data fix required
*/
UPDATE personprogramarea 
SET activeflag = 0, updatedby = 'CDM-24493', updatedon = now()
WHERE personprogramid in ('965952c2-2ce2-42b7-86fb-30baad039c68', '93e7ee57-d032-44cc-8b00-d901693d190e', '17c2293f-fd3b-4eab-bc3b-27932c08a434');

UPDATE intakesnapshot
SET
    updatedby = 'CDM-24493', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
    jsonb_set(jsondata->'DAType', '{DATypeDetail}',
    jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
    jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I221010272790' AND activeflag=1;


update intakeservicerequest set activeflag =0, updatedby = 'CDM-24493', updatedon = now() 
where intakeserviceid ='ac2e6768-d7ae-4ff5-95fd-b4231377e17c';

update intakedastaging 
set status = 'Closed', updatedby = 'CDM-24493', updatedon = now()
where intakenumber = 'I221010272790'
and activeflag = 1;