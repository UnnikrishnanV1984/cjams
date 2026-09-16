/*
   Issue Description: CDM-21922
   Category/ Module  : Prod data fix To revert supervisor decision
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



/*
 * 
 * INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('5900afa3-29d6-48c7-b821-b12ffaba41dd'::uuid, 'XXXX', '96c95c04-2bc7-4d70-a923-262b748b275f', 'd01eb0ea-2486-4422-87ce-8e036fe78425', 'e93e0de6-170b-400c-aa47-cd74e7e9d2dc'::uuid, 'CWIW', 'CWSP', 'I221010263024', 8, 0, '96c95c04-2bc7-4d70-a923-262b748b275f', '2022-04-07 19:57:48.663', 'e6e81f4a-64f8-4e40-aa0f-749d234123bf', '2022-04-08 16:12:45.217', true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('bbd602f8-a245-4449-911b-0fbc1091fef0'::uuid, 'INTR', 'e6e81f4a-64f8-4e40-aa0f-749d234123bf', 'e6e81f4a-64f8-4e40-aa0f-749d234123bf', '636319d9-e3a4-49bf-af0d-711c9bb1bff8'::uuid, 'CWSP', 'CWSP', 'I221010263024', 8, 0, 'e6e81f4a-64f8-4e40-aa0f-749d234123bf', '2022-04-08 16:12:45.217', 'e6e81f4a-64f8-4e40-aa0f-749d234123bf', '2022-04-08 16:12:45.217', false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

 */


-- Removing routing records
DELETE FROM cjams.routing
WHERE routingid='5900afa3-29d6-48c7-b821-b12ffaba41dd'::uuid;
DELETE FROM cjams.routing
WHERE routingid='bbd602f8-a245-4449-911b-0fbc1091fef0'::uuid;



UPDATE intakesnapshot 
	SET 
	updatedby = 'CDM-21922', 
	updatedon = now(), 
	jsondata = jsonb_set(jsondata, '{DAType}', 
				jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
				jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
				jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '""'))))
	WHERE intakenumber = 'I221010263024' AND activeflag=1;


	-- 2
	update intakedastatus set status = 1, updatedby = 'CDM-21922' , updatedon = now() where intakenumber = '=I221010263024';

   update routing set routingstatustypeid = 1,updatedby = 'CDM-21922', updatedon = now() where objectid = 'I221010263024' and activeflag = 0;

	-- true
	update cjams.intakedastaging set status = 'pending', ispreintake =false, updatedby ='CDM-21922', updatedon =now()  where intakenumber ='I221010263024' and activeflag = 1;
	
