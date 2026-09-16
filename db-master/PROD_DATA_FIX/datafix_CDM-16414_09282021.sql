-- CDM-16414 - Placement
/*
-- Issue Description: 
   User request to update placement exit date & revert void the below placement
   
-- Case ID: 3279158
-- Client ID: 3228585 (CADEN LARE) - 4e17b4f0-e9ac-496f-9151-f91b653a14cd
-- Placement ID: 1562167 - 2021-03-30 To 2021-09-27 - 20c8fc1f-0d17-494e-91e5-a9f8432d239f
-- Private Organization: 5000543 (Associated Catholic Charities Inc.)	
-- RCC Facility: 5019208 (Associated Catholic Charities -- St V Villa (Pot Spring) RTC)
-- Program: 50002398 (RTC - Pot Spring Rd) - 2020-07-01 To 2022-06-30

-- Category/ Module: Placements  (Case Management) 
-- Root cause: User error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to change the placement Exit date as 08/25/2021 (Voided Placement)
-- Placement Entry date changes
select alternateid, startdatetime, starttime, enddatetime, endtime,
	exitreasontypekey, exittypekey, updatedby , updatedon, 
	isvoided, voidapprovaldate, voidapprovalstatustypekey, voiddate, voidreasontypekey 
from placement 
where placementid = '20c8fc1f-0d17-494e-91e5-a9f8432d239f'
	and activeflag  = 1 ;

update placement  
set enddatetime = '2021-08-25 00:00:00', 
	endtime = '13:00',
	exitreasontypekey = 'PLCCGR', 
	exittypekey = 'PLCC', 
	isvoided = 0, 
	voidapprovaldate = now(), 
	voidapprovalstatustypekey = NULL, 
	voiddate = NULL, 
	voidreasontypekey = NULL, 
	updatedon = now(), 
	updatedby = 'CDM-16414'
where placementid = '20c8fc1f-0d17-494e-91e5-a9f8432d239f'
	and activeflag = 1 ;

-- Placement Revision
select entrydate, entrytime, exitdate, exittime, updatedby, updatedon  
	from placementrevision  
where placementid = '20c8fc1f-0d17-494e-91e5-a9f8432d239f'
	and placementrevisionid
		in (	'e1a9bfb5-bb44-4728-9517-5ac6c6924029', 
				'0d0f72eb-99b6-494e-a411-e688db3b4336', -- 0927
				'ed463cea-34c3-4bbf-94f5-6d7f1dd88455', 
				'59d9081c-2bfe-4870-b2cb-1fb073b10560' -- prior rejection
			) ;

delete from placementrevision
where placementid = '20c8fc1f-0d17-494e-91e5-a9f8432d239f'
	and placementrevisionid
		in (	'e1a9bfb5-bb44-4728-9517-5ac6c6924029', 
				'0d0f72eb-99b6-494e-a411-e688db3b4336', -- 0927
				'ed463cea-34c3-4bbf-94f5-6d7f1dd88455', 
				'59d9081c-2bfe-4870-b2cb-1fb073b10560' -- prior rejection
			) ; 

-- make active 
select entrydate, entrytime, exitdate, exittime, updatedby, updatedon, activeflag  
	from placementrevision  
where placementid = '20c8fc1f-0d17-494e-91e5-a9f8432d239f'
	and placementrevisionid = '552f5fe7-b0d3-499e-a5d2-215f021c5b58' ;
	
update placementrevision  
set activeflag = 1, 
	updatedon = now(), 
	updatedby = 'CDM-16414'
where placementid = '20c8fc1f-0d17-494e-91e5-a9f8432d239f'
	and placementrevisionid = '552f5fe7-b0d3-499e-a5d2-215f021c5b58' ;
	
-- update exit date
-- 552f5fe7-b0d3-499e-a5d2-215f021c5b58, 4bfd645e-147d-48ec-a4f1-8b10d99e0443
select entrydate, entrytime, exitdate, exittime, updatedby, updatedon  
	from placementrevision  
where placementid = '20c8fc1f-0d17-494e-91e5-a9f8432d239f'
	and exitdate is not null ;

update placementrevision  
set exitdate = '2021-08-25 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-16414'
where placementid = '20c8fc1f-0d17-494e-91e5-a9f8432d239f'
	and exitdate is not null ;

-- Routing
select activeflag, routingstatustypeid, activeflag, updatedby, updatedon, * 
from routing
where objectid = '20c8fc1f-0d17-494e-91e5-a9f8432d239f'
	and routingid in (  'c8b007d9-394b-4109-be86-e07904c9d725', 
						'eaf1202a-9c54-4847-9be7-d60e2fe63c1c', 
						'b2f7bd20-04ff-4398-ad03-7139b520a789', -- 0927
						'305167d3-f347-48d2-932f-b2f48fa906eb', 
						'5aacf11d-e21e-41d9-ac74-d720e27cff94' -- prior rejection
					 )
	and eventcode = 'PLTR'
order by insertedon desc ;

delete from routing
where objectid = '20c8fc1f-0d17-494e-91e5-a9f8432d239f'
	and routingid in (  'c8b007d9-394b-4109-be86-e07904c9d725', 
						'eaf1202a-9c54-4847-9be7-d60e2fe63c1c', 
						'b2f7bd20-04ff-4398-ad03-7139b520a789', -- 0927
						'305167d3-f347-48d2-932f-b2f48fa906eb', 
						'5aacf11d-e21e-41d9-ac74-d720e27cff94' -- prior rejection
					 )
	and eventcode = 'PLTR' ;

/*
-- Old data 
INSERT INTO cjams.placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status)
VALUES('e1a9bfb5-bb44-4728-9517-5ac6c6924029', '20c8fc1f-0d17-494e-91e5-a9f8432d239f', '2021-09-27 00:00:00.000', '2021-03-30 00:00:00.000', '08:00', NULL, NULL, NULL, NULL, '', '3047', '2021-09-27 00:00:00.000', '1', '2021-09-27 15:55:45.033', 'f34f6216-b36d-4690-a366-5db57b2a2ddd', '2021-09-27 15:55:45.033', 'f34f6216-b36d-4690-a366-5db57b2a2ddd', 1, 1123797, 'WKER', 'There are multiple placements with the same date range.', NULL, NULL, NULL, NULL, 1, '2021-09-27 19:36:04.637', '2ff6613d-5f45-4ed7-9153-b51d3a9e2472', '2021-09-27 15:37:06.476', 'f34f6216-b36d-4690-a366-5db57b2a2ddd', '2021-09-27 15:55:45.033', NULL, NULL, NULL, NULL, 'Approved');
INSERT INTO cjams.placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status)
VALUES('59d9081c-2bfe-4870-b2cb-1fb073b10560', '20c8fc1f-0d17-494e-91e5-a9f8432d239f', '2021-09-27 00:00:00.000', '2021-03-30 00:00:00.000', '08:00', '2021-08-25 00:00:00.000', NULL, NULL, NULL, '', '3045', '2021-09-27 00:00:00.000', '1', '2021-08-25 16:15:55.469', 'b343fc35-3b92-4f00-a0da-c2552709c326', '2021-09-27 15:55:45.033', 'f34f6216-b36d-4690-a366-5db57b2a2ddd', 0, 1118540, NULL, NULL, NULL, NULL, NULL, 'Caden is going to Florida to live with his grandparents.', 0, NULL, 'b343fc35-3b92-4f00-a0da-c2552709c326', '2021-08-25 16:15:55.469', '2ff6613d-5f45-4ed7-9153-b51d3a9e2472', '2021-08-26 12:50:31.057', NULL, NULL, NULL, NULL, 'Rejected');
INSERT INTO cjams.placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status)
VALUES('0d0f72eb-99b6-494e-a411-e688db3b4336', '20c8fc1f-0d17-494e-91e5-a9f8432d239f', '2021-09-27 00:00:00.000', '2021-03-30 00:00:00.000', '08:00', NULL, NULL, NULL, NULL, '', '3045', NULL, '1', '2021-09-27 15:37:06.476', '2ff6613d-5f45-4ed7-9153-b51d3a9e2472', '2021-09-27 15:55:45.033', 'f34f6216-b36d-4690-a366-5db57b2a2ddd', 0, 1123785, 'WKER', 'There are multiple placements with the same date range.', NULL, NULL, NULL, NULL, 1, '2021-09-27 19:36:04.637', '2ff6613d-5f45-4ed7-9153-b51d3a9e2472', '2021-09-27 15:37:06.476', 'f34f6216-b36d-4690-a366-5db57b2a2ddd', '2021-09-27 15:55:45.033', NULL, NULL, NULL, NULL, 'Approved');
INSERT INTO cjams.placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status)
VALUES('ed463cea-34c3-4bbf-94f5-6d7f1dd88455', '20c8fc1f-0d17-494e-91e5-a9f8432d239f', '2021-09-27 00:00:00.000', '2021-03-30 00:00:00.000', '08:00', '2021-08-25 00:00:00.000', NULL, NULL, NULL, '', '3281', '2021-09-27 00:00:00.000', '1', '2021-08-26 12:50:31.057', '2ff6613d-5f45-4ed7-9153-b51d3a9e2472', '2021-09-27 15:55:45.033', 'f34f6216-b36d-4690-a366-5db57b2a2ddd', 0, 1118753, NULL, NULL, NULL, NULL, NULL, 'Caden is going to Florida to live with his grandparents.', 0, NULL, 'b343fc35-3b92-4f00-a0da-c2552709c326', '2021-08-25 16:15:55.469', '2ff6613d-5f45-4ed7-9153-b51d3a9e2472', '2021-08-26 12:50:31.057', NULL, NULL, NULL, NULL, 'Rejected');

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('c8b007d9-394b-4109-be86-e07904c9d725', 'PLTR', 'f34f6216-b36d-4690-a366-5db57b2a2ddd', NULL, NULL, 'CWSP', 'IVESV', '20c8fc1f-0d17-494e-91e5-a9f8432d239f', 16, 1, 'f34f6216-b36d-4690-a366-5db57b2a2ddd', '2021-09-27 15:55:45.033', 'f34f6216-b36d-4690-a366-5db57b2a2ddd', '2021-09-27 15:55:45.033', false, NULL, NULL, NULL, '3279158', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('eaf1202a-9c54-4847-9be7-d60e2fe63c1c', 'PLTR', 'f34f6216-b36d-4690-a366-5db57b2a2ddd', '2ff6613d-5f45-4ed7-9153-b51d3a9e2472', '96b16cd3-9894-4afa-ae33-8c92d35f615c', 'CWSP', 'CWSP', '20c8fc1f-0d17-494e-91e5-a9f8432d239f', 16, 1, 'f34f6216-b36d-4690-a366-5db57b2a2ddd', '2021-09-27 15:55:45.033', 'f34f6216-b36d-4690-a366-5db57b2a2ddd', '2021-09-27 15:55:45.033', true, '', NULL, 'Child PlacementApproved', '3279158', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('b2f7bd20-04ff-4398-ad03-7139b520a789', 'PLTR', '2ff6613d-5f45-4ed7-9153-b51d3a9e2472', 'f34f6216-b36d-4690-a366-5db57b2a2ddd', '96b16cd3-9894-4afa-ae33-8c92d35f615c', 'CWSP', 'CWSP', '20c8fc1f-0d17-494e-91e5-a9f8432d239f', 15, 0, '2ff6613d-5f45-4ed7-9153-b51d3a9e2472', '2021-09-27 15:37:05.438', 'f34f6216-b36d-4690-a366-5db57b2a2ddd', '2021-09-27 15:55:45.033', true, 'Void placement submitted for review', NULL, 'Void placement submitted for review', '3279158', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('305167d3-f347-48d2-932f-b2f48fa906eb', 'PLTR', '2ff6613d-5f45-4ed7-9153-b51d3a9e2472', 'b343fc35-3b92-4f00-a0da-c2552709c326', '96b16cd3-9894-4afa-ae33-8c92d35f615c', 'CWSP', 'CWCW', '20c8fc1f-0d17-494e-91e5-a9f8432d239f', 17, 1, '2ff6613d-5f45-4ed7-9153-b51d3a9e2472', '2021-08-26 12:50:31.057', '2ff6613d-5f45-4ed7-9153-b51d3a9e2472', '2021-08-26 12:50:31.057', true, 'Exit type should be permanently leaving care and custody.', NULL, 'Child PlacementRejected', '3279158', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('5aacf11d-e21e-41d9-ac74-d720e27cff94', 'PLTR', 'b343fc35-3b92-4f00-a0da-c2552709c326', '2ff6613d-5f45-4ed7-9153-b51d3a9e2472', '96b16cd3-9894-4afa-ae33-8c92d35f615c', 'CWCW', 'CWSP', '20c8fc1f-0d17-494e-91e5-a9f8432d239f', 15, 0, 'b343fc35-3b92-4f00-a0da-c2552709c326', '2021-08-25 16:15:54.555', '2ff6613d-5f45-4ed7-9153-b51d3a9e2472', '2021-08-26 12:50:31.057', true, '', NULL, 'Placement Exit Submitted for review', '3279158', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/
