update placement 
set startdatetime ='2020-09-09 13:00:00', updatedon =now(), updatedby ='CDM-10628'
where placementid ='6b785910-dee5-439e-855f-3386296cddd4';


update placementrevision 
set entrydate ='2020-09-09 13:00:00', updatedon =now(), updatedby ='CDM-10628'
where placementid ='6b785910-dee5-439e-855f-3386296cddd4';

update tb_placement_validation
set placement_entry_dt ='2020-09-09', update_ts =current_timestamp, update_user_id ='CDM-10628'
where placement_validation_id =1935475;