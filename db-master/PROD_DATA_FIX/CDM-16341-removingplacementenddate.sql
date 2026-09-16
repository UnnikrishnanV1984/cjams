/*
   Issue Description: CDM-16341
   Category/ Module  :  Removing placement info
   Root cause: user requeseted to update Removal Info
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- 2021-07-12 00:00:00	18:30
update placement set enddatetime = null, endtime = null, updatedon = now(), updatedby = 'CDM-16341' where placementid = '05228140-6077-44cb-baab-9c6dcbb845c6' and activeflag = 1;
-- 2021-07-12 00:00:00	18:30
update placementrevision set exitdate = null, exittime = null, updatedon = now(), updatedby = 'CDM-16341' where placementid = '05228140-6077-44cb-baab-9c6dcbb845c6' and activeflag = 1;
-- 2021-07-12
update tb_placement_validation set placement_exit_dt = null, update_ts = now(), update_user_id = 'CDM-16341' where placement_id = 1561235;
