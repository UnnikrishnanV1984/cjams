-- CDM-13760 - Wrong placement program - payment issue
/*
-- Issue Description: 
    Please fix placement from 1/28/2021 - 2/1/2021. 
    Heard was placed in the old Arrow Diagnostic program. 
    The old program contract is closed and I am not able to fix.

-- Placement Validation ID: 1949692
-- Case ID: 3286072 - novlette.pollock@maryland.gov
-- Client ID: 2165954 (HEARD GAVEY HUGGINS) - 4c139207-b94e-4b7f-8b40-127a648ae5e9
-- * New Client Name -- 2165954	(Marcellus Xavier Torrez) - 4c139207-b94e-4b7f-8b40-127a648ae5e9
-- Placement ID: 1560828 - 01/28/2021 To 02/01/2021 - a49c5ce4-1427-4f6a-b8a3-797c3625de56
-- Private Organization: 5000485 (Arrow Child & Family Ministries of Maryland, Inc.)
-- RCC Facility: 5000486 (Arrow Child & Family - Diagnostic Center RCC)

-- Wrong Program ID: 50002320 (HI-Intensity Group Home) - 02/01/2021 To 06/30/2022
-- Correct Program ID: 50002318	(Diagnostic Evaluation Treatment Program/DETP) - 07/01/2020 to 04/30/2021
  
-- Category/ Module: Placements  (Case Management) 
-- Root cause: Currently CJAMS is not allowing the users to modify the placements on history screen.
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- 
*/

-- Void 1560828

-- Case worker: 7469b78e-6114-468a-926f-e21f72f6af1e (Lisa A Miller)
-- Supervisor Name: ee86845e-ead2-420b-898f-66b4dd207f4e (Rhonda Gardner)
-- Team: b4739538-1f7a-4a40-b885-029eaa9c6e45

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
(	gen_random_uuid(), 'a49c5ce4-1427-4f6a-b8a3-797c3625de56', current_date, '2021-01-28 00:00:00', '13:00', 
	'2021-02-01 00:00:00', '08:00', NULL, NULL, '', 
	'3045', current_date, '1', now(), 'CDM-13760', 
	now(), 'CDM-13760', 1, nextval('sequence_placementrevision'::regclass), 'WKER', 
	'Placement void Request.', NULL, NULL, NULL, NULL, 
	1, now(), '7469b78e-6114-468a-926f-e21f72f6af1e', now(), '7469b78e-6114-468a-926f-e21f72f6af1e', 
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
(	gen_random_uuid(), 'a49c5ce4-1427-4f6a-b8a3-797c3625de56', current_date, '2021-01-28 00:00:00', '13:00', 
	'2021-02-01 00:00:00', '08:00', NULL, NULL, '', 
	'3047', current_date, '1', now(), 'CDM-13760', 
	now(), 'CDM-13760', 1, nextval('sequence_placementrevision'::regclass), 'WKER', 
	'Placement voided.', NULL, NULL, NULL, NULL, 
	1, now(), '7469b78e-6114-468a-926f-e21f72f6af1e', now(), '7469b78e-6114-468a-926f-e21f72f6af1e', 
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
	updatedby = 'CDM-13760', 
	updatedon = now()
where placementid = 'a49c5ce4-1427-4f6a-b8a3-797c3625de56' 
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
	(	gen_random_uuid(), 'PLTR', '7469b78e-6114-468a-926f-e21f72f6af1e', 'ee86845e-ead2-420b-898f-66b4dd207f4e', 
		'b4739538-1f7a-4a40-b885-029eaa9c6e45', 'CWCW', 'CWSP', 'a49c5ce4-1427-4f6a-b8a3-797c3625de56', 15, 0, 
		'CDM-13760', now(), 'CDM-13760', now(), true, 
		'', NULL, 'Placement Void Submitted for review', '3286072', 'Servicecase', 
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
	(	gen_random_uuid(), 'PLTR', 'ee86845e-ead2-420b-898f-66b4dd207f4e', '7469b78e-6114-468a-926f-e21f72f6af1e', 
		'b4739538-1f7a-4a40-b885-029eaa9c6e45', 'CWSP', 'CWCW', 'a49c5ce4-1427-4f6a-b8a3-797c3625de56', 16, 1, 
		'CDM-13760', now(), 'CDM-13760', now(), true, 
		'', NULL, 'Child Placement Void Approved', '3286072', 'Servicecase', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL
	);

-- Delete placement validations 
select placement_validation_id, validation_status_cd, delete_sw, update_ts, update_user_id 
	from tb_placement_validation 
where placement_id = 1560828
	and delete_sw  = 'N'
	and coalesce(validation_status_cd, 'N') <> '1750' ;

update tb_placement_validation
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-13760'
where placement_id = 1560828
	and delete_sw  = 'N'
	and coalesce(validation_status_cd, 'N') <> '1750' ;

-- Closed Placement - NO Vacancy updates required

-------------

/*
-- Temp soft delete
-- 695fdf02-d5b4-409e-a71e-33e48a448432	1563107	2021-02-01 00:00:00	2021-04-23 00:00:00
-- b2c1b9b8-dea2-41b0-bdf3-4c7377bdb6fb	1563109	2021-04-23 00:00:00	

select alternateid, startdatetime, starttime, enddatetime, enddatetime, 
	exitreasontypekey, exittypekey, updatedby , updatedon, activeflag 
from cjams.placement 
where placementid in ( '695fdf02-d5b4-409e-a71e-33e48a448432',
						'b2c1b9b8-dea2-41b0-bdf3-4c7377bdb6fb'
					)	
	and activeflag  = 1 ;

update cjams.placement 
	set activeflag = 0
where placementid in ( '695fdf02-d5b4-409e-a71e-33e48a448432',
						'b2c1b9b8-dea2-41b0-bdf3-4c7377bdb6fb'
					)	
	and activeflag  = 1 ;
*/
	
/*
-- To revert 
update cjams.placement 
	set activeflag = 1
where placementid in ( '695fdf02-d5b4-409e-a71e-33e48a448432',
						'b2c1b9b8-dea2-41b0-bdf3-4c7377bdb6fb'
					)	
	and activeflag = 0 ;

*/
