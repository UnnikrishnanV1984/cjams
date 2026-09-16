-- CDM-23904 - Duplicate entries for approvals
/*
-- Issue Description: 
   Purchase Authorization with duplicate Pending routing record 

-- Case ID: 211030008042
-- Client ID: 1259459 (JODIE LYNN GREEN) - d59e4039-930d-4582-9962-edf36600d139
-- Authorization ID: 1843238 - Transportation assistance (Paid) 
-- Provider ID: 5096779	(Agniman Transportation LLC) - $159.10

-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: Data issue (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete 
-- 1	62	Denied	85af1b5e-fdeb-436a-8a13-afa80015879b
-- 1	62	Denied	745d14cd-818a-47ff-8ab1-dfb5a7eaa23b

select *
	from routing 
where routingid in ('85af1b5e-fdeb-436a-8a13-afa80015879b', '745d14cd-818a-47ff-8ab1-dfb5a7eaa23b')
	and objectid = '1843238'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;
	
delete from routing   
where routingid in ('85af1b5e-fdeb-436a-8a13-afa80015879b', '745d14cd-818a-47ff-8ab1-dfb5a7eaa23b')
	and objectid = '1843238'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;
	
/*
-- To Revert the data if needed
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('745d14cd-818a-47ff-8ab1-dfb5a7eaa23b'::uuid, 'PCAUTH', '518e2289-9311-4416-ac68-a3f241150797', '6ad7ee88-8ef9-498e-9e71-8909c215614b', '068dd6c7-c3c8-4811-aad8-cc812a30609b'::uuid, 'CWCW', 'CWSP', '1843238', 62, 1, '518e2289-9311-4416-ac68-a3f241150797', '2022-07-18 15:18:43.857', '518e2289-9311-4416-ac68-a3f241150797', '2022-07-18 15:18:43.857', true, 'Denied', NULL, 'Incorrect dates entered', '211030008042', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('85af1b5e-fdeb-436a-8a13-afa80015879b'::uuid, 'PCAUTH', '518e2289-9311-4416-ac68-a3f241150797', '6ad7ee88-8ef9-498e-9e71-8909c215614b', '068dd6c7-c3c8-4811-aad8-cc812a30609b'::uuid, 'CWCW', 'CWSP', '1843238', 62, 1, '518e2289-9311-4416-ac68-a3f241150797', '2022-07-18 15:18:44.060', '518e2289-9311-4416-ac68-a3f241150797', '2022-07-18 15:18:44.060', true, 'Denied', NULL, 'Incorrect dates entered', '211030008042', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/	

