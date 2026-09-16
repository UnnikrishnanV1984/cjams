update placement 
set enddatetime ='2020-11-11 00:00:00', updatedon =now(), updatedby ='CDM-12055'
where placementid ='d42ccfbd-a14f-4c1a-a108-8969f1097466';

update placementrevision 
set exitdate ='2020-11-11 00:00:00', updatedon =now(), updatedby ='CDM-12055'
where placementrevisionid in ('74941139-6728-439f-930f-3d5e56ed9ed2','b8ee79e1-35b3-4c2d-9bb6-9ef63491839e');

update tb_placement_validation 
set placement_exit_dt ='2020-11-11 00:00:00'::date, update_user_id ='CDM-12101'
where placement_id =1558726;

update tb_placement_validation 
set update_ts =current_timestamp, update_user_id ='CDM-12101'
where placement_validation_id in (1948880,
1945680,
1942414);