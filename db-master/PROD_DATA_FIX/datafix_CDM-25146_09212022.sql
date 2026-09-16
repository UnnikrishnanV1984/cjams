-- CDM-25146 - VOID ERROR
/*
-- Issue Description: 
   User request to revert void the below placement

-- Case ID: 3160648
-- Client ID: 1829871 (SADE M SIMONS) - d86a1208-c69c-40bc-b42b-8d66ce8a6ecf
-- Placement ID: 1561557 - 2020-02-21 To 2021-07-01 00:07:59 - 96ca7cef-3204-4dee-bd2b-c32f82bd5b78
-- Private Organization: 5000668 (The Children's Choice Of Maryland, Inc.)
-- CPA Office: 5000718 (Childrens Choice Salisbury)
-- Program: 15723 - TMP - CHILDRENS CHOICE	

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
where placementid = '96ca7cef-3204-4dee-bd2b-c32f82bd5b78'
	and activeflag = 1 ;

update placement  
set enddatetime = '2021-07-01 00:00:00', 
	endtime = '07:59',
	exitreasontypekey = NULL, 
	exittypekey = 'CIPS', 
	isvoided = 0, 
	voidapprovaldate = now(), 
	voidapprovalstatustypekey = NULL, 
	voiddate = NULL, 
	voidreasontypekey = NULL, 
	updatedon = now(), 
	updatedby = 'CDM-25146'
where placementid = '96ca7cef-3204-4dee-bd2b-c32f82bd5b78'
	and activeflag = 1 ;

-- Placement Revision
select entrydate, entrytime, exitdate, exittime, updatedby, updatedon  
	from placementrevision  
where placementid = '96ca7cef-3204-4dee-bd2b-c32f82bd5b78'
	and placementrevisionid
		in (	-- Void Request & Approved
				'3796304d-9457-4549-ae97-28a128ffaa7f',
				'31744e7a-32a7-4ad3-b7b3-dcefe71605b6'
			) ;

delete from placementrevision
where placementid = '96ca7cef-3204-4dee-bd2b-c32f82bd5b78'
	and placementrevisionid
		in (	-- Void Request & Approved
				'3796304d-9457-4549-ae97-28a128ffaa7f',
				'31744e7a-32a7-4ad3-b7b3-dcefe71605b6'
			) ;

-- Make active 
select entrydate, entrytime, exitdate, exittime, updatedby, updatedon, activeflag  
	from placementrevision  
where placementid = '96ca7cef-3204-4dee-bd2b-c32f82bd5b78'
	and placementrevisionid = '75cceee3-0aaf-4f89-83fe-56035e25c142' ;
	
update placementrevision  
set activeflag = 1, 
	updatedon = now(), 
	updatedby = 'CDM-25146'
where placementid = '96ca7cef-3204-4dee-bd2b-c32f82bd5b78'
	and placementrevisionid = '75cceee3-0aaf-4f89-83fe-56035e25c142' ;
	
-- update exit date
select entrydate, entrytime, exitdate, exittime, updatedby, updatedon  
	from placementrevision  
where placementid = '96ca7cef-3204-4dee-bd2b-c32f82bd5b78'
	and exitdate is not null ;

update placementrevision  
set exitdate = '2021-07-01 00:00:00',
	exittime = '07:59',
	updatedon = now(), 
	updatedby = 'CDM-25146'
where placementid = '96ca7cef-3204-4dee-bd2b-c32f82bd5b78'
	and exitdate is not null ;

-- Delete Void Routing records
select activeflag, routingstatustypeid, activeflag, updatedby, updatedon, * 
from routing
where objectid = '96ca7cef-3204-4dee-bd2b-c32f82bd5b78'
	and routingid in (  '782038ec-fc2f-437b-8f0b-d69b4e608b19',
						'7477c265-3016-4219-b67f-7cfebd522e04',
						'de8a1451-bf58-44ab-b6dd-f8465dcb07fe'
					 )
	and eventcode = 'PLTR'
order by insertedon desc ;

delete from routing
where objectid = '96ca7cef-3204-4dee-bd2b-c32f82bd5b78'
	and routingid in (  '782038ec-fc2f-437b-8f0b-d69b4e608b19',
						'7477c265-3016-4219-b67f-7cfebd522e04',
						'de8a1451-bf58-44ab-b6dd-f8465dcb07fe'
					 )

	and eventcode = 'PLTR' ;

-- Placement Validations
select delete_sw, validation_start_dt, validation_end_dt, validation_status_cd, update_ts, update_user_id 
	from tb_placement_validation 
where placement_id = 1561557
	and delete_sw = 'N'	
order by validation_start_dt ;

-- Update exit date for all
Update tb_placement_validation 
set validation_status_cd = '1750',
	update_ts = now(),
	update_user_id = 'CDM-25146'
where placement_id = 1561557
	and delete_sw = 'N' ;

/*
-- Old data 
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('782038ec-fc2f-437b-8f0b-d69b4e608b19'::uuid, 'PLTR', '8c38cb86-3ca7-476e-8d52-f89c4d62be66', NULL, NULL, 'CWSP', 'IVESV', '96ca7cef-3204-4dee-bd2b-c32f82bd5b78', 16, 1, '8c38cb86-3ca7-476e-8d52-f89c4d62be66', '2022-08-31 12:36:25.398', '8c38cb86-3ca7-476e-8d52-f89c4d62be66', '2022-08-31 12:36:25.398', false, NULL, NULL, NULL, '3160648', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('7477c265-3016-4219-b67f-7cfebd522e04'::uuid, 'PLTR', '8c38cb86-3ca7-476e-8d52-f89c4d62be66', '8c38cb86-3ca7-476e-8d52-f89c4d62be66', '7c2ad291-af40-418d-97a0-7871ceb16f90'::uuid, 'CWSP', 'CWSP', '96ca7cef-3204-4dee-bd2b-c32f82bd5b78', 16, 1, '8c38cb86-3ca7-476e-8d52-f89c4d62be66', '2022-08-31 12:36:25.398', '8c38cb86-3ca7-476e-8d52-f89c4d62be66', '2022-08-31 12:36:25.398', true, '', NULL, 'Child PlacementApproved', '3160648', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('de8a1451-bf58-44ab-b6dd-f8465dcb07fe'::uuid, 'PLTR', '8c38cb86-3ca7-476e-8d52-f89c4d62be66', '4103969d-6c19-4065-8d86-fa7706680634', '7c2ad291-af40-418d-97a0-7871ceb16f90'::uuid, 'CWSP', 'CWSP', '96ca7cef-3204-4dee-bd2b-c32f82bd5b78', 15, 0, '8c38cb86-3ca7-476e-8d52-f89c4d62be66', '2022-08-31 12:31:41.987', '8c38cb86-3ca7-476e-8d52-f89c4d62be66', '2022-08-31 12:36:25.398', true, 'Void placement submitted for review', NULL, 'Void placement submitted for review', '3160648', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/

