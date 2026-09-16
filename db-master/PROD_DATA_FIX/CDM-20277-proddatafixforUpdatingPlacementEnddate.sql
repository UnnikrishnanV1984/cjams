
/*
   Issue Description: CDM-20026
   Category/ Module  : Updating Placement End date
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


-- 2021-11-01 00:00:00
update placement set enddatetime = '2021-10-29 00:00:00', updatedby = 'CDM-20277', updatedon = now() where placementid = '9b1537ff-4677-4292-a33f-04f2fe3b5790';
update placementrevision set exitdate = '2021-10-29 00:00:00', updatedby = 'CDM-20277', updatedon = now() where placementid = '9b1537ff-4677-4292-a33f-04f2fe3b5790' and activeflag = 1;
-- 2021-11-01 00:00:00
update tb_placement_validation set placement_exit_dt = '2021-10-29', update_user_id = 'CDM-20277', update_ts = current_timestamp  where  placement_id = '1565813';
