/*
   Issue Description: CDM-27559
   Category/ Module  : Prod data fix to exit placement
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update placement set enddatetime = '2022-10-31 00:00:00',endtime = '00:00', updatedby = 'CDM-27559', updatedon =  now() ,exittypekey = 'CIPS', remarks = 'End of 6 month DOC period',leastrestrictiveplacement = 'Same placement, no placement change. Youth approved for difficilty of care stipend effective November 1, 2022'
where placementid = '5459215b-c1ca-4fa5-b6f7-4fe10965dceb';
update placementrevision set exitdate = '202-10-31 00:00:00', updatedby = 'CDM-27559', updatedon = now(), remarks = 'End of 6 month DOC period',leastrestrictiveplacement = 'Same placement, no placement change. Youth approved for difficilty of care stipend effective November 1, 2022'
where placementid = '5459215b-c1ca-4fa5-b6f7-4fe10965dceb';
update tb_placement_validation set placement_exit_dt = '2022-10-31', update_user_id = 'CDM-27559', update_ts = current_timestamp  where 
placement_id = '1575469';