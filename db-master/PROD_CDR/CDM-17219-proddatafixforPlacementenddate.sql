/*
    CDM-17219
    Issue: Removing Living arrangement record
    Root cause: user requested
    Fix: Done data fix for now
*/


-- 3798973
--2021-08-04 00:00:00 00:00:00
update placement set enddatetime = '2021-07-12 00:00:00', updatedby = 'CDM-17219', updatedon = now() where placementid = '772bb85f-50ff-4c99-8dbe-6c9235f15c9a';
update placementrevision set exitdate = '2021-07-12 00:00:00', updatedby = 'CDM-17219', updatedon = now() where placementid = '772bb85f-50ff-4c99-8dbe-6c9235f15c9a' and activeflag = 1;

update tb_placement_validation set delete_sw = 'Y', update_user_id = 'CDM-17219', update_ts = current_timestamp  where placement_validation_id = '1973055';
-- 2021-08-04
update tb_placement_validation set placement_exit_dt = '2021-07-12', update_user_id = 'CDM-17219', update_ts = current_timestamp  where  placement_id = '1562203' and delete_sw = 'N';



-- 3798974
--2021-08-04 00:00:00 00:00:00
update placement set enddatetime = '2021-07-12 00:00:00', updatedby = 'CDM-17219', updatedon = now() where placementid = '0570f759-be6a-4f3f-9063-7b53e25fd5c3';
update placementrevision set exitdate = '2021-07-12 00:00:00', updatedby = 'CDM-17219', updatedon = now() where placementid = '0570f759-be6a-4f3f-9063-7b53e25fd5c3' and activeflag = 1;

update tb_placement_validation set delete_sw = 'Y', update_user_id = 'CDM-17219', update_ts = current_timestamp  where placement_validation_id = '1972801';
-- 2021-08-04
update tb_placement_validation set placement_exit_dt = '2021-07-12', update_user_id = 'CDM-17219', update_ts = current_timestamp  where  placement_id = '1561267' and delete_sw = 'N';


update placement set enddatetime = '2021-07-12 00:00:00', updatedby = 'CDM-17219', updatedon = now() where placementid = '772bb85f-50ff-4c99-8dbe-6c9235f15c9a';
update livingarrangement set livingenddate = '2021-07-12 00:00:00', updatedby = 'CDM-17219', updatedon = now() where placementid = '772bb85f-50ff-4c99-8dbe-6c9235f15c9a';
