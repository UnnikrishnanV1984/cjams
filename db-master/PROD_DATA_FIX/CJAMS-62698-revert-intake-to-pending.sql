
/*
   Issue Description: CJAMS-62698 intake glitch
   Category/ Module  : Intake 
   Root cause: Due to connection issue the supervisor approval didn't go through for the intake.
               Data fix needed to revert the intake back to review state for the intake number I251013375430
   Fix Provided: Data fix has been done to bring the intake back to review state. 
   Data/Code fix ticket#: CJAMS-62698
   Regression Impacts: N/A
   Is Code fix Required?: No
   Code fix ticket#: N/A
   Reason why no related code fix:This happened due to connection issues and data fix should resolve it. 
*/

update Intakedastaging set status = 'pending',ispreintake ='false', updatedon=now(), updatedby = 'CJAMS-62698' 
where intakenumber ='I251013375430' and activeflag =1;
   
      
update routing set routingstatustypeid = '1', supervisordecision= null, updatedon=now(), updatedby = 'CJAMS-62698' 
where routingid = 'b693b743-b3be-462f-9855-61a6112aa758';
 
   
 UPDATE intakesnapshot 
    SET 
    updatedby = 'CJAMS-62698', 
    updatedon = now(), 
    jsondata = jsonb_set(jsondata, '{DAType}', 
                jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
                jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
                jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '""'))))
    WHERE intakenumber = 'I251013375430' AND activeflag=1;