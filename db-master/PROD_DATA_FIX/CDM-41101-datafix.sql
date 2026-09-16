/*
  Issue Description:  CDM-41101
   Category/ Module  :  SDM 
   Root cause: User request to datafix . jsondata is different in intakesnapshot and intakedastaging
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

UPDATE intakedastaging SET jsondata = (SELECT jsondata FROM intakesnapshot WHERE intakesnapshot.intakenumber='I241013040562' and intakesnapshot.activeflag=1)
WHERE intakedastaging.intakenumber='I241013040562' and intakedastaging.activeflag=1;


UPDATE intakesnapshot
SET 
    jsondata = jsonb_set(
        jsondata, 
        '{sdm}', 
        jsonb_set(
            jsondata->'sdm', 
            '{childunderoneyear}', 
            '""' 
        )
    ),
    updatedby = 'CDM-40536',
    updatedon = now()            
WHERE intakenumber = 'I241013040562' 
  AND activeflag = 1;
  
 
 UPDATE intakedastaging
SET 
    jsondata = jsonb_set(
        jsondata, 
        '{sdm}', 
        jsonb_set(
            jsondata->'sdm', 
            '{childunderoneyear}', 
            '""' 
        )
    ),
    updatedby = 'CDM-40536',
    updatedon = now()            
WHERE intakenumber = 'I241013040562' 
  AND activeflag = 1;
  
  update routing set routingstatustypeid = 2, updatedby = '47dc653d-9089-4b47-b40e-0168ef6c2321' , updatedon = now() 
where objectid =  'I241013040562';
