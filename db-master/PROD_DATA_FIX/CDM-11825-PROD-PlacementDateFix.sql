update placement
set startdatetime ='2021-02-09 00:00:00', updatedon =now(), updatedby ='CDM-11825'
where placementid ='cb686ba1-ed6e-4076-b405-5dcdc2cc30c4';

update tb_placement_validation 
set placement_entry_dt ='2021-02-09 00:00:00', update_ts =current_timestamp, update_user_id ='CDM-11825'
where placement_validation_id =1953349;