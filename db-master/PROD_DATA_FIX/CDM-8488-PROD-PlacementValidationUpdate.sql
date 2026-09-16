update tb_placement_validation 
set update_ts =current_timestamp, update_user_id ='CDM-8488'
where placement_validation_id in (1938168, 1935752);