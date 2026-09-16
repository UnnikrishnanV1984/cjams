-- CDM-25438 - unvoid a placement
/*
-- Issue Description: 
   User request to revert void the below placement

-- Case ID: 3160648
-- Client ID: 1829871 (SADE M SIMONS) - d86a1208-c69c-40bc-b42b-8d66ce8a6ecf
-- Placement ID: 333209 - 2019-02-21 To 2020-02-21 (07:59 AM) - c36d2bf4-71bd-4e86-9c09-19fa72927dac
-- Private Organization: 5000668 (The Children's Choice Of Maryland, Inc.)
-- CPA Office: 5000674 (Children's Choice Baltimore)
-- Program: 222 (Treatment Foster Care)                              	

-- Category/ Module: Placements  (Case Management) 
-- Root cause: User error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to change the placement Exit date as 2021-09-20 (Voided Placement)
-- Placement Entry date changes
select alternateid, startdatetime, starttime, enddatetime, endtime,
	exitreasontypekey, exittypekey, updatedby , updatedon, 
	isvoided, voidapprovaldate, voidapprovalstatustypekey, voiddate, voidreasontypekey 
from placement 
where placementid = 'c36d2bf4-71bd-4e86-9c09-19fa72927dac'
	and activeflag = 1 ;

update placement  
set enddatetime = '2020-02-21 00:00:00', 
	endtime = '07:59',
	exitreasontypekey = NULL, 
	exittypekey = 'CIPS', 
	isvoided = 0, 
	voidapprovaldate = now(), 
	voidapprovalstatustypekey = NULL, 
	voiddate = NULL, 
	voidreasontypekey = NULL, 
	updatedon = now(), 
	updatedby = 'CDM-25438'
where placementid = 'c36d2bf4-71bd-4e86-9c09-19fa72927dac'
	and activeflag = 1 ;

-- Placement Revision
select entrydate, entrytime, exitdate, exittime, updatedby, updatedon  
	from placementrevision  
where placementid = 'c36d2bf4-71bd-4e86-9c09-19fa72927dac'
	and placementrevisionid
		in (	-- Void Request & Approved
				'2cfe6583-4484-491b-a80b-7c66d35229c8',
				'0062f246-29cf-4c9b-8ac6-db8010da1bf4'
			) ;

delete from placementrevision
where placementid = 'c36d2bf4-71bd-4e86-9c09-19fa72927dac'
	and placementrevisionid
		in (	-- Void Request & Approved
				'2cfe6583-4484-491b-a80b-7c66d35229c8',
				'0062f246-29cf-4c9b-8ac6-db8010da1bf4'
			) ;

-- Make active 
select entrydate, entrytime, exitdate, exittime, updatedby, updatedon, activeflag  
	from placementrevision  
where placementid = 'c36d2bf4-71bd-4e86-9c09-19fa72927dac'
	and placementrevisionid 
		in (	'5feb8ee2-26ca-459f-bf13-879ccf29a092',
				'49aef5bb-41ca-4670-9f7c-ecdd7c589f4c'
			) ;	
	
update placementrevision  
set activeflag = 1, 
	updatedon = now(), 
	updatedby = 'CDM-25438'
where placementid = 'c36d2bf4-71bd-4e86-9c09-19fa72927dac'
	and placementrevisionid 
		in (	'5feb8ee2-26ca-459f-bf13-879ccf29a092',
				'49aef5bb-41ca-4670-9f7c-ecdd7c589f4c'
			) ;
	
-- update exit date
select entrydate, entrytime, exitdate, exittime, updatedby, updatedon  
	from placementrevision  
where placementid = 'c36d2bf4-71bd-4e86-9c09-19fa72927dac'
	and exitdate is not null ;

update placementrevision  
set exitdate = '2020-02-21 00:00:00',
	exittime = '07:59',
	updatedon = now(), 
	updatedby = 'CDM-25438'
where placementid = 'c36d2bf4-71bd-4e86-9c09-19fa72927dac'
	and exitdate is not null ;

-- Delete Void Routing records
select activeflag, routingstatustypeid, activeflag, updatedby, updatedon, * 
from routing
where objectid = 'c36d2bf4-71bd-4e86-9c09-19fa72927dac'
	and routingid in (  'a1545de1-e684-4526-94fe-5a9c2270574f',
						'b6a57921-fdec-4a1d-afe1-7c1c3d88e582',
						'09518412-56db-4f76-a366-b859d6a275f6'
					 )
	and eventcode = 'PLTR'
order by insertedon desc ;

delete from routing
where objectid = 'c36d2bf4-71bd-4e86-9c09-19fa72927dac'
	and routingid in (  'a1545de1-e684-4526-94fe-5a9c2270574f',
						'b6a57921-fdec-4a1d-afe1-7c1c3d88e582',
						'09518412-56db-4f76-a366-b859d6a275f6'
					 )
	and eventcode = 'PLTR' ;

-- Placement Validations
select delete_sw, validation_start_dt, validation_end_dt, validation_status_cd, update_ts, update_user_id 
	from tb_placement_validation 
where placement_id = 333209
	and placement_validation_id = 934687
	and delete_sw = 'Y' ;	

update tb_placement_validation
set delete_sw = 'N',
	update_ts = now(),
	update_user_id = 'CDM-25438'
where placement_id = 333209
	and placement_validation_id = 934687
	and delete_sw = 'Y' ;	

select delete_sw, validation_start_dt, validation_end_dt, validation_status_cd, update_ts, update_user_id 
	from tb_placement_validation 
where placement_id = 333209
	and delete_sw = 'N'	
order by validation_start_dt ;

-- Update exit date for all
Update tb_placement_validation 
set validation_status_cd = '1750',
	update_ts = now(),
	update_user_id = 'CDM-25438'
where placement_id = 333209
	and delete_sw = 'N' ;

/*
-- Old data 
INSERT INTO cjams.placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status, primaryrelationship, leastrestrictiveplacement)
VALUES('2cfe6583-4484-491b-a80b-7c66d35229c8'::uuid, 'c36d2bf4-71bd-4e86-9c09-19fa72927dac'::uuid, '2022-08-31 00:00:00.000', '2019-02-21 00:00:00.000', 'Thu Jan 01 16:00:00 ', NULL, NULL, NULL, NULL, '', '3047', '2022-08-31 00:00:00.000', '1', '2022-08-31 12:37:44.852', '8c38cb86-3ca7-476e-8d52-f89c4d62be66', '2022-08-31 12:37:44.852', '8c38cb86-3ca7-476e-8d52-f89c4d62be66', 1, 1168872, 'WKER', 'Per SSA, updating to reflect correct placement for mother/baby', NULL, NULL, NULL, NULL, 1, '2022-08-31 16:37:14.753', '8c38cb86-3ca7-476e-8d52-f89c4d62be66', '2022-08-31 12:37:16.315', '8c38cb86-3ca7-476e-8d52-f89c4d62be66', '2022-08-31 12:37:44.852', NULL, NULL, NULL, NULL, 'Approved', NULL, NULL);

INSERT INTO cjams.placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status, primaryrelationship, leastrestrictiveplacement)
VALUES('0062f246-29cf-4c9b-8ac6-db8010da1bf4'::uuid, 'c36d2bf4-71bd-4e86-9c09-19fa72927dac'::uuid, '2022-08-31 00:00:00.000', '2019-02-21 00:00:00.000', 'Thu Jan 01 16:00:00 ', NULL, NULL, NULL, NULL, '', '3045', NULL, '1', '2022-08-31 12:37:16.315', '8c38cb86-3ca7-476e-8d52-f89c4d62be66', '2022-08-31 12:37:44.852', '8c38cb86-3ca7-476e-8d52-f89c4d62be66', 0, 1168871, 'WKER', 'Per SSA, updating to reflect correct placement for mother/baby', NULL, NULL, NULL, NULL, 1, '2022-08-31 16:37:14.753', '8c38cb86-3ca7-476e-8d52-f89c4d62be66', '2022-08-31 12:37:16.315', '8c38cb86-3ca7-476e-8d52-f89c4d62be66', '2022-08-31 12:37:44.852', NULL, NULL, NULL, NULL, 'Approved', NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('09518412-56db-4f76-a366-b859d6a275f6'::uuid, 'PLTR', '8c38cb86-3ca7-476e-8d52-f89c4d62be66', '4103969d-6c19-4065-8d86-fa7706680634', '7c2ad291-af40-418d-97a0-7871ceb16f90'::uuid, 'CWSP', 'CWSP', 'c36d2bf4-71bd-4e86-9c09-19fa72927dac', 15, 0, '8c38cb86-3ca7-476e-8d52-f89c4d62be66', '2022-08-31 12:37:15.396', '8c38cb86-3ca7-476e-8d52-f89c4d62be66', '2022-08-31 12:37:44.852', true, 'Void placement submitted for review', NULL, 'Void placement submitted for review', '3160648', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('a1545de1-e684-4526-94fe-5a9c2270574f'::uuid, 'PLTR', '8c38cb86-3ca7-476e-8d52-f89c4d62be66', NULL, NULL, 'CWSP', 'IVESV', 'c36d2bf4-71bd-4e86-9c09-19fa72927dac', 16, 1, '8c38cb86-3ca7-476e-8d52-f89c4d62be66', '2022-08-31 12:37:44.852', '8c38cb86-3ca7-476e-8d52-f89c4d62be66', '2022-08-31 12:37:44.852', false, NULL, NULL, NULL, '3160648', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('b6a57921-fdec-4a1d-afe1-7c1c3d88e582'::uuid, 'PLTR', '8c38cb86-3ca7-476e-8d52-f89c4d62be66', '8c38cb86-3ca7-476e-8d52-f89c4d62be66', '7c2ad291-af40-418d-97a0-7871ceb16f90'::uuid, 'CWSP', 'CWSP', 'c36d2bf4-71bd-4e86-9c09-19fa72927dac', 16, 1, '8c38cb86-3ca7-476e-8d52-f89c4d62be66', '2022-08-31 12:37:44.852', '8c38cb86-3ca7-476e-8d52-f89c4d62be66', '2022-08-31 12:37:44.852', true, '', NULL, 'Child PlacementApproved', '3160648', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/

