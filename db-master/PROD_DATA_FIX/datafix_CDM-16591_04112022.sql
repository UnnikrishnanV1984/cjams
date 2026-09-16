-- CDM-16591 - Payment to Wrong Provider
/*
-- Issue Description: 
   User request to Void the Placement and to add the correct Placement
   With provider ID: 5000364 for the Period (08/12/2020 08:00 AM 10/15/2020 12:00 PM)
   Program: 2003 - TFC ARC Northern Chesapeake Aberdeen

-- Case ID: 3257382
-- Client ID: 3821384 (STEVEN LAMAR	JOSEPH) - a2a720b0-43ae-4bde-814f-efdff0358b34
-- Void
-- Placement ID: 1557060 - 2020-08-12 08:00 To 2020-10-15 12:00 - d2bec656-bff8-4e29-a794-f19ea6db5885
-- Private Organization: 5000383 (The ARC Baltimore, Inc.)
-- CPA Office: 5000384 (The Arc Baltimore Treatment and Specialized FC)
-- Program ID: 1921 (Arc of Baltimore TFC) - 2006-12-19 To 2023-06-30
-- Placement Structure: Treatment Foster Care (Private)

-- Category/ Module: Placements  (Case Management) 
-- Root cause: User error & the Case is closed
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Case worker: ee86845e-ead2-420b-898f-66b4dd207f4e (Rhonda Gardner)
-- Supervisor Name: 47194b3d-bf52-416c-a53b-82888c49d6a2 (Tawana Nolan)
-- Team: da6e89a1-82e1-46f7-a90e-d41a3987591d


-- 1) Void Current Placement 
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
(	gen_random_uuid(), 'd2bec656-bff8-4e29-a794-f19ea6db5885', current_date, '2020-08-12 00:00:00', '08:00', 
	'2020-10-15 00:00:00', '12:00', NULL, NULL, '', 
	'3045', current_date, '1', now(), 'CDM-16591', 
	now(), 'CDM-16591', 1, nextval('sequence_placementrevision'::regclass), 'WKER', 
	'Placement void Request.', NULL, NULL, NULL, NULL, 
	1, now(), 'ee86845e-ead2-420b-898f-66b4dd207f4e', now(), '47194b3d-bf52-416c-a53b-82888c49d6a2', 
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
(	gen_random_uuid(), 'd2bec656-bff8-4e29-a794-f19ea6db5885', current_date, '2020-08-12 00:00:00', '08:00', 
	'2020-10-15 00:00:00', '12:00', NULL, NULL, '', 
	'3047', current_date, '1', now(), 'CDM-16591', 
	now(), 'CDM-16591', 1, nextval('sequence_placementrevision'::regclass), 'WKER', 
	'Placement voided.', NULL, NULL, NULL, NULL, 
	1, now(), 'ee86845e-ead2-420b-898f-66b4dd207f4e', now(), '47194b3d-bf52-416c-a53b-82888c49d6a2', 
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
	updatedby = 'CDM-16591', 
	updatedon = now()
where placementid = 'd2bec656-bff8-4e29-a794-f19ea6db5885' 
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
	(	gen_random_uuid(), 'PLTR', 'ee86845e-ead2-420b-898f-66b4dd207f4e', '47194b3d-bf52-416c-a53b-82888c49d6a2', 
		'70f4ac2b-41f6-49db-a5ba-65e5eacf6b3d', 'CWCW', 'CWSP', 'd2bec656-bff8-4e29-a794-f19ea6db5885', 15, 0, 
		'CDM-16591', now(), 'CDM-16591', now(), true, 
		'', NULL, 'Placement Void Submitted for review', '3257382', 'Servicecase', 
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
	(	gen_random_uuid(), 'PLTR', '47194b3d-bf52-416c-a53b-82888c49d6a2', 'ee86845e-ead2-420b-898f-66b4dd207f4e', 
		'70f4ac2b-41f6-49db-a5ba-65e5eacf6b3d', 'CWSP', 'CWCW', 'd2bec656-bff8-4e29-a794-f19ea6db5885', 16, 1, 
		'CDM-16591', now(), 'CDM-16591', now(), true, 
		'', NULL, 'Child Placement Void Approved', '3257382', 'Servicecase', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL
	);

-- Delete pending placement validation(s) 
select placement_id, validation_start_dt, validation_end_dt, delete_sw, update_ts, update_user_id 
	from tb_placement_validation 
where placement_id = 1557060
	and coalesce(validation_status_cd, '' ) <> '1750'
	and delete_sw  = 'N' ;

Update tb_placement_validation 
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-16591'
where placement_id = 1557060
	and coalesce(validation_status_cd, '' ) <> '1750'
	and delete_sw  = 'N' ;

-- Closed Placement - NO Vacancy updates required

-- 2) 
INSERT INTO cjams.placement
	(	placementid, providerid, intakeserviceid, intakeservicerequestactorid, startdatetime, 
		enddatetime, remarks, statustypekey, activeflag, effectivedate, 
		insertedby, insertedon, updatedby, updatedon, old_id, 
		exitreasontypekey, placementadmissionclassificationkey, placementadmissiontypekey, parentorg, addate, 
		adtime, releasedate, detainer, placementadmissionauthorizationtypekey, placementprimaryadmissionreasontypekey,
		placementprimaryapprovedalttypekey, jlocation, jcounty, fieldworker, certifiedad, 
		resourceworker, county, isprovidertyperesidential, isoperatedbydjs, lrstatus, 
		cop, istempplacement, actvwrkrfldrtypecode, actvwrkrfldridno, admissionauthcode, 
		admissioncriteriacode, detentionalternativecode, detentionalternativeindc, homecountycode, orgidno, 
		placecaseidno, placementsummarykey, placestatuscode, plcmntsmrykeyold, portedtohttmstamp, 
		releasecategorycode, releasetonametext, removalreasoncode, removaltime, servicemastercode, 
		servicetypecode, unitkey, whereaboutscode, admissiontime, emankletidno, 
		emfmdidno, eventdttmkey, eventidno, placementdate, projectedreleasedate, 
		servicemsatercode, exittypekey, isvoided, voidreasontypekey, voidremarks, 
		voiddate, intakeservreqchildremovalid, servicecaseid, placementtypekey, service_id, 
		comarrate_id, starttime, endtime, providersentdate, providerdesc, 
		responseacceptedkey, rejectreasonkey, isssaapproval, ifcapprovaldate, alternateid, 
		altproviderid, intakenumber, personid, providerorganizationid, contractprogramid, 
		facilityid, medicaidpaidflag, entrytime, otherservices, exittime, 
		overunderflag, approvalstatustypekey, placementstructureid, voidflag, exittypetypekey, 
		courtorderedflag, icpcapprovedflag, shortlistid, paymentheaderid, placementchangedate, 
		fiscalcategorytypekey, ratestructureid, conversionflag, origplacementid, datavalidflag, 
		voidapprovalstatustypekey, voidapprovaldate, tfcifcconversionflag, caseid, fk_id, 
		releasenotetext, clientmergeid, ischildplacedoutside, etl_userid, etl_load_date, 
		islapsesinplacement, typeoflapses, ischangepreadoptive, justification
	)
VALUES
	(	gen_random_uuid(), NULL, NULL, 'ff9cd260-3aff-4ca1-9993-7561d35adb90'::uuid, '2020-08-12 00:00:00.000', 
		'2020-10-15 00:00:00.000', NULL, NULL, 1, now(), 
		'CDM-16591', now(), 'CDM-16591', now(), NULL, 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, 'CIPS', 0, NULL, 	NULL, 
		NULL, '0df7ce8b-4afa-41ed-b939-4865f4e887ab'::uuid, 'fd77a9fa-f1d6-4d49-a691-80b8dbd5e28c'::uuid, 'PRPL', 78,
		NULL, '08:00', '12:00', now(), NULL, 
		'4612', NULL, 0, NULL, nextval('sequence_placement'::regclass), 
		5000365, NULL, 'a2a720b0-43ae-4bde-814f-efdff0358b34'::uuid, 5000364, 2003, 
		NULL, NULL, NULL, NULL, NULL, 
		'0', NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, now(), NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL
	) RETURNING placementid ;


INSERT INTO cjams.placementrevision
	(	placementrevisionid, placementid, 
		transactiondate, entrydate, entrytime, exitdate, exittime, 
		exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, 
		isoriginal, insertedon, insertedby, updatedon, updatedby, 
		activeflag, alternateid, voidreasontypekey, voidremarks, enddate, 
		endtime, exittypekey, remarks, isvoided, voiddate, 
		requestedby, requesteddate, approvedby, approveddate, etl_userid, 
		etl_load_date, ischangepreadoptive, justification, status
	)
VALUES
	(	gen_random_uuid(), (select placementid from placement where insertedby = 'CDM-16591') , 
		now(), '2020-08-12 00:00:00.000', '08:00', '2020-10-15 00:00:00', '12:00', 
		NULL, NULL, '', '3045', now(), 
		'1', now(), 'CDM-16591', now(), 'CDM-16591', 
		0, nextval('sequence_placementrevision'::regclass), NULL, NULL, NULL, 
		NULL, NULL, ' ', 0, NULL, 
		'ee86845e-ead2-420b-898f-66b4dd207f4e', now(), '47194b3d-bf52-416c-a53b-82888c49d6a2', now(), 
		NULL, NULL, NULL, NULL, NULL
	);


INSERT INTO cjams.placementrevision
	(	placementrevisionid, placementid, 
		transactiondate, entrydate, entrytime, exitdate, exittime, 
		exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, 
		isoriginal, insertedon, insertedby, updatedon, updatedby, 
		activeflag, alternateid, voidreasontypekey, voidremarks, enddate, 
		endtime, exittypekey, remarks, isvoided, voiddate, 
		requestedby, requesteddate, approvedby, approveddate, etl_userid, 
		etl_load_date, ischangepreadoptive, justification, status
	)
VALUES
	(	gen_random_uuid(), (select placementid from placement where insertedby = 'CDM-16591') , 
		now(), '2020-08-12 00:00:00.000', '08:00', '2020-10-15 00:00:00', '12:00', 
		NULL, NULL, '', '3047', now(), 
		'1', now(), 'CDM-16591', now(), 'CDM-16591', 
		1, nextval('sequence_placementrevision'::regclass), NULL, NULL, NULL, 
		NULL, NULL, ' ', 0, NULL, 
		'ee86845e-ead2-420b-898f-66b4dd207f4e', now(), '47194b3d-bf52-416c-a53b-82888c49d6a2', now(), 
		NULL, NULL, NULL, NULL, NULL
	);


INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, 
		tosecurityusersid, teamid, 
		fromroleid, toroleid, objectid, 
		routingstatustypeid, activeflag, insertedby, insertedon, updatedby, 
		updatedon, isreviewrequest, remarks, old_id, routeddescription, 
		servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, 
		actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes
	)
VALUES
	(	gen_random_uuid(), 'PLTR', 'ee86845e-ead2-420b-898f-66b4dd207f4e', 
		'47194b3d-bf52-416c-a53b-82888c49d6a2', '48266f52-85a6-4fcd-b1e6-f8dfacba2c93', 
		'CWCW', 'CWSP', (select placementid from placement where insertedby = 'CDM-16591'), 
		15, 0, 'CDM-16591', now(), 'CDM-16591', 
		now(), true, '', NULL, 'Provider placement submitted for review', 
		'3257382', 'Servicecase', NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL
	);

INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, 
		tosecurityusersid, teamid, 
		fromroleid, toroleid, objectid, 
		routingstatustypeid, activeflag, insertedby, insertedon, updatedby, 
		updatedon, isreviewrequest, remarks, old_id, routeddescription, 
		servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, 
		actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes
	)
VALUES
	(	gen_random_uuid(), 'PLTR', 'ee86845e-ead2-420b-898f-66b4dd207f4e', 
		NULL, NULL,
		'CWSP', 'IVESV', (select placementid from placement where insertedby = 'CDM-16591'), 
		16, 1, 'CDM-16591', now(), 'CDM-16591', 
		now(), true, '', NULL, 'Provider placement submitted for review', 
		'3257382', 'Servicecase', NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL
	);
	
INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, 
		tosecurityusersid, teamid, 
		fromroleid, toroleid, objectid, 
		routingstatustypeid, activeflag, insertedby, insertedon, updatedby, 
		updatedon, isreviewrequest, remarks, old_id, routeddescription, 
		servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, 
		actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes
	)
VALUES
	(	gen_random_uuid(), 'PLTR', 'ee86845e-ead2-420b-898f-66b4dd207f4e', 
		'48266f52-85a6-4fcd-b1e6-f8dfacba2c93', '47194b3d-bf52-416c-a53b-82888c49d6a2',
		'CWSP', 'CWCW', (select placementid from placement where insertedby = 'CDM-16591'), 
		16, 1, 'CDM-16591', now(), 'CDM-16591', 
		now(), true, '', NULL, 'Provider placement submitted for review', 
		'3257382', 'Servicecase', NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL
	);



INSERT INTO cjams.tb_placement_validation
	(	placement_validation_id, placement_id, 
		placement_entry_dt, placement_exit_dt, validation_status_cd, comment_tx, create_user_id, 
		update_user_id, delete_sw, validation_start_dt, validation_end_dt, create_ts, 
		update_ts, etl_userid, etl_load_date
	)
VALUES
	(	nextval('sq_placement_validation'::regclass), (select alternateid from placement where insertedby = 'CDM-16591') , 
		'2020-08-12', '2020-10-15', '1750', NULL, 'CDM-16591', 
		'CDM-16591', 'N', '2020-08-01', '2020-08-31', now(), 
		now(), NULL, NULL
	);

INSERT INTO cjams.tb_placement_validation
	(	placement_validation_id, placement_id, 
		placement_entry_dt, placement_exit_dt, validation_status_cd, comment_tx, create_user_id, 
		update_user_id, delete_sw, validation_start_dt, validation_end_dt, create_ts, 
		update_ts, etl_userid, etl_load_date
	)
VALUES
	(	nextval('sq_placement_validation'::regclass), (select alternateid from placement where insertedby = 'CDM-16591') , 
		'2020-08-12', '2020-10-15', '1750', NULL, 'CDM-16591', 
		'CDM-16591', 'N', '2020-09-01', '2020-09-30', now(), 
		now(), NULL, NULL
	);

INSERT INTO cjams.tb_placement_validation
	(	placement_validation_id, placement_id, 
		placement_entry_dt, placement_exit_dt, validation_status_cd, comment_tx, create_user_id, 
		update_user_id, delete_sw, validation_start_dt, validation_end_dt, create_ts, 
		update_ts, etl_userid, etl_load_date
	)
VALUES
	(	nextval('sq_placement_validation'::regclass), (select alternateid from placement where insertedby = 'CDM-16591') , 
		'2020-08-12', '2020-10-15', '1750', NULL, 'CDM-16591', 
		'CDM-16591', 'N', '2020-10-01', '2020-10-31', now(), 
		now(), NULL, NULL
	);
