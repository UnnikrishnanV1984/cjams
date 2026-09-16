/*
    CDM-17391
    Issue: Updating placement End date
    Root cause: user requested
    Fix: Done data fix for now
*/

--2021-05-28 00:00:00
update placement set enddatetime = '2021-06-06 00:00:00', updatedby = 'CDM-17391', updatedon = now() where placementid = '40b4595a-8b88-4177-aac4-4fcfd2b739fa';
update placementrevision set exitdate = '2021-06-06 00:00:00', updatedby = 'CDM-17391', updatedon = now() where placementid = '40b4595a-8b88-4177-aac4-4fcfd2b739fa' and activeflag = 1;

update tb_placement_validation set delete_sw = 'N' where placement_validation_id = '1965044';
-- 2021-05-28
update tb_placement_validation set placement_exit_dt = '2021-06-06', update_user_id = 'CDM-17391', update_ts = current_timestamp  where  placement_id = '339014';
