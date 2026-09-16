
/*
  Issue Description:  CDM-43568
   Category/ Module  :  Case Assignment
   Root cause: User couldn't complete case assignment.
   Pull request# for code fix:
   Reason why no related code fix: User error.
*/

update Intakedastaging set status = 'pending',ispreintake ='false', updatedon=now(), updatedby = 'CDM-43568' 
where intakenumber ='I251013200912' and activeflag =1;
   
      
update routing set routingstatustypeid = '1', supervisordecision= null, updatedon=now(), updatedby = 'CDM-43568' 
where routingid = 'c6a45fe6-2424-4078-a1f7-a63fa635719a';
 
   
 UPDATE intakesnapshot 
    SET 
    updatedby = 'CDM-43568', 
    updatedon = now(), 
    jsondata = jsonb_set(jsondata, '{DAType}', 
                jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
                jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
                jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '""'))))
    WHERE intakenumber = 'I251013200912' AND activeflag=1;   