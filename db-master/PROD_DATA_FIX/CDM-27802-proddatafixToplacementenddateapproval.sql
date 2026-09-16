/*
   Issue Description: CDM-27802
   Category/ Module  : Prod data fix to placement end date update
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update placement set enddatetime = '2022-12-30 00:00:00',endtime = '13:59', updatedby = 'CDM-27802',	exittypekey = 'CIPS',
	exitreasontypekey = null, updatedon =  now(), remarks = 'Permanency Step: Placement with Relative',leastrestrictiveplacement = 'Placed with Biological Father'
where placementid = 'dac0752f-6315-492c-929f-3ade3737ca24';
update placementrevision set exitdate = '2022-12-30 00:00:00', exittime = '13:59',
 remarks = 'Permanency Step: Placement with Relative',leastrestrictiveplacement = 'Placed with Biological Father', exittypekey = 'CIPS' , updatedby = 'CDM-27802', updatedon = now() where placementid = 'dac0752f-6315-492c-929f-3ade3737ca24';
update tb_placement_validation set placement_exit_dt = '2022-12-30', update_user_id = 'CDM-27802', update_ts = current_timestamp  where 
placement_id = '1565379';