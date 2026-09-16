/*
 * CDM-37377 - Missing AR
 * Customer Email ID:kathryn.morton@maryland.gov
 * Description - Dashboard:The worker has been working in the AR since January and when she went into CJAMS on 2/20/24, and 
 * noticed the AR has disappeared from her workload. When we do a search, we can only locate the referral and it looks like it was not approved 
 * but it was because the worker was working in the AR. 
 * Intake# I241011933981
 * 
 */


select * from intakedastaging i  where intakenumber in ('I241011933981') and activeflag =1;
UPDATE intakedastaging
SET 
updatedby = 'CDM-37377', 
updatedon = now(), 
jsondata =  jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{DAStatus}', '"Review"'))))
WHERE intakenumber = 'I241011933981' AND activeflag=1;
UPDATE intakedastaging
SET 
updatedby = 'CDM-37377', 
updatedon = now(), 
jsondata =  jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supStatus}', '""'))))
WHERE intakenumber = 'I241011933981' AND activeflag=1;

UPDATE intakedastaging
SET 
updatedby = 'CDM-37377', updatedon = now(), jsondata = jsonb_set(jsondata, '{disposition}', 
			jsonb_set(jsondata->'disposition', '{0}', 
			jsonb_set(jsondata->'disposition'->0, '{DAStatus}', '"Review"')))
WHERE intakenumber = 'I241011933981' AND activeflag=1;
UPDATE intakedastaging
SET 
updatedby = 'CDM-37377', updatedon = now(), jsondata = jsonb_set(jsondata, '{disposition}', 
			jsonb_set(jsondata->'disposition', '{0}', 
			jsonb_set(jsondata->'disposition'->0, '{supStatus}', '""')))
WHERE intakenumber = 'I241011933981' AND activeflag=1;

UPDATE intakedastaging
SET 
updatedby = 'CDM-37377', 
updatedon = now(), 
	jsondata = jsonb_set(jsondata, '{reviewstatus}',
			   jsonb_set(jsondata->'reviewstatus','{status}', '"supreview"'))
where intakenumber = 'I241011933981' 
	and activeflag = 1;
UPDATE intakedastaging
SET 
updatedby = 'CDM-37377', 
updatedon = now(), 
	jsondata = jsonb_set(jsondata, '{reviewstatus}',
			   jsonb_set(jsondata->'reviewstatus','{appevent}', '"INTR"'))
where intakenumber = 'I241011933981' 
	and activeflag = 1;
UPDATE intakedastaging
SET 
updatedby = 'CDM-37377', 
updatedon = now(), 
	jsondata = jsonb_set(jsondata, '{reviewstatus}',
			   jsonb_set(jsondata->'reviewstatus','{ismanualrouting}', 'true'))
where intakenumber = 'I241011933981' 
	and activeflag = 1;
UPDATE intakedastaging
SET 
updatedby = 'CDM-37377', 
updatedon = now(), 
	jsondata = jsonb_set(jsondata, '{reviewstatus}',
			   jsonb_set(jsondata->'reviewstatus','{assignsecurityuserid}', '"5611119d-16d8-4a4e-b045-5ab9734e01ba"'))
where intakenumber = 'I241011933981' 
	and activeflag = 1;

select * from routing where objectid in ('I241011933981') order by insertedon desc;   
UPDATE cjams.routing
SET eventcode='INTR', routingstatustypeid=1, activeflag=1, 
updatedby = 'CDM-37377', 
updatedon = now() 
WHERE routingid='7ed0b14f-9349-49da-9ee0-c4928899d282'::uuid;
