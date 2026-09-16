-- CDM-19229 - Remove Void
/*
-- Issue Description: 
   User request to update placement exit date & revert void the below placement

-- Case ID: 3100718 (21st Bday: 2021-09-20)
-- Client ID: 1755411 (JANISHA JOHNSON) - 166284e8-da93-4268-83ec-929d8f434557
-- Placement ID: 1558909 - 2020-08-05 To 2021-10-13 - 69d1efbb-8287-4b24-91ab-3b7c430803a4
-- Private Organization: 5000882 (Pressley Ridge, Inc.)
-- CPA Office: 5089879 (Independence Plus/Second Gen Towson)
-- Program: 15364 (Second Generations TMP-IL) - 2007-04-16 To 2022-06-30

-- Category/ Module: Placements  (Case Management) 
-- Root cause: User error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to change the placement Exit date as 2021-09-20 (Voided Placement)
-- Placement Entry date changes
select alternateid, startdatetime, starttime, enddatetime, endtime,
	exitreasontypekey, exittypekey, updatedby , updatedon, 
	isvoided, voidapprovaldate, voidapprovalstatustypekey, voiddate, voidreasontypekey 
from placement 
where placementid = '69d1efbb-8287-4b24-91ab-3b7c430803a4'
	and activeflag  = 1 ;

update placement  
set enddatetime = '2021-09-20 00:00:00', 
	endtime = '12:00',
	exitreasontypekey = 'PLCCE', 
	exittypekey = 'PLCC', 
	isvoided = 0, 
	voidapprovaldate = now(), 
	voidapprovalstatustypekey = NULL, 
	voiddate = NULL, 
	voidreasontypekey = NULL, 
	updatedon = now(), 
	updatedby = 'CDM-19229'
where placementid = '69d1efbb-8287-4b24-91ab-3b7c430803a4'
	and activeflag = 1 ;

-- Placement Revision
select entrydate, entrytime, exitdate, exittime, updatedby, updatedon  
	from placementrevision  
where placementid = '69d1efbb-8287-4b24-91ab-3b7c430803a4'
	and placementrevisionid
		in (	'f12af917-1a51-472f-b540-c41ecb599c9f', -- Void Approved
				'1a293345-9567-4d9f-8bd1-d4f4fe53a076',
				'234fc9e6-9bdd-4299-90e3-1ffc58f60f31', -- Rejected
				'1da5028f-419e-4265-bdb6-60cc95281a37'
			) ;

delete from placementrevision
where placementid = '69d1efbb-8287-4b24-91ab-3b7c430803a4'
	and placementrevisionid
		in (	'f12af917-1a51-472f-b540-c41ecb599c9f', -- Void Approved
				'1a293345-9567-4d9f-8bd1-d4f4fe53a076',
				'234fc9e6-9bdd-4299-90e3-1ffc58f60f31', -- Rejected
				'1da5028f-419e-4265-bdb6-60cc95281a37'
			) ;

-- make active 
select entrydate, entrytime, exitdate, exittime, updatedby, updatedon, activeflag  
	from placementrevision  
where placementid = '69d1efbb-8287-4b24-91ab-3b7c430803a4'
	and placementrevisionid = '63ff4dc3-abec-4d7a-a38f-37babb6e39ab' ;
	
update placementrevision  
set activeflag = 1, 
	updatedon = now(), 
	updatedby = 'CDM-19229'
where placementid = '69d1efbb-8287-4b24-91ab-3b7c430803a4'
	and placementrevisionid = '63ff4dc3-abec-4d7a-a38f-37babb6e39ab' ;
	
-- update exit date
-- 63ff4dc3-abec-4d7a-a38f-37babb6e39ab, 4bfd645e-147d-48ec-a4f1-8b10d99e0443
select entrydate, entrytime, exitdate, exittime, updatedby, updatedon  
	from placementrevision  
where placementid = '69d1efbb-8287-4b24-91ab-3b7c430803a4'
	and exitdate is not null ;

update placementrevision  
set exitdate = '2021-09-20 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-19229'
where placementid = '69d1efbb-8287-4b24-91ab-3b7c430803a4'
	and exitdate is not null ;

-- Routing
select activeflag, routingstatustypeid, activeflag, updatedby, updatedon, * 
from routing
where objectid = '69d1efbb-8287-4b24-91ab-3b7c430803a4'
	and routingid in (  '75123502-5bf7-4aae-a9d2-f1f8a59418f6',
						'670227ed-0fa8-4b37-9227-7994fe90610a',
						'8c60192c-bd80-43de-9070-2b28dde297e8',
						'0428d9d8-89ff-4593-858a-f1fb56da2cd3',
						'1af65480-d6a7-4169-8d8a-4d25bb8c7898',
						'43953d3f-9f19-408f-b3f7-46e2136d24ac'
					 )
	and eventcode = 'PLTR'
order by insertedon desc ;

delete from routing
where objectid = '69d1efbb-8287-4b24-91ab-3b7c430803a4'
		and routingid in (  '75123502-5bf7-4aae-a9d2-f1f8a59418f6',
						'670227ed-0fa8-4b37-9227-7994fe90610a',
						'8c60192c-bd80-43de-9070-2b28dde297e8',
						'0428d9d8-89ff-4593-858a-f1fb56da2cd3',
						'1af65480-d6a7-4169-8d8a-4d25bb8c7898',
						'43953d3f-9f19-408f-b3f7-46e2136d24ac'
					 )
	and eventcode = 'PLTR' ;

-- Placement Validations
-- Update delete sw for Sept 2021
select delete_sw, validation_start_dt, validation_end_dt, validation_status_cd, update_ts, update_user_id 
from tb_placement_validation
where placement_validation_id = 1975968
	and placement_id = 1558909
	and delete_sw = 'Y' ;

Update tb_placement_validation 
set delete_sw = 'N',
	update_ts = now(),
	update_user_id = 'CDM-19229'
where placement_validation_id = 1975968
	and placement_id = 1558909
	and delete_sw = 'Y' ;
	
select delete_sw, validation_start_dt, validation_end_dt, validation_status_cd, update_ts, update_user_id 
	from tb_placement_validation 
where placement_id = 1558909
	and delete_sw = 'N'	
order by validation_start_dt ;

-- Update exit date for all
Update tb_placement_validation 
set placement_exit_dt = '2021-09-20'::date,
	validation_status_cd = '1750',
	update_ts = now(),
	update_user_id = 'CDM-19229'
where placement_id = 1558909
	and delete_sw = 'N' ;


/*
-- Old data 
INSERT INTO cjams.placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status)
VALUES('f12af917-1a51-472f-b540-c41ecb599c9f'::uuid, '69d1efbb-8287-4b24-91ab-3b7c430803a4'::uuid, '2021-10-13 00:00:00.000', '2020-08-05 00:00:00.000', '12:00', NULL, NULL, NULL, NULL, '', '3047', '2021-10-13 00:00:00.000', '1', '2021-10-13 13:36:22.640', 'ba2dbc8f-3213-4b1b-9905-d643e1692db1', '2021-10-13 13:36:22.640', 'ba2dbc8f-3213-4b1b-9905-d643e1692db1', 1, 1127035, 'WKER', 'Changing the placement number', NULL, NULL, NULL, NULL, 1, '2021-10-13 17:35:12.413', '4b8d30e9-1b01-47cb-9cdf-9308451bf98a', '2021-10-13 13:35:14.199', 'ba2dbc8f-3213-4b1b-9905-d643e1692db1', '2021-10-13 13:36:22.640', NULL, NULL, NULL, NULL, 'Approved');

INSERT INTO cjams.placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status)
VALUES('234fc9e6-9bdd-4299-90e3-1ffc58f60f31'::uuid, '69d1efbb-8287-4b24-91ab-3b7c430803a4'::uuid, '2021-10-13 00:00:00.000', '2020-08-05 00:00:00.000', '12:00', NULL, NULL, NULL, NULL, '', '3281', '2021-10-13 00:00:00.000', '1', '2021-10-13 13:28:56.573', '4b8d30e9-1b01-47cb-9cdf-9308451bf98a', '2021-10-13 13:36:22.640', 'ba2dbc8f-3213-4b1b-9905-d643e1692db1', 0, 1127030, 'CIP', NULL, NULL, NULL, NULL, NULL, 1, '2021-10-13 00:01:32.224', '4b8d30e9-1b01-47cb-9cdf-9308451bf98a', '2021-10-12 20:01:33.624', '4b8d30e9-1b01-47cb-9cdf-9308451bf98a', '2021-10-13 13:28:56.573', NULL, NULL, NULL, NULL, 'Rejected');

INSERT INTO cjams.placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status)
VALUES('1a293345-9567-4d9f-8bd1-d4f4fe53a076'::uuid, '69d1efbb-8287-4b24-91ab-3b7c430803a4'::uuid, '2021-10-13 00:00:00.000', '2020-08-05 00:00:00.000', '12:00', NULL, NULL, NULL, NULL, '', '3045', NULL, '1', '2021-10-13 13:35:14.199', '4b8d30e9-1b01-47cb-9cdf-9308451bf98a', '2021-10-13 13:36:22.640', 'ba2dbc8f-3213-4b1b-9905-d643e1692db1', 0, 1127033, 'WKER', 'Changing the placement number', NULL, NULL, NULL, NULL, 1, '2021-10-13 17:35:12.413', '4b8d30e9-1b01-47cb-9cdf-9308451bf98a', '2021-10-13 13:35:14.199', 'ba2dbc8f-3213-4b1b-9905-d643e1692db1', '2021-10-13 13:36:22.640', NULL, NULL, NULL, NULL, 'Approved');

INSERT INTO cjams.placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status)
VALUES('1da5028f-419e-4265-bdb6-60cc95281a37'::uuid, '69d1efbb-8287-4b24-91ab-3b7c430803a4'::uuid, '2021-10-13 00:00:00.000', '2020-08-05 00:00:00.000', '12:00', NULL, NULL, NULL, NULL, '', '3045', '2021-10-13 00:00:00.000', '1', '2021-10-12 20:01:33.624', '4b8d30e9-1b01-47cb-9cdf-9308451bf98a', '2021-10-13 13:36:22.640', 'ba2dbc8f-3213-4b1b-9905-d643e1692db1', 0, 1126947, 'CIP', NULL, NULL, NULL, NULL, NULL, 1, '2021-10-13 00:01:32.224', '4b8d30e9-1b01-47cb-9cdf-9308451bf98a', '2021-10-12 20:01:33.624', '4b8d30e9-1b01-47cb-9cdf-9308451bf98a', '2021-10-13 13:28:56.573', NULL, NULL, NULL, NULL, 'Rejected');

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('75123502-5bf7-4aae-a9d2-f1f8a59418f6'::uuid, 'PLTR', 'ba2dbc8f-3213-4b1b-9905-d643e1692db1', NULL, NULL, 'CWSP', 'IVESV', '69d1efbb-8287-4b24-91ab-3b7c430803a4', 16, 1, 'ba2dbc8f-3213-4b1b-9905-d643e1692db1', '2021-10-13 13:36:22.640', 'ba2dbc8f-3213-4b1b-9905-d643e1692db1', '2021-10-13 13:36:22.640', false, NULL, NULL, NULL, '3100718', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('670227ed-0fa8-4b37-9227-7994fe90610a'::uuid, 'PLTR', 'ba2dbc8f-3213-4b1b-9905-d643e1692db1', '4b8d30e9-1b01-47cb-9cdf-9308451bf98a', '13021883-e81b-49f1-8556-4e048236e271'::uuid, 'CWSP', 'CWSP', '69d1efbb-8287-4b24-91ab-3b7c430803a4', 16, 1, 'ba2dbc8f-3213-4b1b-9905-d643e1692db1', '2021-10-13 13:36:22.640', 'ba2dbc8f-3213-4b1b-9905-d643e1692db1', '2021-10-13 13:36:22.640', true, '', NULL, 'Child PlacementApproved', '3100718', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('8c60192c-bd80-43de-9070-2b28dde297e8'::uuid, 'PLTR', '4b8d30e9-1b01-47cb-9cdf-9308451bf98a', '83cd5f02-663d-4dae-a81d-cdea6933a243', '13021883-e81b-49f1-8556-4e048236e271'::uuid, 'CWSP', 'CWSP', '69d1efbb-8287-4b24-91ab-3b7c430803a4', 15, 0, '4b8d30e9-1b01-47cb-9cdf-9308451bf98a', '2021-10-13 13:35:13.015', 'ba2dbc8f-3213-4b1b-9905-d643e1692db1', '2021-10-13 13:36:22.640', true, 'Void placement submitted for review', NULL, 'Void placement submitted for review', '3100718', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('0428d9d8-89ff-4593-858a-f1fb56da2cd3'::uuid, 'PLTR', '4b8d30e9-1b01-47cb-9cdf-9308451bf98a', '4b8d30e9-1b01-47cb-9cdf-9308451bf98a', '13021883-e81b-49f1-8556-4e048236e271'::uuid, 'CWSP', 'CWSP', '69d1efbb-8287-4b24-91ab-3b7c430803a4', 17, 1, '4b8d30e9-1b01-47cb-9cdf-9308451bf98a', '2021-10-13 13:28:56.573', '4b8d30e9-1b01-47cb-9cdf-9308451bf98a', '2021-10-13 13:28:56.573', true, 'correct program ', NULL, 'Child PlacementRejected', '3100718', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('1af65480-d6a7-4169-8d8a-4d25bb8c7898'::uuid, 'PLTR', '4b8d30e9-1b01-47cb-9cdf-9308451bf98a', '83cd5f02-663d-4dae-a81d-cdea6933a243', '13021883-e81b-49f1-8556-4e048236e271'::uuid, 'CWSP', 'CWSP', '69d1efbb-8287-4b24-91ab-3b7c430803a4', 15, 0, '4b8d30e9-1b01-47cb-9cdf-9308451bf98a', '2021-10-12 20:01:32.411', '4b8d30e9-1b01-47cb-9cdf-9308451bf98a', '2021-10-13 13:28:56.573', true, 'Void placement submitted for review', NULL, 'Void placement submitted for review', '3100718', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('43953d3f-9f19-408f-b3f7-46e2136d24ac'::uuid, 'PLTR', '4b8d30e9-1b01-47cb-9cdf-9308451bf98a', '83cd5f02-663d-4dae-a81d-cdea6933a243', '13021883-e81b-49f1-8556-4e048236e271'::uuid, 'CWSP', 'CWSP', '69d1efbb-8287-4b24-91ab-3b7c430803a4', 15, 0, '4b8d30e9-1b01-47cb-9cdf-9308451bf98a', '2021-10-12 19:57:37.484', '4b8d30e9-1b01-47cb-9cdf-9308451bf98a', '2021-10-12 20:01:32.411', true, 'Void placement submitted for review', NULL, 'Void placement submitted for review', '3100718', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

*/
