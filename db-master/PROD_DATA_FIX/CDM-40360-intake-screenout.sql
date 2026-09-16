/*
   Issue Description: CDM-40360
   Category/ Module  : Screenout referral
   Root cause: user wants to screenout
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



UPDATE intakesnapshot
SET
updatedby = 'CDM-40360', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I241012785034' AND activeflag=1;

UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CDM-40360', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I241012785034' AND activeflag=1;


UPDATE intakeservicerequest  
SET   
    actiontype = null, intakeservicerequestclassid = '00000000-0000-0000-0000-000000000000', activeflag = 0, 
    updatedby = 'CDM-32973', updatedon = now() 
WHERE 
    
intakeserviceid = 'f837816f-df06-4aef-96ae-d1ec878404bf' 
AND activeflag = 1;

UPDATE personprogramarea
SET activeflag = 0,
updatedon = now(),
updatedby = 'CDM-40360'
WHERE objectid = 'f837816f-df06-4aef-96ae-d1ec878404bf' AND activeflag =1;

update 
   caseassignment
set
  activeflag = 0,  
  updatedby = 'CDM-40360',
  updatedon = now() 
where objectid = 'f837816f-df06-4aef-96ae-d1ec878404bf';

update 
  routing
set
  activeflag = 0,  
  updatedby = 'CDM-40360',
  updatedon = now() 
where objectid = 'I241012785034' and activeflag = 1;

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'INTR', '47dc653d-9089-4b47-b40e-0168ef6c2321', '47dc653d-9089-4b47-b40e-0168ef6c2321', '251662f5-88ee-4393-b4cc-d7c9f0b6d9a8', 'CWSP', 'CWSP', 'I241012785034', 8, 0, '47dc653d-9089-4b47-b40e-0168ef6c2321', now(), '47dc653d-9089-4b47-b40e-0168ef6c2321', now(), false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ScreenOUT', 'screenout', now());

