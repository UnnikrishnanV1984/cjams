/*
   Issue Description: CDM-40474
   Category/ Module  : Screenout referral
   Root cause: user wants to screenout,, as useris unable to send it for approval
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



UPDATE intakesnapshot
SET
updatedby = 'CDM-40474', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I241012809350' AND activeflag=1;

UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CDM-40474', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I241012809350' AND activeflag=1;



UPDATE personprogramarea
SET activeflag = 0,
updatedon = now(),
updatedby = 'CDM-40474'
WHERE objectid = 'd270740e-8dea-43ea-b861-01e6235a5dc5' AND activeflag =1;

update 
   caseassignment
set
  activeflag = 0,  
  updatedby = 'CDM-40474',
  updatedon = now() 
where objectid = 'd270740e-8dea-43ea-b861-01e6235a5dc5';

update 
  routing
set
  activeflag = 0,  
  updatedby = 'CDM-40474',
  updatedon = now() 
where objectid = 'd270740e-8dea-43ea-b861-01e6235a5dc5' and activeflag = 1;

update intakedastaging
set 
	jsondata = jsonb_set(jsondata, '{DAType}', 
	jsonb_set(jsondata->'DAType', '{DATypeDetail}',
	jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
	jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{comments}', '"CJAMS error will not allow the supervisor to screen out."')))),
	updatedby = 'CDM-40474',
	updatedon = now()
	where intakenumber = 'I241012809350'
	and activeflag = 1;


update intakesnapshot
set 
	jsondata = jsonb_set(jsondata, '{DAType}', 
	jsonb_set(jsondata->'DAType', '{DATypeDetail}',
	jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
	jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{comments}', '"CJAMS error will not allow the supervisor to screen out."')))),
	updatedby = 'CDM-40474',
	updatedon = now()
	where intakenumber = 'I241012809350'
	and activeflag = 1;

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'INTR', 'd86bb458-2309-4182-b155-ae22d36cf9d6', 'd86bb458-2309-4182-b155-ae22d36cf9d6', '4f6ea4e7-5eca-48cb-be75-ab8bcb0cc9e5', 'CWSP', 'CWSP', 'I241012809350', 8, 0, 'CDM-40474', now(), 'd86bb458-2309-4182-b155-ae22d36cf9d6', now(), false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ScreenOUT', 'screenout', now());

