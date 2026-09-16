-- CDM-20714 - Cannont edit placement to pay vendor
/*
-- Issue Description: 
   User request to change the placement Exit Date from 11/30/2021 to 12/01/2021
   
-- Case ID: 3078910 
-- Client ID: 1487478 (IMRAN RANA) - 29b80e67-c000-4cd5-812e-0d32777f22bb
-- Placement ID: 1562012 - 2021-03-01 To 2021-11-30 - 3ae447fd-60c2-4773-8bfb-c98a5a63eb9d
-- Private Organization: 5086851 (Innovative Services, Inc.)
-- RCC Facility: 5096312 (Innovative Services Georgian-DDA)
-- Program ID: 50002354	(Developmental Disabilities/ALU-9506 Georgian Way) - 2020-07-01 To 2021-11-30

-- Category/ Module: Placements  (Case Management) 
-- Root cause: TBD
-- Pull request# TBD
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- Placement Exit date changes
-- 2021-11-30 00:00:00 (current)
-- 2021-12-01 00:00:00 (new)
-- Entry Time 12:01 

select alternateid, startdatetime, starttime, enddatetime, endtime,
	exitreasontypekey, exittypekey, updatedby , updatedon 
from cjams.placement 
where placementid = '3ae447fd-60c2-4773-8bfb-c98a5a63eb9d'
	and activeflag  = 1 ;

update cjams.placement  
set enddatetime = '2021-12-01 00:00:00', 
	starttime = '12:01',
	updatedon = now(), 
	updatedby = 'CDM-20714'
where placementid = '3ae447fd-60c2-4773-8bfb-c98a5a63eb9d'
	and activeflag = 1 ;

-- Placement Revision Entry date changes
-- Entry Time 12:01 
select entrydate, entrytime, exitdate, exittime, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = '3ae447fd-60c2-4773-8bfb-c98a5a63eb9d' ;

update cjams.placementrevision  
set entrytime = '12:01',
	updatedon = now(), 
	updatedby = 'CDM-20714'
where placementid = '3ae447fd-60c2-4773-8bfb-c98a5a63eb9d' ;

select entrydate, entrytime, exitdate, exittime, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = '3ae447fd-60c2-4773-8bfb-c98a5a63eb9d' 
	and exitdate::date = '2021-11-30' ;

update cjams.placementrevision  
set exitdate = '2021-12-01 00:00:00', 
	-- entrytime = '12:01',
	updatedon = now(), 
	updatedby = 'CDM-20714'
where placementid = '3ae447fd-60c2-4773-8bfb-c98a5a63eb9d' 
	and exitdate::date = '2021-11-30' ;

-- Delete 
select entrydate, entrytime, exitdate, exittime, activeflag, updatedby, updatedon  
	from cjams.placementrevision  
where placementrevisionid = '2662607e-24e7-431f-aab6-d93518537ad0' ;

update cjams.placementrevision  
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-20714'
where placementrevisionid = '2662607e-24e7-431f-aab6-d93518537ad0' ;
	
-- Make Active 
select entrydate, entrytime, exitdate, exittime, activeflag, updatedby, updatedon  
	from cjams.placementrevision  
where placementrevisionid = '057fc4db-6fc5-4aa1-bf96-8a11e6000430' ;

update cjams.placementrevision  
set activeflag = 1,
	updatedon = now(), 
	updatedby = 'CDM-20714'
where placementrevisionid = '057fc4db-6fc5-4aa1-bf96-8a11e6000430' ;

-- Delete 
select routingid, eventcode, routingstatustypeid, activeflag, updatedby, updatedon 
from routing 
where routingid = 'dafb2aed-3609-4479-b73c-81eab2789527'
	and eventcode = 'PLTR'
	and activeflag = 1 ;
	
update routing
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-20714'
where routingid = 'dafb2aed-3609-4479-b73c-81eab2789527'
	and eventcode = 'PLTR'
	and activeflag = 1 ;

-- Placement Validation 
select placement_id, placement_entry_dt , placement_exit_dt, validation_start_dt, validation_end_dt, 
	validation_status_cd, update_ts, update_user_id, delete_sw 
from cjams.tb_placement_validation 
where placement_id  = 1562012
	and delete_sw = 'N' ;

Update cjams.tb_placement_validation 
set -- placement_entry_dt = '2021-03-01'::date,
	placement_exit_dt = '2021-12-01'::date,
	update_ts = now(),
	update_user_id = 'CDM-20714'
where placement_id = 1562012 
	and delete_sw = 'N';
