/*
   Issue Description: CDM-23840 Screened In Error
   Category/ Module  : Intake
   Root cause: In Error, user marked as Screened In. 

   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Data fix: Updating to Screen OUT
*/


UPDATE intakesnapshot 
SET updatedby = 'CDM-23840', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
            jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I221010296641' AND activeflag=1;

Update routing set 
updatedby = 'CDM-23840', updatedon = now(),
activeflag =0, routingstatustypeid = 8
WHERE objectid = 'I221010296641' and activeflag =1;

update intakeDAStatus set status = 8, updatedby = 'CDM-23840', updatedon = now() 
where intakenumber = 'I221010296641' and activeflag =1;

update intakedastaging 
set status = 'Closed', updatedby = 'CDM-23840', updatedon = now()
where intakenumber = 'I221010296641' and activeflag = 1;

update intakeservicerequest 
set activeflag = 0, updatedby = 'CDM-23840', updatedon = now() 
where intakenumber = 'I221010296641';


