/*
   Issue Description: CDM-35945
   Category/ Module  :Intake
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed and changed status to screenout
*/

select * from intakesnapshot where intakenumber ='I231011673955';

select status,activeflag,updatedby,* from intakedastaging where intakenumber ='I231011673955' and activeflag =1;

UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CDM-35945', updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I231011673955' AND activeflag=1;

select activeflag,updatedby,updatedon,* from intakesnapshot where intakenumber in ('I231011673955');

select * from intakeservicerequest where intakenumber ='I231011673955';

UPDATE intakesnapshot
SET updatedby = 'CDM-35945', updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I231011673955' AND activeflag=1;

select activeflag,routingstatustypeid,* from routing where objectid in ('I231011673955') and activeflag ='1';

select activeflag,routingstatustypeid,* from routing where objectid in ('I231011673955') and activeflag ='0' and routingstatustypeid='8';

select objectid,* from routing where routingid ='5fa4d8be-68ef-4950-afcc-15c5c74a4add';

update routing set activeflag ='0', updatedby ='CDM-35945', updatedon =now() where routingid ='7b3d86ff-1249-41d7-ab81-3370f75b260b';

update routing set eventcode ='INTR', updatedby ='CDM-35945', updatedon =now() where routingid ='5fa4d8be-68ef-4950-afcc-15c5c74a4add';