/*
 * CDM-33180 - Screening
 * Customer Email ID:courtney.wunderlich@maryland.gov
 * Customer Name:Courtney Wunderlich
 * Focus Area:Assignments
 * Description - I231010843182:I incorrectly Connected this new case to an older Service case when i screend it in. However that was incorrect. 
 * I am trying to override this intake to a screen out. Then i will have the referral entered again however i will not case connect it this time. 
 * It will have it's own case #. This needs to be fixed as soon as possible given it's a SEN case with a 48 hour mandate response time that needs to be put into the system.
 */

select servicecaseid, * from intakeservicerequest where intakenumber = 'I231010843182';
UPDATE cjams.intakeservicerequest
SET servicecaseid=NULL, updatedby='CDM-33180', updatedon=now() 
WHERE intakeserviceid='818cebf8-74dc-466b-bc11-0c220c0864dd' and intakenumber = 'I231010843182';


select activeflag,* from servicecasedisposition where servicecasedispositionid = '275f888c-c519-4a37-a6cf-cdd776940efb';
UPDATE cjams.servicecasedisposition
SET activeflag=0, updatedby='CDM-33180', updatedon=now() 
WHERE servicecasedispositionid='275f888c-c519-4a37-a6cf-cdd776940efb';

select servicecaseid, * from intakeservicerequest where intakenumber = 'I231010843182'; -- d5e7be83-89bd-4ca4-9772-e768e5f0d82a

select servicecaseid, * from intakeservicerequest where intakenumber = 'CW2542644' and activeflag = 1;
UPDATE cjams.intakeservicerequest
SET servicecaseid='d5e7be83-89bd-4ca4-9772-e768e5f0d82a', updatedby='CDM-33180', updatedon=now() 
WHERE intakeserviceid='38269c4f-925f-485d-bf4d-916fabf65783' and intakenumber='CW2542644';

UPDATE intakedastaging
SET 
updatedby = 'CDM-33180', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', 'null'))))
WHERE intakenumber = 'I231010843182' AND activeflag=1;

UPDATE intakesnapshot
SET 
updatedby = 'CDM-33180', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', 'null'))))
WHERE intakenumber = 'I231010843182' AND activeflag=1;

-- select routingstatustypeid, routingid, * from routing where objectid = 'I231010843182';  
-- select sequencenumber, * from routingstatustype where typedescription = 'Review' and routingstatustypekey = 'New';
UPDATE cjams.routing
SET routingstatustypeid=1 
WHERE routingid='c4222800-af7f-44c7-a044-56870829997c'; 

UPDATE cjams.intakedastaging
SET ispreintake=false, status='Pending', updatedby='CDM-33180', updatedon=now() 
WHERE intakenumber='I231010843182' and activeflag=1; 