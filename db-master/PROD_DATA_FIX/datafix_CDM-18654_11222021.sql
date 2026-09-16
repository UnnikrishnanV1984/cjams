-- CDM-18654 - Validations
/*
-- Issue Description: 
   We are trying to close this placement but when we click approval is is showing 
   the validations and it will not allow us to validate because he is 22 years old. 

   This client remained in care do to the COVID Pandemic.
   
   User request to end date the placement as of 09/30/2021
   Exception scenario: Youth is 21 and was allowed to remain in care beyond 21

-- Case ID: 3113322 
-- Client ID: 1653413 (CASEY SHARP) - 574c3a61-09ec-4c2b-b061-dd8745f13300
-- 21st Bday - 2020-05-23 
-- Placment ID: 324941 - 2018-02-21 To Current - 50eed5e0-b0bf-43b8-9992-3b75afb4a6a2
-- Placement Staruture: Treatment Foster Care (Private)
-- Private Organization: 5000744 (The Children's Guild, Inc.)
-- CPA Office: 5001641 (Children's Guild TFC)
-- Program: 1711 (Children's Guild TFC) - 2006-07-01 To 2022-06-30
  
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
where placementid = '50eed5e0-b0bf-43b8-9992-3b75afb4a6a2'
	and activeflag  = 1 ;

update placement  
set enddatetime = '2021-09-30 00:00:00', 
	endtime = '14:38',
	exitreasontypekey = 'PLCCE',
	exittypekey = 'PLCC',
	updatedon = now(), 
	updatedby = 'CDM-18654'
where placementid = '50eed5e0-b0bf-43b8-9992-3b75afb4a6a2'
	and activeflag = 1 ;

INSERT INTO cjams.placementrevision
(	placementrevisionid, placementid, transactiondate, entrydate, 
	entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, 
	approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, 
	updatedon, updatedby, activeflag, alternateid, voidreasontypekey, 
	voidremarks, enddate, endtime, exittypekey, remarks, 
	isvoided, voiddate, requestedby, requesteddate, approvedby, 
	approveddate, etl_userid, etl_load_date, ischangepreadoptive, status
)
VALUES
(	gen_random_uuid(), '50eed5e0-b0bf-43b8-9992-3b75afb4a6a2', current_date, '2018-02-21 00:00:00', 
	'17:00', '2021-09-30 00:00:00', '14:38', NULL, 'PLCCE', '', 
	'3047', current_date, NULL, now(), 'CDM-18654', 
	now(), 'CDM-18654', 1, nextval('sequence_placementrevision'::regclass), NULL, 
	NULL, NULL, NULL, 'PLCC', NULL, 
	0, now(), 'd636ac2f-53ff-43e0-adbf-35c97e0427ec', now(), '056865a7-2a58-494e-9993-ccc6fd9aae58', 
	now(), NULL, NULL, NULL, 'Approved'
);
	
select approvalstatustypkey, status, activeflag, updatedby, updatedon	
	from placementrevision 
where placementid  = '50eed5e0-b0bf-43b8-9992-3b75afb4a6a2'
	and placementrevisionid = 'c96bfb8f-d01b-4f74-84c2-3b8d4d544620' 
	and activeflag = 1;

update placementrevision
set activeflag = 0,
	status =  'Approved',
	approvedby = '056865a7-2a58-494e-9993-ccc6fd9aae58',
	approveddate = now(),
	updatedon = now(), 
	updatedby = 'CDM-18654'	
where placementid  = '50eed5e0-b0bf-43b8-9992-3b75afb4a6a2'
	and placementrevisionid = 'c96bfb8f-d01b-4f74-84c2-3b8d4d544620' 
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
	(	gen_random_uuid(), 'PLTR', '056865a7-2a58-494e-9993-ccc6fd9aae58', 'd636ac2f-53ff-43e0-adbf-35c97e0427ec', 
		'f7c2b0f5-87ae-442a-b7d6-018d5c7cde99', 'CWSP', 'CWCW', '50eed5e0-b0bf-43b8-9992-3b75afb4a6a2', 16, 1, 
		'CDM-18654', now(), 'CDM-18654', now(), true, 
		'', NULL, 'Child Placement Approved', '3113322', 'Servicecase', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL
	);	

select eventcode, routingstatustypeid, remarks, activeflag, updatedby, updatedon  
	from routing 
where objectid = '50eed5e0-b0bf-43b8-9992-3b75afb4a6a2'
	and routingid = 'a771b785-f40b-40c7-a571-b081364aff75'
	and activeflag = 1 ;
	
update routing
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-18654'		
where objectid = '50eed5e0-b0bf-43b8-9992-3b75afb4a6a2'
	and routingid = 'a771b785-f40b-40c7-a571-b081364aff75'
	and activeflag = 1 ;
	
-- NO Open Exit CPA Home(s)

-- NO Pending Placement Validations
