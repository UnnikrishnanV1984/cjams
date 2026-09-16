/*
    CDM-17299
    Issue: Updating placement End date
    Root cause: user requested
    Fix: Done data fix for now
*/


--2021-10-01 00:00:00
update placement set enddatetime = '2021-09-16 00:00:00', updatedby = 'CDM-17299', updatedon = now() where placementid = '4b1bae37-6f9a-4d8f-ac1d-3108b9662401';
update placementrevision set exitdate = '2021-09-16 00:00:00', updatedby = 'CDM-17299', updatedon = now() where placementid = '4b1bae37-6f9a-4d8f-ac1d-3108b9662401' and activeflag = 1;
-- 2021-10-01
update tb_placement_validation set placement_exit_dt = '2021-09-16', update_user_id = 'CDM-17299', update_ts = current_timestamp  where  placement_id = '1562356';
