/*
  Issue Description: CDM-25252
   Category/ Module  : Intake screen out and delete the case
   Root cause: user wants to delete case and decision is screenout
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: Need to do data fix
*/
UPDATE intakesnapshot 
SET updatedby = 'CDM-25252', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
            jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I221010313128' AND activeflag=1;


update intakeservicerequest set activeflag =0, updatedby = 'CDM-25252', updatedon = now() 
where servicerequestnumber = '221020251588' and activeflag =1;

update intakedastaging 
set status = 'Closed', updatedby = 'CDM-25252', updatedon = now()
where intakenumber = 'I221010313128' and activeflag = 1;

update cjams.caseassignment set activeflag =0, updatedby ='CDM-25252', updatedon = now() 
where caseassignmentid ='b7fcf8ee-0b54-44ff-861f-d9004bed7b88';


update cjams.routing set activeflag =0, updatedby = 'CDM-25252', updatedon = now() 
where routingid in ('60b9681c-eb61-4a01-bafa-39ae182a7e64','db556080-b339-461a-94d2-2c39bc79f7c1');