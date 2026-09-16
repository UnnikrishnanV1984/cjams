/*
 * CDM-36893 - Supervisor override
 * Customer Email ID:lamon.anderson@maryland.gov
 * Supervisor override button was missing in intake
 * 
 * 
 */


update intakedastaging
				set jsondata =  (select jsonb (jsondata) - 'disposition' || jsonb(json_build_object ('dispositioncode',null)) from intakedastaging where intakenumber = 'I241012177111' and activeflag = 1 limit 1),
				status = 'pending',
				updatedon = now(), ispreintake = false,
				updatedby = 'CDM-38693'
				where intakenumber = 'I241012177111' and activeflag = 1;




UPDATE intakedastaging
SET 
updatedby = 'CDM-38693', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '""'))))
where intakenumber ='I241012177111' and activeflag =1;

UPDATE intakedastaging
SET 
updatedby = 'CDM-38693', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{DAStatus}', '""'))))
where intakenumber ='I241012177111' and activeflag =1;

UPDATE intakedastaging
SET 
updatedby = 'CDM-38693', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supStatus}', '""'))))
where intakenumber ='I241012177111' and activeflag =1;

UPDATE intakedastaging
SET 
updatedby = 'CDM-38693', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{DADisposition}', '""'))))
where intakenumber ='I241012177111' and activeflag =1;


UPDATE intakesnapshot
SET 
updatedby ='CDM-38693', 
updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{DAStatus}', '""'))))
where intakenumber ='I241012177111' and activeflag =1;

UPDATE intakesnapshot
SET 
updatedby = 'CDM-38693', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supStatus}', '""'))))
where intakenumber ='I241012177111' and activeflag =1;

UPDATE intakesnapshot
SET 
updatedby = 'CDM-38693', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '""'))))
where intakenumber ='I241012177111' and activeflag =1;

INSERT INTO cjams.administrativeoverrides
(administrativeoverrideid, approvalid, entitytypekey, entityid, referralsnapshotid, overridereasontypekey, overridetypekey, overridedate, overridetimestamp, overridestaffid, "comments", insertedon, insertedby, updatedon, updatedby, activeflag, overridekeyid, intakeserviceid, old_id, etl_userid, etl_load_date, intakeapproveddate, contactmadewithhhmember)
VALUES(gen_random_uuid(), '00000000-0000-0000-0000-000000000000'::uuid, '2530', 'I241012177111', '90516fd8-cc38-4970-8445-ea89058f7fe1', 'RISO', '2530', now(), now(), '47dc653d-9089-4b47-b40e-0168ef6c2321', NULL, now(), '47dc653d-9089-4b47-b40e-0168ef6c2321', now(), '47dc653d-9089-4b47-b40e-0168ef6c2321', 1, 1, '00000000-0000-0000-0000-000000000000'::uuid, NULL, NULL, NULL, '2024-04-29 10:45:12.196', true);


update routing set activeflag  =0 ,updatedon =now() where routingid ='ef179459-64a8-4888-bca5-8b471fbcffe5';

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'INTR', '47dc653d-9089-4b47-b40e-0168ef6c2321','77c1d20d-c76d-4106-ab99-e751bafff384','7cc38f64-153a-46e5-9230-bff302e8e606', 'CWSP', 'CWIW', 'I241012177111', 861, 1, '47dc653d-9089-4b47-b40e-0168ef6c2321', now(), '47dc653d-9089-4b47-b40e-0168ef6c2321', now(), false, 'Return to worker', NULL, 'Return to Worker', ' ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ScreenOUT', 'Return to Worker', NULL);

update intakeservicerequest  set activeflag =0 ,updatedby = 'CDM-38693', updatedon = now() WHERE intakenumber = 'I241012177111' AND activeflag=1;
