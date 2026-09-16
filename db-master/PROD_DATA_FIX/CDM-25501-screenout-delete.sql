/*
   Issue Description: CDM-25501
   Category/ Module  : Intake screen out and delete the case
   Root cause: user wants to delete case and decision is screenout 
   Pull request# for code fix: 6501
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
UPDATE intakesnapshot 
SET updatedby = 'CDM-25501', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
            jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I221010320487' AND activeflag=1;

update intakeservicerequest set activeflag =0, updatedby = 'CDM-25501', updatedon = now() 
where servicerequestnumber = '221020258049' and activeflag =1;

update personprogramarea set activeflag = 0, updatedby = 'CDM-25501', updatedon = now()
where objectid in (select intakeserviceid::character varying
    from intakeservicerequest where servicerequestnumber = 221020258049
        )
and activeflag = 1;

update servicecase set activeflag =0, updatedby = 'CDM-25501', updatedon = now() 
where servicecaseid = '4d05695a-9432-4cd1-b44b-9524abdcb5e8';

update caseassignment set activeflag = 0, updatedby = 'CDM-25501', updatedon = now() 
where objectid = '4d05695a-9432-4cd1-b44b-9524abdcb5e8' and activeflag = 1 ;

update servicecasedisposition set activeflag = 0, updatedby = 'CDM-25501', updatedon = now() 
where servicecaseid = '4d05695a-9432-4cd1-b44b-9524abdcb5e8'