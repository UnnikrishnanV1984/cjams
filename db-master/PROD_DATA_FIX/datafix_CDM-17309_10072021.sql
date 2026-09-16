-- CDM-17309 - Cant close placement/case
/*
-- Issue Description: 
   User request to end date the placement as of 09/30/2021
   Exception scenario: Youth is 21 and was allowed to remain in care beyond 21
   
-- Case ID: 3277146
-- Client ID: 1737003 (MAURICE R TOBIN) - ab589637-ff6a-4eb2-aaa0-36e2a0ee3cd6
-- 21st Birthday 02/23/2021
-- Placement ID: 327341 - 2018-05-22 To Current - cd4780e5-dca9-42b2-a260-ea4657312b40
-- Placement Staruture: Independent Living Residential Program
-- Private Organization: 5001294 (King Edwards' Inc.)
-- CPA Office: 5001424 (King Edwards' Inc. ILP)
-- Program: 1274 (Ind Liv Pgm King Edwards House, Inc.) - 2006-07-01 To 2022-06-30

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
where placementid = 'cd4780e5-dca9-42b2-a260-ea4657312b40'
	and activeflag  = 1 ;

update placement  
set enddatetime = '2021-09-30 00:00:00', 
	endtime = '17:00',
	exitreasontypekey = 'PLCCE',
	exittypekey = 'PLCC',
	updatedon = now(), 
	updatedby = 'CDM-17309'
where placementid = 'cd4780e5-dca9-42b2-a260-ea4657312b40'
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
(	gen_random_uuid(), 'cd4780e5-dca9-42b2-a260-ea4657312b40', current_date, '2018-05-22 00:00:00', '10:30', 
	'2021-09-30 00:00:00', '17:00', NULL, 'PLCCE', '', 
	'3047', current_date, NULL, now(), 'CDM-17309', 
	now(), 'CDM-17309', 1, nextval('sequence_placementrevision'::regclass), NULL, 
	NULL, NULL, NULL, 'PLCC', 'Aged out. Moved into own apartment: 702-A Stoney Mill Ct Cockeysville MD 21030.', 
	0, now(), '8c38cb86-3ca7-476e-8d52-f89c4d62be66', now(), '4103969d-6c19-4065-8d86-fa7706680634', 
	now(), NULL, NULL, NULL, 'Approved'
);
	
select approvalstatustypkey, status, activeflag, updatedby, updatedon	
	from placementrevision 
where placementid  = 'cd4780e5-dca9-42b2-a260-ea4657312b40'
	and placementrevisionid = '4a9ffa9c-ff5d-489a-8ef1-0464f86f9fea' 
	and activeflag = 1;

update placementrevision
set activeflag = 0,
	status =  'Approved',
	approvedby = '4103969d-6c19-4065-8d86-fa7706680634',
	approveddate = now(),
	updatedon = now(), 
	updatedby = 'CDM-17309'	
where placementid  = 'cd4780e5-dca9-42b2-a260-ea4657312b40'
	and placementrevisionid = '4a9ffa9c-ff5d-489a-8ef1-0464f86f9fea' 
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
	(	gen_random_uuid(), 'PLTR', '4103969d-6c19-4065-8d86-fa7706680634', '8c38cb86-3ca7-476e-8d52-f89c4d62be66', 
		'7c2ad291-af40-418d-97a0-7871ceb16f90', 'CWSP', 'CWCW', 'cd4780e5-dca9-42b2-a260-ea4657312b40', 16, 1, 
		'CDM-16263', now(), 'CDM-17309', now(), true, 
		'', NULL, 'Child Placement Approved', '3277146', 'Servicecase', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL
	);	

select eventcode, routingstatustypeid, remarks, activeflag, updatedby, updatedon  
	from routing 
where objectid = 'cd4780e5-dca9-42b2-a260-ea4657312b40'
	and routingid = 'c9cd8c60-49da-4b27-a9fa-9ed6cb8468df'
	and activeflag = 1 ;
	
update routing
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-17309'		
where objectid = 'cd4780e5-dca9-42b2-a260-ea4657312b40'
	and routingid = 'c9cd8c60-49da-4b27-a9fa-9ed6cb8468df'
	and activeflag = 1 ;
	
-- Exit CPA Homes
select entrydt, entrytm, exitdt, exittm, exittypecd, exitreasoncd, updatets, updateuserid 
	from placementcpahomes 
where placementcpahomeid = '4eab4ba6-46a0-493b-a48a-86af8996b6e4'
	and activeflag = 1 ;

update placementcpahomes
set exitdt = '2020-09-14 12:00:00',
	exittm = '2020-09-14 12:00:00',
	exittypecd = 'CIP',
	exitreasoncd = 'CIPNHC',
	updatets = now(),
	updateuserid = 'CDM-17309'
where placementcpahomeid = '4eab4ba6-46a0-493b-a48a-86af8996b6e4'
	and activeflag = 1 ;

select entrydt, entrytm, exitdt, exittm, exittypecd, exitreasoncd, updatets, updateuserid 
	from placementcpahomes 
where placementcpahomeid = '9d679055-e529-42d3-87a3-3de6944314c1'
	and activeflag = 1 ;

update placementcpahomes
set exitdt = '2021-09-30 00:00:00',
	exittm = '2021-09-30 17:00:00',
	exittypecd = 'PLCC',
	exitreasoncd = 'PLCCE',
	updatets = now(),
	updateuserid = 'CDM-17309'
where placementcpahomeid = '9d679055-e529-42d3-87a3-3de6944314c1'
	and activeflag = 1 ;	