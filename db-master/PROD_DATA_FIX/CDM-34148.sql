/*
 * CDM-34148 - Case was inappropriately screened in
 * Customer Email ID:ruby.esonu@maryland.gov
 * Customer Name:Ruby Esonu
 * Focus Area:Decision
 * Description - I231011104997:Case was inappropriately screened in. The referral needs to be screened out and the service case needs to be closed. 
 * Covering after hours cases and screened in referral by mistake. 
 */

-- select * from userprofile where email  = 'ruby.esonu@maryland.gov';
-- select * from createservicecase('637438a1-080d-4693-9a03-e2f7d51ee246', null, 1,'e8379a8c-fc16-4073-8cb7-90c54d395eb4', 'intake');

select 	status, * 
from 	intakedastaging
where 	intakenumber = 'I231011104997' and activeflag = 1;

update 	intakedastaging 
SET 	updatedby = 'CDM-34148', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
        jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
        jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
        jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE 	intakenumber = 'I231011104997' and activeflag = 1;

select 	jsondata, activeflag, *
from 	intakesnapshot
WHERE 	intakenumber = 'I231011104997';

UPDATE 	intakesnapshot 
SET 	updatedby = 'CDM-34148', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
        jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
        jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
        jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE 	intakenumber = 'I231011104997';

update intakeservicerequest set activeflag = 0, servicecaseid =null, updatedby = 'CDM-34148', updatedon = now()  
where intakenumber = 'I231011104997'; 

select routingid , activeflag ,* from routing where objectid = 'I231011104997' and activeflag =1;
update cjams.routing set routingstatustypeid =8, activeflag =0,  updatedby = 'CDM-34148', updatedon = now() 
where routingid = 'e355c61c-d18e-4a4b-af72-74e0f6ea3f60';


