update placement 
set startdatetime ='2020-11-25 00:00:00', updatedon =now(), updatedby ='CDM-12143'
where placementid ='22810f77-e7d0-4287-9191-f2044445bcb5';

update placementrevision 
set entrydate ='2020-11-25 00:00:00', updatedon =now(), updatedby ='CDM-12143'
where placementid ='22810f77-e7d0-4287-9191-f2044445bcb5';

update tb_placement_validation 
set placement_entry_dt ='2020-11-25 00:00:00', update_ts =current_timestamp, update_user_id ='CDM-12143'
where placement_id =1559277;

update tb_placement_validation 
set update_ts =current_timestamp, update_user_id ='CDM-12143'
where placement_validation_id =1942596;