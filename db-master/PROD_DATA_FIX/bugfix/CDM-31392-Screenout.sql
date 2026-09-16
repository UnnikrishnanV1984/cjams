/*
   Issue Description: CDM-31392
   Category/ Module  :  intake screenout 
   Root cause: User error
   Pull request# for code fix: 
   Reason why no related code fix: 
    user requested data fix
*/

UPDATE intakesnapshot 
SET 
updatedby = 'CDM-31392', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202000069770' AND activeflag=1;



UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CDM-31392', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202000069770' AND activeflag=1;



update intakeservicerequest set activeflag = 0, updatedby = 'CDM-31392', updatedon = now()  
where intakenumber = 'I202000069770' and activeflag = 1;

--There is no routing record so inserting closed record 

INSERT INTO cjams.routing
( eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('INTR', '91031ac2-2be8-4b25-a587-9e1a17e001de', '91031ac2-2be8-4b25-a587-9e1a17e001de', 'ae8cedc3-2d4e-4024-a998-f7d8ca07acb7', 'CWIW', 'CWSP', 'I202000069770', 8, 0, '91031ac2-2be8-4b25-a587-9e1a17e001de', '2020-07-26 18:46:12.519', '91031ac2-2be8-4b25-a587-9e1a17e001de', '2020-07-26 18:46:12.519', true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


