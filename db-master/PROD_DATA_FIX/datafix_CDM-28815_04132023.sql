-- CDM-28815 - End date erroneous open placement
/*
-- Issue Description: 
   User Request to Void the CHESSIE Migrated Duplicate Overlapping Placement

-- Case ID: 3298847	
-- Client ID: 4365738 (VALERIA BAQUEDANO ROMERO) - f4a124a1-72e6-49eb-b93d-1c2f2b6ef100
-- Provider ID: 5065564	(Monica Mendoza Flores)

-- Placements 
-- 336101	5065564	2019-08-05 To Current b1c9f4cc-a614-43fa-bfcd-ae3a1f999c67
-- Regular Foster Care (NO Payments)
 	
-- Category/ Module: Placements  (Case Management) 
-- Root cause: Duplicate Overlapping Placement was migrated from MD CHESSIE.
-- Fix Provided: Datafix has been promoted to void this Duplicate Overlapping Placement
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Case worker: a28308ae-8989-4f66-b47c-f26db59c1118	michelle.forney@montgomerycountymd.gov
-- Supervisor Name: a7e7f7b4-9a64-4223-970a-dd552710dcb1	laura.erstling@montgomerycountymd.gov
-- Team ID of Supervisor: 9f1d3b42-f3c6-4ed4-bbf3-93df85ff4bd0 - LDSS Management #1


-- Placementrevision - Void 
-- update activefalg = 0
select entrydate, entrytime,  exitdate, exittime, exitreasontypkey, exittypekey, updatedby , updatedon  
	from cjams.placementrevision  
where placementrevisionid  = 'a06a71a4-d7db-4f22-a346-6794450ad00c' ;

update cjams.placementrevision  
set activeflag = 0, 
	approvaldate = current_date, 
	updatedon = now(), 
	updatedby = 'CDM-28815'
where placementrevisionid = 'a06a71a4-d7db-4f22-a346-6794450ad00c' ;

-- Hard Delete
select entrydate, entrytime,  exitdate, exittime, exitreasontypkey, exittypekey, updatedby , updatedon  
	from cjams.placementrevision  
where placementrevisionid  = '34d8fdde-991f-4c0b-b4e2-660f7f3a7e62' ;

Delete from cjams.placementrevision where placementrevisionid  = '34d8fdde-991f-4c0b-b4e2-660f7f3a7e62' ;

/*
-- To Revert if Needed
INSERT INTO cjams.placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status, primaryrelationship, leastrestrictiveplacement, transferagency, otherpublicagency)
VALUES('34d8fdde-991f-4c0b-b4e2-660f7f3a7e62'::uuid, 'b1c9f4cc-a614-43fa-bfcd-ae3a1f999c67'::uuid, '2023-03-01 00:00:00.000', NULL, NULL, NULL, NULL, NULL, NULL, '', '3045', '2023-03-01 00:00:00.000', '1', '2023-03-01 13:15:13.297', 'b3b22c73-2132-4a64-bfff-7f353dea75a1', '2023-03-01 13:15:13.297', 'b3b22c73-2132-4a64-bfff-7f353dea75a1', 0, 1276300, 'CP', 'Duplicate placement added from CHESSIE to CJAMS migration. Per MDTHINK, CJAMS Contact Support Ticket S2023047048114: While analyzing we found both the placements are migrated as active placements in CJAMS from MD CHESSIE. The good part is there are no duplicate payments, all the payments starting April 2019 are tied to the Emergency Foster Home Care Placement. ', NULL, NULL, NULL, NULL, 1, '2023-03-01 18:15:12.689', 'b3b22c73-2132-4a64-bfff-7f353dea75a1', '2023-03-01 13:15:13.297', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'n/a', NULL, NULL);
*/

-- Add Void Apporval
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
(	gen_random_uuid(), 'b1c9f4cc-a614-43fa-bfcd-ae3a1f999c67', current_date, NULL, 
	NULL, NULL, NULL, NULL, NULL, '', 
	'3047', current_date, '1', now(), 'CDM-28815', 
	now(), 'CDM-28815', 1, nextval('sequence_placementrevision'::regclass), 'WKER', 
	'Placement voided.', NULL, NULL, NULL, NULL, 
	1, now(), 'a7e7f7b4-9a64-4223-970a-dd552710dcb1', now(), 'a28308ae-8989-4f66-b47c-f26db59c1118', 
	now(), NULL, NULL, NULL, 'Approved'
);

-- placement update
update placement 
set isvoided = 1, 
	voidapprovaldate = current_date, 
	voidapprovalstatustypekey = '3047', 
	voiddate = current_date, 
	enddatetime = current_date,
	voidreasontypekey = 'WKER',
	updatedby = 'CDM-28815', 
	updatedon = now()
where placementid = 'b1c9f4cc-a614-43fa-bfcd-ae3a1f999c67' 
	and activeflag = 1 ;
	
-- rounting
select eventcode, routingstatustypeid, updatedby , updatedon , activeflag
	from routing 
where objectid = 'b1c9f4cc-a614-43fa-bfcd-ae3a1f999c67'
	and routingid  = '3ce0e7e9-bce9-4c82-b5e3-2b5f4ce16c91' ;

update routing
set routingstatustypeid = 16,
	updatedon = now(), 
	updatedby = 'CDM-28815'
where objectid = 'b1c9f4cc-a614-43fa-bfcd-ae3a1f999c67'
	and routingid  = '3ce0e7e9-bce9-4c82-b5e3-2b5f4ce16c91' ;
	
-- No pending placement validation

-- Un-Apporved Placement - NO Vacancy updates required
