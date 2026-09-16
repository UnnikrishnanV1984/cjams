/*
   Issue Description: CDM-19042
   Category/ Module : Wrong program paid
   Root cause: user requeseted to update and delete 2 different records
   Pull request# for code fix: 
   Explanantion: user wants to update program start date and delete data for other record
*/


-- Change start date 07/15/2021 to 03/01/2021

select alternateid, startdatetime, starttime, enddatetime, endtime,
	exitreasontypekey, exittypekey, updatedby , updatedon 
from cjams.placement 
where placementid ='180200ae-ba0b-4e40-a61e-66d178770863'
	and activeflag  = 1 ;

update cjams.placement  
set startdatetime = '2021-03-01 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-19042'
where placementid = '180200ae-ba0b-4e40-a61e-66d178770863'
	and activeflag = 1 ;

select entrydate, entrytime, updatedby , updatedon, *
	from cjams.placementrevision  
where placementid = '180200ae-ba0b-4e40-a61e-66d178770863' ;

update cjams.placementrevision  
set entrydate = '2021-03-01 00:00:00', 
	updatedon = now(), 
	updatedby =  'CDM-19042'
where placementid = '180200ae-ba0b-4e40-a61e-66d178770863' ;


select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from cjams.tb_placement_validation 
where placement_id = 1565274
	and delete_sw = 'N' ;

Update cjams.tb_placement_validation 
set placement_entry_dt = '2021-03-01'::date,
	update_ts = now(),
	update_user_id = 'CDM-19042'
where placement_id = 1565274
	and delete_sw = 'N';

	insert into tb_placement_validation
	(	placement_validation_id, placement_id, placement_entry_dt, placement_exit_dt, validation_status_cd, 
		comment_tx, create_user_id, update_user_id, delete_sw, validation_start_dt, 
		validation_end_dt, create_ts, update_ts, etl_userid, etl_load_date
	)
values
	(	nextval('sq_placement_validation'::regclass), 1565274, '2021-03-01', NULL, NULL, 
		NULL, 'CDM-19042', 'CDM-19042', 'N',
		'2021-03-01', '2021-03-31', 
		now(), now(), NULL, NULL
	),
(	nextval('sq_placement_validation'::regclass), 1565274, '2021-03-01', NULL, NULL, 
		NULL, 'CDM-19042', 'CDM-19042', 'N',
		'2021-04-01', '2021-04-30', 
		now(), now(), NULL, NULL
	),
(	nextval('sq_placement_validation'::regclass), 1565274, '2021-03-01', NULL, NULL, 
		NULL, 'CDM-19042', 'CDM-19042', 'N',
		'2021-05-01', '2021-05-31', 
		now(), now(), NULL, NULL
	),
(	nextval('sq_placement_validation'::regclass), 1565274, '2021-03-01', NULL, NULL, 
		NULL, 'CDM-19042', 'CDM-19042', 'N',
		'2021-06-01', '2021-06-30', 
		now(), now(), NULL, NULL
	);


-- delete record from placement history
-- 03/01/2021- 07/15/2021 record needs to be removed 

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
(	gen_random_uuid(), 'f4962f6b-d5ba-47e6-9c46-83250020d1a7', current_date, '2021-03-01 00:00:00', '08:00', 
	'2021-07-15 00:00:00', '00:00', NULL, NULL, '', 
	'3045', current_date, '1', now(), 'CDM-19042', 
	now(), 'CDM-19042', 1, nextval('sequence_placementrevision'::regclass), 'WKER', 
	'Placement void Request.', NULL, NULL, NULL, NULL, 
	1, now(), '519c4989-29f9-46c3-91be-791c41d4c18b', now(), 'ba2dbc8f-3213-4b1b-9905-d643e1692db1', 
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
(	gen_random_uuid(), 'f4962f6b-d5ba-47e6-9c46-83250020d1a7', current_date, '2021-03-01 00:00:00', '08:00', 
	'2021-07-15 00:00:00', '00:00', NULL, NULL, '', 
	'3047', current_date, '1', now(), 'CDM-19042', 
	now(), 'CDM-19042', 1, nextval('sequence_placementrevision'::regclass), 'WKER', 
	'Placement voided.', NULL, NULL, NULL, NULL, 
	1, now(), 'ba2dbc8f-3213-4b1b-9905-d643e1692db1', now(), '519c4989-29f9-46c3-91be-791c41d4c18b',
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
	updatedby = 'CDM-19042', 
	updatedon = now()
where placementid = 'f4962f6b-d5ba-47e6-9c46-83250020d1a7' 
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
	(	gen_random_uuid(), 'PLTR', '519c4989-29f9-46c3-91be-791c41d4c18b', 'd2757853-26b7-4656-9189-c890ef76cbcb', 
		'70c5f926-488c-44ec-a363-29ab1c8bf749', 'CWCW', 'CWSP', 'f4962f6b-d5ba-47e6-9c46-83250020d1a7', 15, 0, 
		'CDM-19042', now(), 'CDM-19042', now(), true, 
		'', NULL, 'Placement Void Submitted for review', '3108856', 'Servicecase', 
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
	(	gen_random_uuid(), 'PLTR', 'd2757853-26b7-4656-9189-c890ef76cbcb', '519c4989-29f9-46c3-91be-791c41d4c18b', 
		'70c5f926-488c-44ec-a363-29ab1c8bf749', 'CWSP', 'CWCW', 'f4962f6b-d5ba-47e6-9c46-83250020d1a73', 16, 1, 
		'CDM-19042', now(), 'CDM-19042', now(), true, 
		'', NULL, 'Child Placement Void Approved', '3108856', 'Servicecase', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL
	);
