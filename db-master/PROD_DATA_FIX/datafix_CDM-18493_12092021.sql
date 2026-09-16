-- CDM-18493 - placement validation issue
/*
-- Issue Description: 
   CJAMS is not allwoing the user to exit the placement with Independent Living Residential Program
   with date beyond client's 21st Birthday. 

   User request to end date the placement as of 10/01/2021
 
-- Case ID: 3266134
-- Client ID: 3937354 (ERIK COOPER) - c8f2e66c-510c-4bb3-9ea0-bb641f692b64
-- 21 Bday: 06/15/2021
-- Placement ID: 1557607 - 2020-07-13 To Current - 548997ea-fee6-40b1-b819-1fa8cfde29c5
-- Private Organization: 5001321 (Challengers Independent Living, Inc.)
-- CPA Office: 5074849 - Challengers ILP (West)
-- Placement Structure: Independent Living Residential Program
 
-- Category/ Module: Placements (Case Management) 
-- Root cause: Exception scenario: Youth is 21 and was allowed to remain in care beyond 21
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Placement Exit 
select alternateid, startdatetime, starttime, enddatetime, endtime,
	exitreasontypekey, exittypekey, updatedby , updatedon 
from placement 
where placementid = '548997ea-fee6-40b1-b819-1fa8cfde29c5'
	and activeflag  = 1 ;

update placement  
set enddatetime = '2021-10-01 00:00:00', 
	endtime = '09:00',
	exitreasontypekey = 'PLCCE',
	exittypekey = 'PLCC',
	updatedon = now(), 
	updatedby = 'CDM-18493'
where placementid = '548997ea-fee6-40b1-b819-1fa8cfde29c5'
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
(	gen_random_uuid(), '548997ea-fee6-40b1-b819-1fa8cfde29c5', current_date, '2020-07-13 00:00:00', '10:01', 
	'2021-10-01 00:00:00', '09:00', NULL, 'PLCCE', '', 
	'3047', current_date, NULL, now(), 'CDM-18493', 
	now(), 'CDM-18493', 1, nextval('sequence_placementrevision'::regclass), NULL, 
	NULL, NULL, NULL, 'PLCC', NULL, 
	0, now(), 'c237f718-5ab0-491d-8e01-f243c90493b4', now(), 'c237f718-5ab0-491d-8e01-f243c90493b4', 
	now(), NULL, NULL, NULL, 'Approved'
);
	
select approvalstatustypkey, status, activeflag, updatedby, updatedon	
	from placementrevision 
where placementid  = '548997ea-fee6-40b1-b819-1fa8cfde29c5'
	and placementrevisionid = '8ee65d78-5dfd-4458-a69a-5c75a2e333c1' 
	and activeflag = 1;

update placementrevision
set activeflag = 0,
	status =  'Approved',
	approvedby = '5b366c60-e112-4b90-95c5-e6457c11f2d9',
	approveddate = now(),
	updatedon = now(), 
	updatedby = 'CDM-18493'	
where placementid  = '548997ea-fee6-40b1-b819-1fa8cfde29c5'
	and placementrevisionid = '8ee65d78-5dfd-4458-a69a-5c75a2e333c1' 
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
	(	gen_random_uuid(), 'PLTR', '5b366c60-e112-4b90-95c5-e6457c11f2d9', 'c237f718-5ab0-491d-8e01-f243c90493b4', 
		'03c8b237-00c0-4df5-b223-15b08240a510', 'CWSP', 'CWCW', '548997ea-fee6-40b1-b819-1fa8cfde29c5', 16, 1, 
		'CDM-18493', now(), 'CDM-18493', now(), true, 
		'', NULL, 'Child Placement Approved', '3266134', 'Servicecase', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL
	);	

select eventcode, routingstatustypeid, remarks, activeflag, updatedby, updatedon  
	from routing 
where objectid = '548997ea-fee6-40b1-b819-1fa8cfde29c5'
	and routingid = 'b4020cbb-0539-4d62-ae40-1ac6203a90e2'
	and activeflag = 1 ;
	
update routing
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-18493'		
where objectid = '548997ea-fee6-40b1-b819-1fa8cfde29c5'
	and routingid = 'b4020cbb-0539-4d62-ae40-1ac6203a90e2'
	and activeflag = 1 ;
	
-- NO CPA Homes

-- NO Pending Placement Validations
