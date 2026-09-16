/*
   Issue Description: CDM-40607
   Category/ Module  : Screenout referral
   Root cause: user wants to screenout
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



UPDATE intakesnapshot
SET
updatedby = 'CDM-40607', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I241012837841' AND activeflag=1;

UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CDM-40607', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I241012837841' AND activeflag=1;



update 
  routing
set
  activeflag = 0,  
  updatedby = 'CDM-40607',
  updatedon = now() 
where objectid = 'I241012837841' and activeflag = 1;


INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'INTR', '8c27171c-3dc5-4b93-8d18-52b63c489075', '8c27171c-3dc5-4b93-8d18-52b63c489075', '761524bf-710d-4f07-96b9-eb4e96ff724b', 'CWSP', 'CWSP', 'I241012837841', 8, 0, 'CDM-40607', now(), '8c27171c-3dc5-4b93-8d18-52b63c489075', now(), false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ScreenOUT', 'screenout', now());


update intakesnapshot
set 
	jsondata = jsonb_set(jsondata, '{DAType}', 
	jsonb_set(jsondata->'DAType', '{DATypeDetail}',
	jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
	jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{comments}', '"This referral was not able to be approved due to a glitch. Ticket number S2024021106061"')))),
	updatedby = 'CDM-40607',
	updatedon = now()
	where intakenumber = 'I241012837841'
	and activeflag = 1;
	

update intakedastaging
set 
	jsondata = jsonb_set(jsondata, '{DAType}', 
	jsonb_set(jsondata->'DAType', '{DATypeDetail}',
	jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
	jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{comments}', '"This referral was not able to be approved due to a glitch. Ticket number S2024021106061"')))),
	updatedby = 'CDM-40607',
	updatedon = now()
	where intakenumber = 'I241012837841'
	and activeflag = 1;

