-- CDM-19160 -placement end date
/*
 Issue Description: CDM-19160
   Category/ Module : placement end date
   Root cause: user wants to remove placement end date
   Pull request# for code fix: 
   Explanantion: user wants to removeplacement end date from placement section
*/

-- Datafix to re-open the Placement, Removal, OOH & IV-E

select alternateid, startdatetime, starttime, enddatetime, enddatetime, 
	exitreasontypekey, exittypekey, isvoided, updatedby, updatedon
from cjams.placement 
where placementid = '39e32b3b-8f32-45d6-ad75-fd8da59b7b03'
	and activeflag  = 1 ;

update cjams.placement  
set enddatetime = null, 
	endtime = null, 
	exitreasontypekey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-19160'
where placementid = '39e32b3b-8f32-45d6-ad75-fd8da59b7b03'
	and activeflag  = 1 ;

select exitdate, exittime, exitreasontypkey, exittypekey, updatedby , updatedon 
	from cjams.placementrevision  
where placementid = '39e32b3b-8f32-45d6-ad75-fd8da59b7b03'
	and ( exitdate is not null or exittime is not null ) ;

update cjams.placementrevision  
set exitdate = null, 
	exittime = null, 
	exitreasontypkey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-19160'
where placementid = '39e32b3b-8f32-45d6-ad75-fd8da59b7b03'
	and ( exitdate is not null or exittime is not null ) ;

select removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag , *
	from cjams.intakeservreqchildremoval
where personid  = 'b7940e27-c44e-4a9a-968f-f6799d7925c6'
and removalid  = '195850'
	and activeflag = 1 ;

update cjams.intakeservreqchildremoval
set exitdate = Null,
	returndate = Null,
	returntime = Null,
	removalexitreason = NULL,
	updatedby = 'CDM-19160',
	updatedon = now()
where removalid  = '195850'
	and activeflag = 1 ;

select programkey, startdate, enddate, updatedby, updatedon, *
	from cjams.personprogramarea 
where personprogramid  = '0b43d126-2429-4c28-9e49-1ce42bbac7bf'
	and activeflag = 1 ;

update cjams.personprogramarea 
set enddate = Null, 
	updatedby = 'CDM-19160',
	updatedon = now()
where personprogramid  = '0b43d126-2429-4c28-9e49-1ce42bbac7bf'
	and activeflag = 1 ;

select client_id, start_dt, end_dt, update_ts, update_user_id , eligibility_id
	from cjams.tb_client_eligibility
where eligibility_id  = '168531'
	and delete_sw = 'N' ;

update cjams.tb_client_eligibility
set end_dt = Null,
	update_user_id = 'CDM-19160',
	update_ts = now()
where eligibility_id = '168531'
	and delete_sw = 'N' ;

select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw , *
from tb_placement_validation
where placement_id = 1562366
	and delete_sw  = 'N'
	
	Update tb_placement_validation 
set placement_exit_dt = null,
	update_ts = now(),
	update_user_id = 'CDM-19160'
where placement_id = 1562366
	and delete_sw = 'N' ;