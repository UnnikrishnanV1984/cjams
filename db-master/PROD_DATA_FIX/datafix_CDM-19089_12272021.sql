-- CDM-19089 - End date Removal
/*
-- Issue Description: 
   User request to end date the Child Removal/OOH/Placement as of 09/30/2021
   Exception scenario: Youth is 21 and was allowed to remain in care beyond 21
   

-- Case ID: 3106731
-- Client ID: 1732231 (EDWARD M	MOODY) - 783d3bc2-22b7-472d-9c86-2c68ef2c73a5
-- Placement ID: 325580 - 2018-03-23 To Current - 65864b13-412f-4731-84a0-08440a5f408e
-- Private Organization: 5001414 (The Martin Pollak Project, Inc.)
-- CPA Office: 5001436 (Martin Pollak Independent Living Program)
-- Program: 1283 (Independent Living Pgm-Martin Pollak) - 2006-07-01 To 2022-06-30
-- Placement Structure: Independent Living Residential Program   

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
where placementid = '65864b13-412f-4731-84a0-08440a5f408e'
	and activeflag  = 1 ;

update placement  
set enddatetime = '2021-09-30 00:00:00', 
	endtime = '17:00',
	exitreasontypekey = 'PLCCE',
	exittypekey = 'PLCC',
	updatedon = now(), 
	updatedby = 'CDM-19089'
where placementid = '65864b13-412f-4731-84a0-08440a5f408e'
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
(	gen_random_uuid(), '65864b13-412f-4731-84a0-08440a5f408e', current_date, '2018-03-23 00:00:00', '09:44', 
	'2021-09-30 00:00:00', '17:00', NULL, 'PLCCE', '', 
	'3047', current_date, NULL, now(), 'CDM-19089', 
	now(), 'CDM-19089', 1, nextval('sequence_placementrevision'::regclass), NULL, 
	NULL, NULL, NULL, 'PLCC', 'Edward aged out of care and moved to his sister.', 
	0, now(), '40c41d94-a322-4495-930e-7af91dd48ff8', now(), '4d1dfcc6-5bbb-44c7-898a-a399f1229278', 
	now(), NULL, NULL, NULL, 'Approved'
);
	
select approvalstatustypkey, status, entrydate, entrytime, exitdate, exittime, 
	exitreasontypkey, exittypekey, activeflag, updatedby, updatedon	
	from placementrevision 
where placementid  = '65864b13-412f-4731-84a0-08440a5f408e'
	and placementrevisionid = '4f2907a8-677f-4824-a2c3-84390cbb1f6f'
	and activeflag = 1;


update placementrevision
set entrydate = '2018-03-23 00:00:00',
	exitdate = '2021-09-30 00:00:00',
	exittime = '17:00',
	exitreasontypkey = 'PLCCE',
	exittypekey = 'PLCC',
	activeflag = 0,
	status =  'Approved',
	approvedby = '4d1dfcc6-5bbb-44c7-898a-a399f1229278',
	approveddate = now(),
	updatedon = now(), 
	updatedby = 'CDM-19089'	
where placementid  = '65864b13-412f-4731-84a0-08440a5f408e'
	and placementrevisionid = '4f2907a8-677f-4824-a2c3-84390cbb1f6f' 
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
	(	gen_random_uuid(), 'PLTR', '4d1dfcc6-5bbb-44c7-898a-a399f1229278', '40c41d94-a322-4495-930e-7af91dd48ff8', 
		'7c2ad291-af40-418d-97a0-7871ceb16f90', 'CWSP', 'CWCW', '65864b13-412f-4731-84a0-08440a5f408e', 16, 1, 
		'CDM-19089', now(), 'CDM-19089', now(), true, 
		'', NULL, 'Child Placement Approved', '3277146', 'Servicecase', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL
	);	

select eventcode, routingstatustypeid, remarks, activeflag, updatedby, updatedon  
	from routing 
where objectid = '65864b13-412f-4731-84a0-08440a5f408e'
	and routingid = '7417acbf-dfc2-4932-b92c-485f80a7c6d8'
	and activeflag = 1 ;
	
update routing
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-19089'		
where objectid = '65864b13-412f-4731-84a0-08440a5f408e'
	and routingid = '7417acbf-dfc2-4932-b92c-485f80a7c6d8'
	and activeflag = 1 ;
	
-- Exit CPA Homes
select entrydt, entrytm, exitdt, exittm, exittypecd, exitreasoncd, updatets, updateuserid 
	from placementcpahomes 
where placementcpahomeid = '5dd169bc-8d9c-4240-b305-bcc480cd285a'
	and activeflag = 1 ;

update placementcpahomes
set exitdt = '2021-09-30 17:00:00',
	exittm = '2021-09-30 17:00:00',
	exittypecd = 'PLCC',
	exitreasoncd = 'EMANIND',
	updatets = now(),
	updateuserid = 'CDM-19089'
where placementcpahomeid = '5dd169bc-8d9c-4240-b305-bcc480cd285a'
	and activeflag = 1 ;


-- Removal 
select removalid, removaldate, exitdate, removalexitreason, returndate, returntime, returntransts, updatedby, updatedon
	from cjams.intakeservreqchildremoval 
where removalid = 184990
	and activeflag = 1 
	and exitdate is null ;

update cjams.intakeservreqchildremoval 
set exitdate = '2021-09-30 17:00:00',
	removalexitreason = 'EMANIND',
	returntransts =  now(),
	updatedby = 'CDM-19089',
	updatedon = now()
where removalid = 184990
	and activeflag = 1	
	and exitdate is null ;	
	
-- OOH
select programkey, startdate, enddate,  updatedby, updatedon 
	from personprogramarea 
where personprogramid  = 'b995d531-755c-476a-a103-7724818d9bfd'
	and personid = '783d3bc2-22b7-472d-9c86-2c68ef2c73a5'
	and programkey = 'OOH'
	and activeflag = 1 ;
	
update personprogramarea	
set enddate = '2021-09-30 17:00:00',
	updatedby = 'CDM-19089',
	updatedon = now()
where personprogramid = 'b995d531-755c-476a-a103-7724818d9bfd'
	and personid = '783d3bc2-22b7-472d-9c86-2c68ef2c73a5'
	and programkey = 'OOH'
	and activeflag = 1 ;
	
-- IV-E Eligibility
select removal_id, client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where eligibility_id = 159650
	and delete_sw = 'N' ;

update cjams.tb_client_eligibility
set end_dt = '2021-09-30',
	update_user_id = 'CDM-19089',
	update_ts = now()
where eligibility_id = 159650
	and delete_sw = 'N' ;

