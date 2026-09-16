/*
-- CDM-22111- 

-- Issue Description: 
--	Unable to update placement enddate
  
-- Customer Email ID: bobbie.jones@maryland.gov

-- Root cause: Data fix to update placement enddate
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- 2021-15-09 00:00:00
update placement set enddatetime = '2020-11-17 00:00:00', updatedby = 'CDM-22111', updatedon = now() where placementid = 'ff557a8e-7785-486a-857d-b51b5ee44857';
update placementrevision set exitdate = '2020-11-17 00:00:00', updatedby = 'CDM-22111', updatedon = now() where placementid = 'ff557a8e-7785-486a-857d-b51b5ee44857' and activeflag = 1;
-- 2021-15-09
update tb_placement_validation set placement_exit_dt = '2020-11-17', update_user_id = 'CDM-22111', update_ts = current_timestamp  where  placement_id = '327278' and delete_sw = 'N';
