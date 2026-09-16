-- CDM-22161 - PROVIDER OWED 1 DAY
/*
-- Issue Description: 
   User request to change the placement Exit Date 
   Need to update the End date from 06/30/2021 08:00 AM to 07/01/2021 12:29 PM
   
-- Case ID: 3161303
-- Client ID: 1676118 (KEYONA D	SMITH) - 58b2d093-c690-4395-8cf8-d14eaf345e43
-- Placement ID: 336288 -  2019-08-08 To 2021-06-30 - a2d291d9-cb8c-4f67-8a2f-21b5cc89c457 
-- Private Organization: 5000882 (Pressley Ridge, Inc.)
-- CPA Office: 5061783 (Pressley Ridge Caroline St)
-- Program: 11547	Teen Mother Pgm - formerly Casey

-- Category/ Module: Placements  (Case Management) 
-- Root cause: N/A
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Placement Exit date & Time changes
-- 2021-06-30 00:00:00	Exit Time 08:00 (current)
-- 2021-07-01 00:00:00	Exit Time 12:29 (new)

select alternateid, startdatetime, starttime, enddatetime, endtime,
	exitreasontypekey, exittypekey, updatedby , updatedon 
from cjams.placement 
where placementid = 'a2d291d9-cb8c-4f67-8a2f-21b5cc89c457'
	and activeflag  = 1 ;

update cjams.placement  
set enddatetime = '2021-07-01 00:00:00', 
	endtime = '12:29',
	updatedon = now(), 
	updatedby = 'CDM-22161'
where placementid = 'a2d291d9-cb8c-4f67-8a2f-21b5cc89c457'
	and activeflag = 1 ;

-- Placement Revision Exit date & time changes
select entrydate, entrytime, exitdate, exittime, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = 'a2d291d9-cb8c-4f67-8a2f-21b5cc89c457' 
	and exitdate is not null;

update cjams.placementrevision  
set exitdate = '2021-07-01 00:00:00',
	exittime = '12:29',
	updatedon = now(), 
	updatedby = 'CDM-22161'
where placementid = 'a2d291d9-cb8c-4f67-8a2f-21b5cc89c457' 
	and exitdate is not null;


select entrydt, entrytm, exitdt, exittm, exittypecd, exitreasoncd, updatets, updateuserid 
	from placementcpahomes 
where placementcpahomeid = '8607478d-ba48-4392-8e4b-3b08d3921c2b'
	and activeflag = 1 ;

update placementcpahomes
set exitdt = '2021-07-01 00:00:00',
	exittm = '2021-07-01 12:29:00',
	-- exittypecd = NULL,
	-- exitreasoncd = NULL,
	updatets = now(),
	updateuserid = 'CDM-22161'
where placementcpahomeid = '8607478d-ba48-4392-8e4b-3b08d3921c2b'
	and activeflag = 1 ;
	
-- Placement Validation 
select placement_id, placement_entry_dt , placement_exit_dt, validation_start_dt, validation_end_dt, 
	validation_status_cd, update_ts, update_user_id, delete_sw 
from cjams.tb_placement_validation 
where placement_id  = 336288
	and delete_sw = 'N' ;

Update cjams.tb_placement_validation 
set -- placement_entry_dt = '2019-08-08'::date,
	placement_exit_dt = '2021-07-01'::date,
	update_ts = now(),
	update_user_id = 'CDM-22161'
where placement_id = 336288 
	and delete_sw = 'N';
