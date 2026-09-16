/*
   Issue Description: CDM-35833
   Category/ Module  :  child welfare - CPS 
   Root cause: Intake needs to be connected to an existing service case
   Pull request# for code fix: 
   Reason why no related code fix: 
   user error - requested a data fix
*/
-- case connect of Intake case  to existing service case


-- Changed the supervisior decision to screen out and submission history to closed, The user created new intake for existing service case
UPDATE intakesnapshot 
SET updatedby = 'CDM-35833', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
            jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I231011648716' AND activeflag=1;

Update routing set 
routingstatustypeid = 8
WHERE objectid = 'I231011648716';

update intakeDAStatus set status = 8, updatedby = 'CDM-35833', updatedon = now() 
where intakenumber = 'I231011648716' and activeflag =1;

update intakedastaging 
set status = 'Closed', updatedby = 'CDM-35833', updatedon = now()
where intakenumber = 'I231011648716' and activeflag = 1;

update intakeservicerequest 
set activeflag = 0, updatedby = 'CDM-35833', updatedon = now() 
where intakenumber = 'I231011648716';