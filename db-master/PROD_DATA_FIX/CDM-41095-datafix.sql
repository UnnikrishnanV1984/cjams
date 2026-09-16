/*
  Issue Description:CDM-41095
Category/ Module:Application
Root cause: User requested to screenout the case
Pull request# for code fix:
Reason why no related code fix:
Status of the code fix if already submitted and expected prod fix date:
   Backup before update/ delete: 
*/

UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CDM-41095', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I241012762097' AND activeflag=1;


update cjams.routing 
set routingstatustypeid = 8,supervisordecision ='screenout',
updatedon = now()
where objectid='I241012762097';

-- No Records Found
select * from intakesnapshot where intakenumber = 'I241012762097';
select * from intakeservicerequest where intakenumber = 'I241012762097';