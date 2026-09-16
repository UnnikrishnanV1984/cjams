-- CDM-12401 - Placement missing
/*
-- Issue Description: 
   This request is to change the placement entry date. 
   
	Case ID: 3286932
	Client ID: 3616587 (DIPSEY M HERNANDEZ LANZA) - 888478bb-9789-48b4-8d4a-ab05af01c8e5
	Placement ID: 1557111 - 09/10/2020 to to 09/10/2020 - a4f66f5a-2bc5-48b3-9278-6aba51f42488
	RCC Facility: 5000793 (Hearts and Homes - Helen Smith Girls Group Home)
	
-- Category/ Module: Placements  (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Placement Entry date changes - 09/10/2020 to 08/10/2020
select alternateid, startdatetime, starttime, enddatetime, endtime,
	exitreasontypekey, exittypekey, updatedby , updatedon 
from cjams.placement 
where placementid = 'a4f66f5a-2bc5-48b3-9278-6aba51f42488'
	and activeflag  = 1 ;

update cjams.placement  
set startdatetime = '2020-08-10 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-12401'
where placementid = 'a4f66f5a-2bc5-48b3-9278-6aba51f42488'
	and activeflag = 1 ;

-- Placement Revision Entry date changes
select entrydate, entrytime, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = 'a4f66f5a-2bc5-48b3-9278-6aba51f42488' 
	and entrydate::date = '2020-09-10'::date ;

update cjams.placementrevision  
set entrydate = '2020-08-10 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-12401'
where placementid = 'a4f66f5a-2bc5-48b3-9278-6aba51f42488' 
	and entrydate::date = '2020-09-10'::date ;

-- Placement Validations 
-- Update Entry date & Exit date
select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from cjams.tb_placement_validation 
where placement_id = 1557111 ;

Update cjams.tb_placement_validation 
set placement_entry_dt = '2020-08-10'::date,
	placement_exit_dt = '2020-09-10'::date,
	update_ts = now(),
	update_user_id = 'CDM-12401'
where placement_id = 1557111 ;
	
-- Update Aug 2020
select placement_id, validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from cjams.tb_placement_validation 
where placement_validation_id = 1931480
	and delete_sw = 'Y' ;

Update cjams.tb_placement_validation 
	set  delete_sw = 'N',
		validation_status_cd = '1750',
		update_ts = now(),
		update_user_id = 'CDM-12401'
where placement_validation_id = 1931480
	and delete_sw = 'Y';
