update servicelog
set enddate ='2020-10-06T04:00:00.000Z', updatedon =now(), updatedby ='CDM-7738'
where servicelogid ='c3cf97a2-e086-4ae0-b9d4-95fa20152e10';

update tb_service_log 
set end_dt ='2020-10-06'::date, update_ts =current_timestamp,  update_user_id ='CDM-7738'
where service_log_id =981483;