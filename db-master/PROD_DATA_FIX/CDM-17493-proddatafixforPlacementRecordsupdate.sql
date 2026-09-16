
/*
   Issue Description: CDM-17493
   Category/ Module  : Placement records update
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- 2021-08-10 00:00:00
update placement set startdatetime = '2021-08-18 00:00:00', updatedby = 'CDM-17493', updatedon = now() where placementid = '03ad681e-df7f-4102-9769-175d19430585';
update livingarrangement set livingstartdate = '2021-08-18 00:00:00', updatedby = 'CDM-17493', updatedon = now() where placementid = '03ad681e-df7f-4102-9769-175d19430585';

-- 2021-08-10 00:00:00
update placement set enddatetime = '2021-08-18 00:00:00', updatedby = 'CDM-17493', updatedon = now() where placementid = '76b00db2-668e-454d-8f72-d2096552c8bf';
update placementrevision set exitdate = '2021-08-18 00:00:00', updatedby = 'CDM-17493', updatedon = now() where placementid = '76b00db2-668e-454d-8f72-d2096552c8bf' and activeflag = 1;
-- 2021-08-10
update tb_placement_validation set placement_exit_dt = '2021-08-18', update_user_id = 'CDM-17493', update_ts = current_timestamp  where  placement_id = '1564694' and delete_sw = 'N';
