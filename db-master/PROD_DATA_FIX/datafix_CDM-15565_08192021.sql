-- CDM-15565 - Create Adoption Case
/*
-- Issue Description: 
   User request is to Void Placement and re-open Removal & OOH to create Adoption Case
   
-- Case ID: 3160861
-- Client ID: 3750009 (LOGAN WISE) - 529a92cc-8210-4077-99d9-9fe0328bc24e
-- Placement ID: 318064 - 2017-03-17 To	2021-07-08 - bd1d1c2f-fccc-4542-8f58-2a3f5d76443f
-- Provider ID: 5071418	(Letetia Coley) 


-- Category/ Module: Placements  (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Void Placement 
-- Case ID: 3160861
-- Client ID: 3750009 (LOGAN WISE) - 529a92cc-8210-4077-99d9-9fe0328bc24e
-- Placement ID: 318064 - 2017-03-17 To	2021-07-08 - bd1d1c2f-fccc-4542-8f58-2a3f5d76443f
-- Provider ID: 5071418	(Letetia Coley) 

-- Case worker: Nicolas Weiner  - a6d0426b-dfc0-4401-aba4-e7916c6ee307
-- Supervisor Name: Bradley Wofford (Brad Wofford) - 27920e1e-978e-4231-a9d5-ea7323ceb413
-- Team ID of Supervisor: f8348f64-e5d4-4ee9-8cf4-2fe3627446fb

-- Placementrevision - Void 
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
(	gen_random_uuid(), 'bd1d1c2f-fccc-4542-8f58-2a3f5d76443f', current_date, '2017-03-17 00:00:00', '13:30', 
	'2021-07-08 00:00:00', '09:30', NULL, NULL, '', 
	'3045', current_date, '1', now(), 'CDM-15565', 
	now(), 'CDM-15565', 1, nextval('sequence_placementrevision'::regclass), 'WKER', 
	'Placement void Request.', NULL, NULL, NULL, NULL, 
	1, now(), 'a6d0426b-dfc0-4401-aba4-e7916c6ee307', now(), '27920e1e-978e-4231-a9d5-ea7323ceb413', 
	now(), NULL, NULL, NULL, 'Approved'
);

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
(	gen_random_uuid(), 'bd1d1c2f-fccc-4542-8f58-2a3f5d76443f', current_date, '2017-03-17 00:00:00', '13:30', 
	'2021-07-08 00:00:00', '09:30', NULL, NULL, '', 
	'3047', current_date, '1', now(), 'CDM-15565', 
	now(), 'CDM-15565', 1, nextval('sequence_placementrevision'::regclass), 'WKER', 
	'Placement voided.', NULL, NULL, NULL, NULL, 
	1, now(), 'a6d0426b-dfc0-4401-aba4-e7916c6ee307', now(), '27920e1e-978e-4231-a9d5-ea7323ceb413', 
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
	updatedby = 'CDM-15565', 
	updatedon = now()
where placementid = 'bd1d1c2f-fccc-4542-8f58-2a3f5d76443f' 
	and activeflag = 1 ;
	
-- rounting
INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, tosecurityusersid, 
		teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, isreviewrequest, 
		remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, 
		old_from_id, old_to_id, principaltype, actiondatetime, etl_userid,
		etl_load_date, entityid, reassignnotes
	)
VALUES
	(	gen_random_uuid(), 'PLTR', 'a6d0426b-dfc0-4401-aba4-e7916c6ee307', '27920e1e-978e-4231-a9d5-ea7323ceb413', 
		'f8348f64-e5d4-4ee9-8cf4-2fe3627446fb', 'CWCW', 'CWSP', 'bd1d1c2f-fccc-4542-8f58-2a3f5d76443f', 15, 0, 
		'CDM-15565', now(), 'CDM-15565', now(), true, 
		'', NULL, 'Placement Void Submitted for review', '3160861', 'Servicecase', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL
	);

INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, tosecurityusersid, 
		teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, isreviewrequest, 
		remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, 
		old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, 
		etl_load_date, entityid, reassignnotes
	)
VALUES
	(	gen_random_uuid(), 'PLTR', '27920e1e-978e-4231-a9d5-ea7323ceb413', 'a6d0426b-dfc0-4401-aba4-e7916c6ee307', 
		'f8348f64-e5d4-4ee9-8cf4-2fe3627446fb', 'CWSP', 'CWCW', 'bd1d1c2f-fccc-4542-8f58-2a3f5d76443f', 16, 1, 
		'CDM-15565', now(), 'CDM-15565', now(), true, 
		'', NULL, 'Child Placement Void Approved', '3160861', 'Servicecase', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL
	);

-- No pending placement validation

-- Closed Placement - NO Vacancy updates required

	
-- Update Removal
select removaldate, exitdate, returndate, returntime, updatedby, updatedon  
	from cjams.intakeservreqchildremoval
where removalid = 183037
	and activeflag = 1 ;
	
update cjams.intakeservreqchildremoval
set exitdate = Null,
	returndate = Null,
	returntime = Null,
	updatedby = 'CDM-15565',
	updatedon = now()
where removalid = 183037
	and activeflag = 1 ;
	
-- Update OOH
select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid = 'a4deec15-d749-454c-96b5-01151ef134ab'
	and activeflag = 1 ;


update cjams.personprogramarea 
set enddate = Null, 
	updatedby = 'CDM-15565',
	updatedon = now()
where personprogramid = 'a4deec15-d749-454c-96b5-01151ef134ab'
	and activeflag = 1 ;
		
-- Update Eligibility
select client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where eligibility_id = 158170
	and delete_sw = 'N' ;

update cjams.tb_client_eligibility
set end_dt = Null,
	update_user_id = 'CDM-15565',
	update_ts = now()
where eligibility_id = 158170
	and delete_sw = 'N' ;
