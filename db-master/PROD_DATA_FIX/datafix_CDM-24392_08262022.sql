-- CDM-24392 - Validation need
/*
-- Issue Description: 
	Youth remained in care beyond 21 due to extended foster care. 
	User request to end date the placement as of 09/30/2021
    Exception scenario: Youth is 21 and was allowed to remain in care beyond 21 due to Pandemic.

-- Case ID: 3114662
-- Client ID: 1495011 (CAPREE L JONES) - a753c5d1-bea9-45de-88dc-03b0fd1612cd
-- Placement ID: 323926 - 2018-01-12 To Current - bc115245-478b-4eb1-9354-fc93765f59d0
-- Private Organization: 5001294 (King Edwards' Inc.)
-- CPA Office: 5001424 (King Edwards' Inc. ILP)
-- Program ID: 1274	(Ind Liv Pgm King Edwards House, Inc.) 
-- Placement Structure: Independent Living Residential Program   
 
-- Category/ Module: Placements  (Case Management) 
-- Root cause: As per the business rules Independent Living Residential Program is allowed for 16 to 21 only 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Placement Exit 
select alternateid, startdatetime, starttime, enddatetime, endtime,
	exitreasontypekey, exittypekey, updatedby , updatedon 
from placement 
where placementid = 'bc115245-478b-4eb1-9354-fc93765f59d0'
	and activeflag  = 1 ;

update placement  
set enddatetime = '2021-09-30 00:00:00', 
	endtime = '17:00',
	exitreasontypekey = 'PLCCE',
	exittypekey = 'PLCC',
	updatedon = now(), 
	updatedby = 'CDM-24392'
where placementid = 'bc115245-478b-4eb1-9354-fc93765f59d0'
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
(	gen_random_uuid(), 'bc115245-478b-4eb1-9354-fc93765f59d0', current_date, '2018-01-12 00:00:00', '15:00', 
	'2021-09-30 00:00:00', '17:00', NULL, 'PLCCE', '', 
	'3047', current_date, NULL, now(), 'CDM-24392', 
	now(), 'CDM-24392', 1, nextval('sequence_placementrevision'::regclass), NULL, 
	NULL, NULL, NULL, 'PLCC', NULL, 
	0, now(), '45391f16-58de-4b24-bd7e-12cdc4ff4335', now(), 'd636ac2f-53ff-43e0-adbf-35c97e0427ec', 
	now(), NULL, NULL, NULL, 'Approved'
);
	
select approvalstatustypkey, status, activeflag, updatedby, updatedon	
	from placementrevision 
where placementid  = 'bc115245-478b-4eb1-9354-fc93765f59d0'
	and placementrevisionid = '98515e3a-b7f3-4d82-90eb-5a14fe674d43' 
	and activeflag = 1;

update placementrevision
set activeflag = 0,
	status =  'Approved',
	approvedby = 'd636ac2f-53ff-43e0-adbf-35c97e0427ec',
	approveddate = now(),
	updatedon = now(), 
	updatedby = 'CDM-24392'	
where placementid  = 'bc115245-478b-4eb1-9354-fc93765f59d0'
	and placementrevisionid = '98515e3a-b7f3-4d82-90eb-5a14fe674d43' 
	and activeflag = 1;

-- Delete Rejected record
delete from placementrevision 
where placementrevisionid  
	in (	'e346d70d-c292-4f87-b633-b5ee28d4dcc8',
			'7f5510b7-ce11-4f6d-bc93-52c8936e4fc1',
			'7c771fb4-8558-4da6-8962-d8770a975214' 
		) ;

/*
INSERT INTO cjams.placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status, primaryrelationship)
VALUES('7c771fb4-8558-4da6-8962-d8770a975214'::uuid, 'bc115245-478b-4eb1-9354-fc93765f59d0'::uuid, '2022-08-24 00:00:00.000', '2018-01-12 00:00:00.000', 'Thu Jan 01 15:00:00 ', '2021-09-30 00:00:00.000', '17:00', NULL, 'PLCCE', '', '3045', '2022-08-24 00:00:00.000', '1', '2022-08-11 12:43:18.351', 'd636ac2f-53ff-43e0-adbf-35c97e0427ec', '2022-08-24 17:10:09.501', 'd636ac2f-53ff-43e0-adbf-35c97e0427ec', 0, 1165884, NULL, NULL, NULL, NULL, 'PLCC', NULL, 0, NULL, 'd636ac2f-53ff-43e0-adbf-35c97e0427ec', '2022-08-11 12:43:18.351', 'd636ac2f-53ff-43e0-adbf-35c97e0427ec', '2022-08-11 12:45:00.341', NULL, NULL, NULL, NULL, 'Rejected', NULL);

INSERT INTO cjams.placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status, primaryrelationship)
VALUES('7f5510b7-ce11-4f6d-bc93-52c8936e4fc1'::uuid, 'bc115245-478b-4eb1-9354-fc93765f59d0'::uuid, '2022-08-24 00:00:00.000', '2018-01-12 00:00:00.000', 'Thu Jan 01 15:00:00 ', '2021-09-30 00:00:00.000', '17:00', NULL, 'PLCCE', '', '3281', '2022-08-24 00:00:00.000', '1', '2022-08-11 12:45:00.341', 'd636ac2f-53ff-43e0-adbf-35c97e0427ec', '2022-08-24 17:10:09.501', 'd636ac2f-53ff-43e0-adbf-35c97e0427ec', 0, 1165885, NULL, NULL, NULL, NULL, 'PLCC', NULL, 0, NULL, 'd636ac2f-53ff-43e0-adbf-35c97e0427ec', '2022-08-11 12:43:18.351', 'd636ac2f-53ff-43e0-adbf-35c97e0427ec', '2022-08-11 12:45:00.341', NULL, NULL, NULL, NULL, 'Rejected', NULL);

INSERT INTO cjams.placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status, primaryrelationship)
VALUES('e346d70d-c292-4f87-b633-b5ee28d4dcc8'::uuid, 'bc115245-478b-4eb1-9354-fc93765f59d0'::uuid, '2022-08-24 00:00:00.000', '2018-01-12 00:00:00.000', 'Thu Jan 01 15:00:00 ', '2021-09-30 00:00:00.000', '17:00', NULL, 'PLCCE', '', '3281', '2022-08-24 00:00:00.000', '1', '2022-08-24 17:10:09.501', 'd636ac2f-53ff-43e0-adbf-35c97e0427ec', '2022-08-26 09:16:16.931', 'CDM-24392', 0, 1167880, NULL, NULL, NULL, NULL, 'PLCC', NULL, 0, NULL, '45391f16-58de-4b24-bd7e-12cdc4ff4335', '2022-08-24 12:03:08.701', 'd636ac2f-53ff-43e0-adbf-35c97e0427ec', '2022-08-24 17:10:09.501', NULL, NULL, NULL, NULL, 'Rejected', NULL);
*/

