-- CDM-18494 - Placement validation issue
/*
-- Issue Description: 
   CJAMS is not allwoing the user to exit the placement with Independent Living Residential Program
   with date beyond client's 21st Birthday. 

   User request to end date the placement as of 10/01/2021
 
-- Case ID: 3116468
-- Client ID: 1716493 (KAYLA WEATHERS) - 539a4d70-fdff-4fa0-8d66-4cc466a9c4d8
-- 21 Bday: 02/05/2021
-- Placement ID: 329654 - 2018-07-12 To Current - fe03353f-404b-4e95-9276-8d07f3714e3a
-- Private Organization: 5000882 (Pressley Ridge, Inc.)
-- CPA Office: 5089880 (Pressley Ridge)
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
where placementid = 'fe03353f-404b-4e95-9276-8d07f3714e3a'
	and activeflag  = 1 ;

update placement  
set enddatetime = '2021-10-01 00:00:00', 
	endtime = '09:00',
	exitreasontypekey = 'PLCCE',
	exittypekey = 'PLCC',
	updatedon = now(), 
	updatedby = 'CDM-18494'
where placementid = 'fe03353f-404b-4e95-9276-8d07f3714e3a'
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
(	gen_random_uuid(), 'fe03353f-404b-4e95-9276-8d07f3714e3a', current_date, '2018-07-12 00:00:00', '10:00', 
	'2021-10-01 00:00:00', '09:00', NULL, 'PLCCE', '', 
	'3047', current_date, NULL, now(), 'CDM-18494', 
	now(), 'CDM-18494', 1, nextval('sequence_placementrevision'::regclass), NULL, 
	NULL, NULL, NULL, 'PLCC', NULL, 
	0, now(), 'c237f718-5ab0-491d-8e01-f243c90493b4', now(), 'c237f718-5ab0-491d-8e01-f243c90493b4', 
	now(), NULL, NULL, NULL, 'Approved'
);
	
select approvalstatustypkey, status, activeflag, updatedby, updatedon	
	from placementrevision 
where placementid  = 'fe03353f-404b-4e95-9276-8d07f3714e3a'
	and placementrevisionid = '57bb212d-a1e4-44e4-a714-e34b4fa9db31' 
	and activeflag = 1;

update placementrevision
set activeflag = 0,
	status =  'Approved',
	approvedby = '5b366c60-e112-4b90-95c5-e6457c11f2d9',
	approveddate = now(),
	updatedon = now(), 
	updatedby = 'CDM-18494'	
where placementid  = 'fe03353f-404b-4e95-9276-8d07f3714e3a'
	and placementrevisionid = '57bb212d-a1e4-44e4-a714-e34b4fa9db31' 
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
		'03c8b237-00c0-4df5-b223-15b08240a510', 'CWSP', 'CWCW', 'fe03353f-404b-4e95-9276-8d07f3714e3a', 16, 1, 
		'CDM-18494', now(), 'CDM-18494', now(), true, 
		'', NULL, 'Child Placement Approved', '3116468', 'Servicecase', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL
	);	

select eventcode, routingstatustypeid, remarks, activeflag, updatedby, updatedon  
	from routing 
where objectid = 'fe03353f-404b-4e95-9276-8d07f3714e3a'
	and routingid = '25d47b65-233d-4880-b955-f327827a50b0'
	and activeflag = 1 ;
	
update routing
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-18494'		
where objectid = 'fe03353f-404b-4e95-9276-8d07f3714e3a'
	and routingid = '25d47b65-233d-4880-b955-f327827a50b0'
	and activeflag = 1 ;
	
-- NO CPA Homes

-- NO Pending Placement Validations
