/*
   Issue Description: CDM-16343
   Category/ Module  :  Placement
   Root cause: user requeseted to update placement Info
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- 2021-07-12 00:00:00	18:30
update placement set enddatetime = null, endtime = null, updatedon = now(), updatedby = 'CDM-16343' where placementid = '2d10e2b6-54b3-41ae-b79c-3884ec91fd92' and activeflag = 1;
-- 2021-07-12 00:00:00	18:30
update placementrevision set exitdate = null, exittime = null, updatedon = now(), updatedby = 'CDM-16343' where placementid = '2d10e2b6-54b3-41ae-b79c-3884ec91fd92' and activeflag = 1;
-- 2021-07-12
update tb_placement_validation set placement_exit_dt = null, update_ts = now(), update_user_id = 'CDM-16343' where placement_id = 1561236;