-- Update routing
-- Delete Rejected 
select eventcode, routingstatustypeid, activeflag, updatedby, updatedon 
from cjams.routing
where routingid = '5d024dbe-e419-403e-ba60-809dcce416ac'
	and activeflag = 1 ;

update cjams.routing
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-24392'		
where routingid = '5d024dbe-e419-403e-ba60-809dcce416ac'
	and activeflag = 1 ;


INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, tosecurityusersid, 
		teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, isreviewrequest, 
		remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, 
		old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, 
		etl_load_date, entityid, reassignnotes
	)
VALUES
	(	gen_random_uuid(), 'PLTR', 'd636ac2f-53ff-43e0-adbf-35c97e0427ec', '45391f16-58de-4b24-bd7e-12cdc4ff4335', 
		'6629c2a6-9d4d-4d3f-b6c2-0d842f161cc6', 'CWSP', 'CWCW', 'bc115245-478b-4eb1-9354-fc93765f59d0', 16, 1, 
		'CDM-24392', now(), 'CDM-24392', now(), true, 
		'', NULL, 'Child Placement Approved', '3114662', 'Servicecase', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL
	);	

/*
select eventcode, routingstatustypeid, remarks, activeflag, updatedby, updatedon  
	from routing 
where objectid = 'bc115245-478b-4eb1-9354-fc93765f59d0'
	and routingid = '7604c961-e8a1-49c9-9157-81a13b63ca60'
	and activeflag = 1 ;
	
update routing
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-24392'		
where objectid = 'bc115245-478b-4eb1-9354-fc93765f59d0'
	and routingid = '7604c961-e8a1-49c9-9157-81a13b63ca60'
	and activeflag = 1 ;
*/
	
-- Exit CPA Home
select entrydt, entrytm, exitdt, exittm, exittypecd, exitreasoncd, updatets, updateuserid 
	from placementcpahomes 
where placementid = 'bc115245-478b-4eb1-9354-fc93765f59d0'
	and placementcpahomeid = '7ad389bc-0569-41b5-a3e2-195fec1f9ac8'
	and activeflag = 1 ;

update placementcpahomes
set exitdt = '2021-09-30 00:00:00',
	exittm = '2021-09-30 17:00:00',
	exittypecd = 'PLCC',
	exitreasoncd = 'PLCCE',
	updatets = now(),
	updateuserid = 'CDM-24392'
where placementid = 'bc115245-478b-4eb1-9354-fc93765f59d0'
	and placementcpahomeid = '7ad389bc-0569-41b5-a3e2-195fec1f9ac8'
	and activeflag = 1 ;	

--  NO Pending Placement Validations