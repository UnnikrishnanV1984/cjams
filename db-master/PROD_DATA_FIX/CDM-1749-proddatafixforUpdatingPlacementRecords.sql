
/*
   Issue Description: CDM-17493
   Category/ Module  : Updating Placement Records
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



-- 2021-08-10 00:00:00
update placement set startdatetime = '2021-08-18 00:00:00', updatedby = 'CDM-17493', updatedon = now() where placementid = '810f5f02-c6b2-4fb5-b52a-7e394b4004c6';
update placementrevision set entrydate = '2021-08-18 00:00:00', updatedby = 'CDM-17493', updatedon = now() where placementid = '810f5f02-c6b2-4fb5-b52a-7e394b4004c6' and activeflag = 1;
-- 2021-08-10
update tb_placement_validation set placement_entry_dt = '2021-08-18', update_user_id = 'CDM-17493', update_ts = current_timestamp  where  placement_id = '1565818' and delete_sw = 'N';


-- 2021-08-10 00:00:00
update placement set enddatetime = '2021-08-18 00:00:00', updatedby = 'CDM-17493', updatedon = now() where placementid = '2202635c-1d68-4037-bc4e-7a918ef81d93';
update placementrevision set exitdate = '2021-08-18 00:00:00', updatedby = 'CDM-17493', updatedon = now() where placementid = '2202635c-1d68-4037-bc4e-7a918ef81d93' and activeflag = 1;
-- 2021-08-10
update tb_placement_validation set placement_exit_dt = '2021-08-18', update_user_id = 'CDM-17493', update_ts = current_timestamp  where  placement_id = '1564697' and delete_sw = 'N';