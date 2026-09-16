/*
 Issue Description:
 	CDM-27261: Incorrect Discharge Date
 	1. Social worker entered incorrect placement end date with Catholic Charites. His placement ended on 9/23/21 but the worker entered 9/30/21. 
 		Need data fix the date(s)
 Category/ Module: Placement
 Root cause: 	placement ended on 9/23/21 but the worker entered 9/30/21
 Pull request# 	N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/

--enddate 9/21/2020 to 9/23/2020 and time 5:00pm
select startdatetime, enddatetime, endtime, * from placement where placementid = 'feae0f77-5e3c-489c-b76e-3317404ec163'; 
update 	placement
set 	enddatetime = '2020-09-23 00:00:00',
		endtime = '17:00', 
		updatedby = 'CDM-27261',
		updatedon = now()
where 	placementid = 'feae0f77-5e3c-489c-b76e-3317404ec163' and activeflag = 1;

select entrydate, exitdate, exittime, * from placementrevision where placementrevisionid = 'd7d36fc0-5d97-44d5-aedc-138215664a28';
update 	placementrevision
set 	exitdate = '2020-09-23 00:00:00',
		exittime = '17:00',
		updatedby = 'CDM-27261',
		updatedon = now()
where 	placementrevisionid = 'd7d36fc0-5d97-44d5-aedc-138215664a28' and activeflag = 1;

-- startdate 9/21/2020 to 09/23/2020 and time 5:01 pm
select startdatetime, enddatetime, starttime, * from placement where placementid = '7e932c41-d3ea-477b-99d6-e7143abe14eb';
update 	placement
set 	startdatetime = '2020-09-23 00:00:00',
		starttime = '17:01',
		updatedby = 'CDM-27261',
		updatedon = now()
where 	placementid = '7e932c41-d3ea-477b-99d6-e7143abe14eb' and activeflag = 1;

select entrydate, exitdate, entrytime, * from placementrevision where placementrevisionid = 'e480b89a-5aae-4fb0-94eb-3e141630f415'; 
update 	placementrevision
set 	entrydate = '2020-09-23 00:00:00',
		entrytime = '17:01',
		updatedby = 'CDM-27261',
		updatedon = now()
where 	placementrevisionid = 'e480b89a-5aae-4fb0-94eb-3e141630f415' and activeflag = 1;

-- Placement Validation 
select 	placement_id, placement_entry_dt , placement_exit_dt, validation_start_dt, validation_end_dt, 
		validation_status_cd, update_ts, update_user_id, delete_sw 
from 	cjams.tb_placement_validation 
where 	placement_id  = 340848 and delete_sw = 'N' ;

Update 	cjams.tb_placement_validation 
set 	placement_exit_dt = '2020-09-23'::date,
		update_ts = now(),
		update_user_id = 'CDM-27261'
where 	placement_id = 340848 and delete_sw = 'N';