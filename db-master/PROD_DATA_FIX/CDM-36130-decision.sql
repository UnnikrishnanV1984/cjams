/*
   Issue Description: CDM-36130
   Category/ Module  :Service case
   Root cause: I see user had commented to added few details in intake case and sent for screenin. Sevice case was created.
*/

select activeflag,* from servicecase where servicecasenumber ='231030247913';

update servicecase
set activeflag ='0', updatedby ='CDM-36130', updatedon = now()
where servicecasenumber ='231030247913' and activeflag ='1';

select activeflag,* from servicecasedisposition where servicecaseid ='eabd10cf-eaf3-41de-8854-a5df33cc77ce';

update servicecasedisposition
set activeflag ='0', updatedby ='CDM-36130', updatedon = now()
where servicecaseid ='eabd10cf-eaf3-41de-8854-a5df33cc77ce' and activeflag ='1';

select activeflag,objectid,* from routing where servicerequestnumber ='231030247913' and objectid ='eabd10cf-eaf3-41de-8854-a5df33cc77ce';

update routing 
set activeflag ='0', updatedby ='CDM-36130', updatedon = now()
where objectid ='eabd10cf-eaf3-41de-8854-a5df33cc77ce' and activeflag ='1';

select * from caseassignment where objectid ='eabd10cf-eaf3-41de-8854-a5df33cc77ce';

select routingstatustypeid,objectid,* from routing where objectid in ('I231011787534');

select activeflag,objectid,* from routing where routingid='bd012421-f872-4fb5-8ac3-5e68d28cd1bf';

update routing 
set routingstatustypeid =7, updatedon =now()
where routingid='bd012421-f872-4fb5-8ac3-5e68d28cd1bf' and activeflag =1;

UPDATE intakesnapshot 
 set updatedby = 'CDM-36130', updatedon = now(),
 jsondata = jsonb_set(jsondata, '{DAType}', 
            jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '""'))))
WHERE intakenumber = 'I231011787534' AND activeflag=1;

UPDATE intakedastaging 
 set updatedby = 'CDM-36130', status ='pending', updatedon = now(),
 jsondata = jsonb_set(jsondata, '{DAType}', 
            jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '""'))))
WHERE intakenumber = 'I231011787534' AND activeflag=1;

select status,* from intakedastatus where intakenumber ='I231011787534';

update intakedastatus
set status =7, updatedon =now()
where intakenumber ='I231011787534' and activeflag =1;

select status,* from intakedastaging where intakenumber in ('I231011787534') and activeflag =1;

update intakedastaging
set status ='pending', ispreintake ='false', updatedby ='CDM-36130', updatedon =now()
where intakenumber ='I231011787534' and activeflag =1;