-- CDM-17303 - placement end date issue
/*
-- Issue Description: 
   User request to end date the placement as of 09/30/2021
   Exception scenario: Youth is 21 and was allowed to remain in care beyond 21

-- Case ID: 3269899
-- Client ID: 3989355 (ANTHONY KUREK) - 2cbca8a9-fe6d-4abf-ab3d-88444b5c34c2 
-- 21st Bday - 12/31/2020
-- Placement ID: 337022 - 2019-09-24 To Current - 53b693f8-c60c-4fd9-9d3b-0c8c3a4bc7f0
-- Placement Staruture: Independent Living Residential Program
-- Private Organization: 5000882 (Pressley Ridge, Inc.)
-- CPA Office: 5089880 (Pressley Ridge - Independence Plus ILP - Towson)
-- Program: 15363 (Independence Plus) - 2007-04-16 To 2022-06-30
   
-- Category/ Module: Placements  (Case Management) 
-- Root cause: Currently CJAMS is not allowing the users to modify the placements after exit.
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- Placement Exit 
select alternateid, startdatetime, starttime, enddatetime, endtime,
	exitreasontypekey, exittypekey, updatedby , updatedon 
from placement 
where placementid = '53b693f8-c60c-4fd9-9d3b-0c8c3a4bc7f0'
	and activeflag  = 1 ;

update placement  
set enddatetime = '2021-09-30 00:00:00', 
	endtime = '17:00',
	exitreasontypekey = 'PLCCE',
	exittypekey = 'PLCC',
	updatedon = now(), 
	updatedby = 'CDM-17303'
where placementid = '53b693f8-c60c-4fd9-9d3b-0c8c3a4bc7f0'
	and activeflag = 1 ;

INSERT INTO cjams.placementrevision
(	placementrevisionid, placementid, transactiondate, entrydate, entrytime, 
	exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, 
	approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, 
	updatedon, updatedby, activeflag, alternateid, voidreasontypekey, 
	voidremarks, enddate, endtime, exittypekey, remarks, 
	isvoided, voiddate, requestedby, requesteddate, approvedby, 
	approveddate, etl_userid, etl_load_date, ischangepreadoptive, status
)
VALUES
(	gen_random_uuid(), '53b693f8-c60c-4fd9-9d3b-0c8c3a4bc7f0', current_date, '2019-09-24 00:00:00', '10:00', 
	'2021-09-30 00:00:00', '17:00', NULL, 'PLCCE', '', 
	'3047', current_date, NULL, now(), 'CDM-17303', 
	now(), 'CDM-17303', 1, nextval('sequence_placementrevision'::regclass), NULL, 
	NULL, NULL, NULL, 'PLCC', 'Aged out', 
	0, now(), '37eb808f-0446-4909-9809-65d3559b0f24', now(), '362086ed-9366-451c-b7c1-b623d6de193b', 
	now(), NULL, NULL, NULL, 'Approved'
);
	
select approvalstatustypkey, status, activeflag, updatedby, updatedon	
	from placementrevision 
where placementid  = '53b693f8-c60c-4fd9-9d3b-0c8c3a4bc7f0'
	and placementrevisionid = '26f4a96c-8a5f-4442-b9ca-4ae303f7512e' 
	and activeflag = 1;

update placementrevision
set activeflag = 0,
	status =  'Approved',
	approvedby = '362086ed-9366-451c-b7c1-b623d6de193b',
	approveddate = now(),
	updatedon = now(), 
	updatedby = 'CDM-17303'	
where placementid  = '53b693f8-c60c-4fd9-9d3b-0c8c3a4bc7f0'
	and placementrevisionid = '26f4a96c-8a5f-4442-b9ca-4ae303f7512e' 
	and activeflag = 1;

-- Update routing
INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, tosecurityusersid, 
		teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, isreviewrequest, 
		remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, 
		old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, 
		etl_load_date, entityid, reassignnotes
	)
VALUES
	(	gen_random_uuid(), 'PLTR', '362086ed-9366-451c-b7c1-b623d6de193b', '37eb808f-0446-4909-9809-65d3559b0f24', 
		'f7c2b0f5-87ae-442a-b7d6-018d5c7cde99', 'CWSP', 'CWCW', '53b693f8-c60c-4fd9-9d3b-0c8c3a4bc7f0', 16, 1, 
		'CDM-17303', now(), 'CDM-17303', now(), true, 
		'', NULL, 'Child Placement Approved', '3269899', 'Servicecase', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL
	);	

select eventcode, routingstatustypeid, remarks, activeflag, updatedby, updatedon  
	from routing 
where objectid = '53b693f8-c60c-4fd9-9d3b-0c8c3a4bc7f0'
	and routingid = '00894bbb-cf86-4e2e-91ce-6834e977c87b'
	and activeflag = 1 ;
	
update routing
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-17303'		
where objectid = '53b693f8-c60c-4fd9-9d3b-0c8c3a4bc7f0'
	and routingid = '00894bbb-cf86-4e2e-91ce-6834e977c87b'
	and activeflag = 1 ;
	
-- Exit CPA Home
select entrydt, entrytm, exitdt, exittm, exittypecd, exitreasoncd, updatets, updateuserid 
	from placementcpahomes 
where placementcpahomeid = '6be8d0fd-37b0-4e62-ae5d-e47cf719f94a'
	and activeflag = 1 ;

update placementcpahomes
set exitdt = '2021-09-30 00:00:00',
	exittm = '2021-09-30 17:00:00',
	exittypecd = 'PLCC',
	exitreasoncd = 'PLCCE',
	updatets = now(),
	updateuserid = 'CDM-17303'
where placementcpahomeid = '6be8d0fd-37b0-4e62-ae5d-e47cf719f94a'
	and activeflag = 1 ;	
