/*
   Issue Description: CDM-18376
   Category/ Module  : Reverting the supervisor decision for intake descision
   Root cause: user requeseted to revert the intake decision
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE intakesnapshot 
SET 
updatedby = 'CDM-18376', 
updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '""'))))
WHERE intakenumber = 'I211010211198' AND activeflag=1;

update routing set routingstatustypeid = 1,updatedby = 'CDM-18376', updatedon = now() where objectid = 'I211010211198' and activeflag = 1;

-- 2
update intakedastatus set status = null, updatedby = 'CDM-18376' , updatedon = now() where intakenumber = 'I211010211198';

-- true
update cjams.intakedastaging set ispreintake ='false', updatedby ='CDM-18376', updatedon =now()  where intakenumber ='I211010211198' and activeflag = 1;
