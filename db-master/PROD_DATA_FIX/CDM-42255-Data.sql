/*
  Issue Description:  CDM-42255
   Category/ Module  : Persons
   Root cause: User request revert back the supervisor decision
   Pull request# for code fix: NA
   Reason why no related code fix: NA
   Status of the code fix if already submitted and expected prod fix date: NA
   Backup before update/ delete: NA
*/

UPDATE intakesnapshot 
SET 
updatedby = 'CDM-42255', 
updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}', 
            jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '""'))))
WHERE intakenumber = 'I241013158953' AND activeflag=1;

update routing set routingstatustypeid = 1,supervisordecision = null, activeflag = 1
where objectid = 'I241013158953';

update intakedastatus set status = null, updatedby = 'CDM-42255' , updatedon = now() where intakenumber = 'I241013158953' and activeflag = 1;

update cjams.intakedastaging set status='pending', ispreintake ='false', updatedby ='CDM-42255', updatedon =now() 
 where intakenumber ='I241013158953' and activeflag = 1;