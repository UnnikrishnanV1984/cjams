/*
-- CDM-21587--

-- Issue Description: 
 Unable to set exit date
  
-- Customer Email ID:rhonda.gardner@maryland.gov

-- Root cause: Data fix to update the exit date
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

--2021-09-01 00:00:00
update placement set enddatetime = '2021-12-15 00:00:00', updatedby = 'CDM-21587', updatedon = now() where placementid = 'bbbc7e84-324b-43d8-8059-ada1aacc8680';
update placementrevision set exitdate = '2021-12-15 00:00:00', updatedby = 'CDM-21587', updatedon = now() where placementid = 'bbbc7e84-324b-43d8-8059-ada1aacc8680' and activeflag = 1;
-- 2021-09-01
update tb_placement_validation set placement_exit_dt = '2021-12-15', update_user_id = 'CDM-21587', update_ts = current_timestamp  where  placement_id = '1565197';
