
/*
  Issue Description: CDM-21065
   Category/ Module  : Referral change and delete case
   Root cause: user wants to change referral
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/
-- updated wrong case number in previous pr

UPDATE intakesnapshot 
SET updatedby = 'CDM-21065', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
            jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I221010247297' AND activeflag=1;


update intakeservicerequest set activeflag =0, updatedby = 'CDM-21065', updatedon = now() 
where servicerequestnumber = '221020190559' and activeflag =1;

update intakedastaging 
set status = 'Closed', updatedby = 'CDM-21065', updatedon = now()
where intakenumber = 'I221010247297' and activeflag = 1;


update cjams.caseassignment set activeflag =0, updatedby ='CDM-21065', updatedon = now() 

where caseassignmentid ='19a208ae-90ef-46ed-bc51-5df52fc98075';



update cjams.routing set activeflag =0, updatedby = 'CDM-21065', updatedon = now() 

where routingid in ('fe707115-988b-4593-a427-9151bfd93bfb','8fc48b16-850d-4618-91f1-a0108e15a2ea');