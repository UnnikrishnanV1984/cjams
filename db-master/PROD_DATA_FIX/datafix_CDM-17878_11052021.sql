-- CDM-17878 - Case Closing Issue
/*
-- Issue Description: 
	Youth remained in care beyond 21 due to extended foster care. 
	His case needs closed effective 9/30/21 and there is a placement validation issue.

   User request to end date the placement as of 09/30/2021
   Exception scenario: Youth is 21 and was allowed to remain in care beyond 21

-- Case ID: 3196020 - brittany.harrison2@maryland.gov
-- Client ID: 3190898 (KAYSHAUN STERLING) - 781287fd-8089-4f9f-aab7-442288591ebe
-- 21st Bday - 07/12/2021
-- Placement ID: 1557004 - 2020-08-19 To Current - bf5ba81e-e09f-4e44-a872-c4e84346bc6f
-- Placement Staruture: Independent Living Residential Program
-- Private Organization: 5001352 (The National Center for Children and Families, Inc.)
-- CPA Office: 5001597 (National Center for Children and Families - Futurebound IL Program)
-- Program: 736	(Futurebound IL) - 2006-02-01 To 2022-06-30 
  
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
where placementid = 'bf5ba81e-e09f-4e44-a872-c4e84346bc6f'
	and activeflag  = 1 ;

update placement  
set enddatetime = '2021-09-30 00:00:00', 
	endtime = '17:00',
	exitreasontypekey = 'PLCCE',
	exittypekey = 'PLCC',
	updatedon = now(), 
	updatedby = 'CDM-17878'
where placementid = 'bf5ba81e-e09f-4e44-a872-c4e84346bc6f'
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
(	gen_random_uuid(), 'bf5ba81e-e09f-4e44-a872-c4e84346bc6f', current_date, '2020-08-19 00:00:00', '10:01', 
	'2021-09-30 00:00:00', '17:00', NULL, 'PLCCE', '', 
	'3047', current_date, NULL, now(), 'CDM-17878', 
	now(), 'CDM-17878', 1, nextval('sequence_placementrevision'::regclass), NULL, 
	NULL, NULL, NULL, 'PLCC', 'Kay will be moving to a DDA placement.', 
	0, now(), '37eb808f-0446-4909-9809-65d3559b0f24', now(), '362086ed-9366-451c-b7c1-b623d6de193b', 
	now(), NULL, NULL, NULL, 'Approved'
);
	
select approvalstatustypkey, status, activeflag, updatedby, updatedon	
	from placementrevision 
where placementid  = 'bf5ba81e-e09f-4e44-a872-c4e84346bc6f'
	and placementrevisionid = 'cb576fb5-ac58-4e60-87eb-a1736b5adc97' 
	and activeflag = 1;

update placementrevision
set activeflag = 0,
	status =  'Approved',
	approvedby = '362086ed-9366-451c-b7c1-b623d6de193b',
	approveddate = now(),
	updatedon = now(), 
	updatedby = 'CDM-17878'	
where placementid  = 'bf5ba81e-e09f-4e44-a872-c4e84346bc6f'
	and placementrevisionid = 'cb576fb5-ac58-4e60-87eb-a1736b5adc97' 
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
		'f7c2b0f5-87ae-442a-b7d6-018d5c7cde99', 'CWSP', 'CWCW', 'bf5ba81e-e09f-4e44-a872-c4e84346bc6f', 16, 1, 
		'CDM-17878', now(), 'CDM-17878', now(), true, 
		'', NULL, 'Child Placement Approved', '3196020', 'Servicecase', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL
	);	

select eventcode, routingstatustypeid, remarks, activeflag, updatedby, updatedon  
	from routing 
where objectid = 'bf5ba81e-e09f-4e44-a872-c4e84346bc6f'
	and routingid = '8cd526e4-11fe-436f-a659-908180467086'
	and activeflag = 1 ;
	
update routing
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-17878'		
where objectid = 'bf5ba81e-e09f-4e44-a872-c4e84346bc6f'
	and routingid = '8cd526e4-11fe-436f-a659-908180467086'
	and activeflag = 1 ;
	
-- Exit CPA Home
select entrydt, entrytm, exitdt, exittm, exittypecd, exitreasoncd, updatets, updateuserid 
	from placementcpahomes 
where placementid = 'bf5ba81e-e09f-4e44-a872-c4e84346bc6f'
	and placementcpahomeid = '212f2142-405b-480d-b778-ccd7169ad5d0'
	and activeflag = 1 ;

update placementcpahomes
set exitdt = '2021-09-30 00:00:00',
	exittm = '2021-09-30 17:00:00',
	exittypecd = 'PLCC',
	exitreasoncd = 'PLCCE',
	updatets = now(),
	updateuserid = 'CDM-17878'
where placementid = 'bf5ba81e-e09f-4e44-a872-c4e84346bc6f'
	and placementcpahomeid = '212f2142-405b-480d-b778-ccd7169ad5d0'
	and activeflag = 1 ;	

--  NO Pending Placement Validations

