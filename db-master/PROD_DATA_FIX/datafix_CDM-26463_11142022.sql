-- CDM-26463 - UNVOID
/*
-- Issue Description: 
   User request to revert void the below placement

-- Case ID: 3264522
-- Client ID: 3738959 (DOUGLAS ALLEN KINGSLEY)-  ff722104-5b57-48fb-8fd4-9e3806c8fe8c
-- Placement ID: 1565237 - 2021-05-19 To 2022-07-20 - 960bec2a-b443-47f4-94d5-dfda343f6b1f
-- Private Organization: 6002823 ( Lakeland Behavioral Health System Residential Treatment Center)
-- Residential Treatment Center: 6002889 (Lakeland Behavioral Health System RTC - 2323 W. Grand St.)	
-- Program ID: 50002445	(Douglas Kingsley)                 	

-- Category/ Module: Placements  (Case Management) 
-- Root cause: User error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to change the placement Exit date as 2022-07-18 (Voided Placement)
-- Placement Entry date changes
select alternateid, startdatetime, starttime, enddatetime, endtime,
	exitreasontypekey, exittypekey, updatedby , updatedon, 
	isvoided, voidapprovaldate, voidapprovalstatustypekey, voiddate, voidreasontypekey 
from placement 
where placementid = '960bec2a-b443-47f4-94d5-dfda343f6b1f'
	and activeflag = 1 ;

update placement  
set enddatetime = '2022-07-18 00:00:00', 
	endtime = '17:00',
	exitreasontypekey = NULL, 
	exittypekey = 'CIPS', 
	isvoided = 0, 
	voidapprovaldate = now(), 
	voidapprovalstatustypekey = NULL, 
	voiddate = NULL, 
	voidreasontypekey = NULL, 
	updatedon = now(), 
	updatedby = 'CDM-26463'
where placementid = '960bec2a-b443-47f4-94d5-dfda343f6b1f'
	and activeflag = 1 ;

-- Placement Revision
select entrydate, entrytime, exitdate, exittime, 
		isvoided, voiddate, voidreasontypekey, updatedby, updatedon  
	from placementrevision  
where placementid = '960bec2a-b443-47f4-94d5-dfda343f6b1f'
	and placementrevisionid
		in (	-- Void Request & Approved
				'd2559ee4-ec22-4332-aacd-a33be0611d4f',
				'274a1dc8-9c45-4142-b1c0-d6ff4122bb40'
			) ;

update placementrevision
set exitdate = '2022-07-18 00:00:00',
	exittime = '17:00',
	isvoided = null, 
	voiddate = null, 
	voidreasontypekey = null, 
	updatedon = now(), 
	updatedby = 'CDM-26463'
where placementid = '960bec2a-b443-47f4-94d5-dfda343f6b1f'
	and placementrevisionid
		in (	-- Void Request & Approved
				'd2559ee4-ec22-4332-aacd-a33be0611d4f',
				'274a1dc8-9c45-4142-b1c0-d6ff4122bb40'
			) ;


-- Placement Validations
select delete_sw, validation_start_dt, validation_end_dt, validation_status_cd, update_ts, update_user_id 
	from tb_placement_validation 
where placement_id = 1565237
	and placement_validation_id = 2007088
	and delete_sw = 'Y' ;	

update tb_placement_validation
set delete_sw = 'N',
	update_ts = now(),
	update_user_id = 'CDM-26463'
where placement_id = 1565237
	and placement_validation_id = 2007088
	and delete_sw = 'Y' ;	

select delete_sw, validation_start_dt, validation_end_dt, validation_status_cd, update_ts, update_user_id 
	from tb_placement_validation 
where placement_id = 1565237
	and delete_sw = 'N'	
order by validation_start_dt ;

-- Update exit date for all
Update tb_placement_validation 
set placement_exit_dt = '2022-07-18',
	validation_status_cd = '1750',
	update_ts = now(),
	update_user_id = 'CDM-26463'
where placement_id = 1565237
	and delete_sw = 'N' ;

INSERT INTO cjams.tb_placement_validation
	(	placement_validation_id, placement_id, placement_entry_dt, placement_exit_dt, 
		validation_status_cd, comment_tx, create_user_id, update_user_id, delete_sw, 
		validation_start_dt, validation_end_dt, create_ts, update_ts, etl_userid, etl_load_date)
VALUES
	(	nextval('sq_placement_validation'::regclass), 1565237, '2021-05-19', '2022-07-18', 
		'1750', NULL, 'CDM-26463', 'CDM-26463', 'N', 
		'2022-07-01', '2022-07-31', 
		now(), now(), NULL, NULL
	);
