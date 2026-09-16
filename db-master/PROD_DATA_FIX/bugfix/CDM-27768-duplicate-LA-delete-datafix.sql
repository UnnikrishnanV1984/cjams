-- CDM-27768 -  Delete duplicate living arrangments
/*
-- Issue Description: 
   User requested to delete duplicate living arrangements
   
-- Case ID: 3263244
-- Client Name : McKenzie Isenhour CJAMS PID# : 200929516 
-- 		Placement ID: 1579411 - 1a597566-36fb-4d16-9a6e-1dbe98060811
-- Client Name : Jaxon Isenhour CJAMS PID# : 200929514
--		Placement ID: 1579413 - 39a7470a-253c-4dc6-a443-50402792bdd5
--		Placement ID: 1579414 - b54f9422-6f5f-4d20-b167-372d975b889d
--		Placement ID: 1579412 - 15ee025c-26de-4bc0-9b5d-8422ad4977ca

-- Category/ Module: Placements  (Case Management) 
-- Root cause: User Request
-- Pull request# TBD
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

--Client Name : Jaxon Isenhour CJAMS PID# : 200929514
select 	activeflag, * from placement
where 	activeflag = 1 and placementid in ('39a7470a-253c-4dc6-a443-50402792bdd5', --1579413
		'b54f9422-6f5f-4d20-b167-372d975b889d', --1579414
		'15ee025c-26de-4bc0-9b5d-8422ad4977ca' );--1579412

update 	placement
set 	activeflag = 0,
		updatedby = 'CDM-27768',
		updatedon = now()
where 	activeflag = 1 and placementid in ('39a7470a-253c-4dc6-a443-50402792bdd5', --1579413
		'b54f9422-6f5f-4d20-b167-372d975b889d', --1579414
		'15ee025c-26de-4bc0-9b5d-8422ad4977ca' );	--1579412
		
select 	activeflag, * from placementrevision 
where 	activeflag = 1 and placementid in ('39a7470a-253c-4dc6-a443-50402792bdd5', 'b54f9422-6f5f-4d20-b167-372d975b889d', '15ee025c-26de-4bc0-9b5d-8422ad4977ca');

update 	placementrevision
set 	activeflag = 0,
		updatedby = 'CDM-27768',
		updatedon = now()
where 	activeflag = 1 and placementid in ('39a7470a-253c-4dc6-a443-50402792bdd5', 'b54f9422-6f5f-4d20-b167-372d975b889d','15ee025c-26de-4bc0-9b5d-8422ad4977ca' );	
		
-- Placement Validation - Dont exist for LA
--select 	placement_id, placement_entry_dt , placement_exit_dt, validation_start_dt, validation_end_dt, 
--		validation_status_cd, update_ts, update_user_id, delete_sw 
--from 	cjams.tb_placement_validation 
--where 	placement_id  in(1579413, 1579414, 1579412)  and delete_sw = 'N' ;

--update Person Program area with valid enddate : from 2022-11-17 to 2022-11-16
select * from personprogramarea
where personid = (select personid from person where cjamspid = '200929514');

update 	personprogramarea
set 	enddate = '2022-11-16',
		updatedby = 'CDM-27768',
		updatedon = now()
where 	personprogramid = '3e38d343-e1d6-41ae-8cfc-b4d420e08076' and activeflag = 1;

--Client Name : McKenzie Isenhour CJAMS PID# : 200929516
select 	activeflag,  * from placement
where 	placementid in ('1a597566-36fb-4d16-9a6e-1dbe98060811'); --1579411

update 	placement
set 	activeflag = 0,
		updatedby = 'CDM-27768',
		updatedon = now()
where 	activeflag = 1 and  placementid = '1a597566-36fb-4d16-9a6e-1dbe98060811';

select 	activeflag, * from placementrevision 
where 	placementid in ('1a597566-36fb-4d16-9a6e-1dbe98060811');

update 	placementrevision
set 	activeflag = 0,
		updatedby = 'CDM-27768',
		updatedon = now()
where 	activeflag = 1 and  placementid = '1a597566-36fb-4d16-9a6e-1dbe98060811';

-- Placement Validation - Dont exist for LA
--select 	placement_id, placement_entry_dt , placement_exit_dt, validation_start_dt, validation_end_dt, 
--		validation_status_cd, update_ts, update_user_id, delete_sw 
--from 	cjams.tb_placement_validation 
--where 	placement_id  = 1579411 and delete_sw = 'N' ;

--update Person Program area with valid enddate : from 2022-11-17 to 2022-11-16
select * from personprogramarea
where personid = (select personid from person where cjamspid = '200929516');

update 	personprogramarea
set 	enddate = '2022-11-16',
		updatedby = 'CDM-27768',
		updatedon = now()
where 	personprogramid = '751e563b-852e-40e5-b853-702676aaca47' and activeflag = 1;


