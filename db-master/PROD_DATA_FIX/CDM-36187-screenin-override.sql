/*
   Issue Description: CDM-36187
   Category/ Module  :Intake/service
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed and changed status to screenout
*/


select activeflag,intakesnapshotid,* from intakesnapshot where intakenumber ='I231011837294';

select activeflag,updatedby,updatedon,* from intakesnapshot where intakenumber in ('I231011837294');

UPDATE intakesnapshot
SET updatedby = 'CDM-36187', updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I231011837294' AND activeflag=1;

select status,activeflag,updatedby,* from intakedastaging where intakenumber ='I231011837294' and activeflag =1;

UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CDM-36187', updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I231011837294' AND activeflag =1;

select * from intakeservicerequest where intakenumber ='I231011837294';

select activeflag,routingstatustypeid,* from routing where objectid in ('I231011837294') and activeflag =1;

select routingstatustypeid,objectid,* from routing where routingid ='2c562db3-4998-4004-9465-092c0939d259';

update routing set activeflag =0, routingstatustypeid =8, updatedby ='19043820-05ba-4851-8ee5-3e6a1750d2b2', updatedon =now() where routingid ='2c562db3-4998-4004-9465-092c0939d259';

select activeflag,servicecaseid,* from servicecase where servicecasenumber ='231030250158';

update servicecase
set activeflag =0, updatedby ='CDM-36187', updatedon =now()
where servicecasenumber ='231030250158' and activeflag =1;

select activeflag,* from servicecasedisposition where servicecaseid ='3d60aefa-886e-4a3d-aa53-5104491cc73e';

update servicecasedisposition
set activeflag =0, updatedby ='CDM-36187', updatedon =now()
where servicecaseid ='3d60aefa-886e-4a3d-aa53-5104491cc73e' and activeflag =1;

select * from routing where objectid ='3d60aefa-886e-4a3d-aa53-5104491cc73e' and activeflag =1;

update routing
set activeflag =0, updatedby ='CDM-36187', updatedon =now()
where objectid ='3d60aefa-886e-4a3d-aa53-5104491cc73e' and activeflag =1;

select activeflag,* from caseassignment where objectid ='3d60aefa-886e-4a3d-aa53-5104491cc73e';

update caseassignment
set activeflag =0, updatedby ='CDM-36187', updatedon =now()
where objectid ='3d60aefa-886e-4a3d-aa53-5104491cc73e' and activeflag =1;