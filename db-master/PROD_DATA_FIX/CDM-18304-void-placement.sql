/*
   Issue Description: CDM-18302
   Category/ Module  :  void
   Root cause: placement void
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update tb_placement_validation set delete_sw ='Y' ,update_user_id ='CDM-18304',update_ts =now() where placement_validation_id in ('1983394','1981147','1981148','1981149','1981150');

update placement 
set isvoided = 1, 
	voidapprovaldate = current_date, 
	voidapprovalstatustypekey = '3047', 
	voiddate = current_date, 
	enddatetime = current_date,
	voidreasontypekey = 'WKER',
	updatedby = 'CDM-18304', 
	updatedon = now()
where placementid = '00cb2157-d5f6-49b2-8b9f-c3581623a535' 
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
(	gen_random_uuid(), '00cb2157-d5f6-49b2-8b9f-c3581623a535', current_date, '2021-06-14T00:00:00', '20:00', 
	NULL, NULL, NULL, NULL, '', 
	'304g', current_date, '1', now(), 'CDM-18304', 
	now(), 'CDM-18304', 1, nextval('sequence_placementrevision'::regclass), 'WKER', 
	'Placement voided.', NULL, NULL, NULL, NULL, 
	1, now(), '5a0ef493-bd37-4046-8b0e-773bd97b8612', now(), '5a0ef493-bd37-4046-8b0e-773bd97b8612', 
	now(), NULL, NULL, NULL, 'Review'
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
	(	gen_random_uuid(), 'PLTR', '5a0ef493-bd37-4046-8b0e-773bd97b8612', '0d92814e-d679-4778-b59d-036caf921998', 
		'78f8a3cf-1613-49ac-8b26-74d7276f48d0', 'CWCW', 'CWSP', '00cb2157-d5f6-49b2-8b9f-c3581623a535', 15, 0, 
		'CDM-16263', now(), 'CDM-18304', now(), true, 
		'', NULL, 'Placement Void Submitted for review', '3271616', 'Servicecase', 
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
	(	gen_random_uuid(), 'PLTR', '0d92814e-d679-4778-b59d-036caf921998', '5a0ef493-bd37-4046-8b0e-773bd97b8612', 
		'78f8a3cf-1613-49ac-8b26-74d7276f48d0', 'CWSP', 'CWCW', '00cb2157-d5f6-49b2-8b9f-c3581623a535', 16, 1, 
		'CDM-16263', now(), 'CDM-18304', now(), true, 
		'', NULL, 'Child Placement Void Approved', '3271616', 'Servicecase', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL
	);
