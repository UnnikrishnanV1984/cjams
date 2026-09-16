/*
   Issue Description: CDM-16599
   Category/ Module  :  Removing placement end date
   Root cause: user requeseted to update placement
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
-- 2021-08-13 00:00:00
update placement set enddatetime = null, endtime = null, updatedon = now(), updatedby = 'CDM-16599' where placementid = 'de074d24-9def-41e6-b4ed-eb662166d900' and activeflag = 1;

-- 2021-08-13 00:00:00
update placementrevision set exitdate = null, exittime = null, updatedon = now(), updatedby = 'CDM-16599' where placementid = 'de074d24-9def-41e6-b4ed-eb662166d900' and activeflag = 1;

-- validation table
update tb_placement_validation set placement_exit_dt = null, update_user_id = 'CDM-16599', update_ts = now() where placement_id  = 1564120;

-- Adding a new row for August Month
INSERT INTO cjams.tb_placement_validation
(	placement_validation_id, placement_id, placement_entry_dt, placement_exit_dt, 
	validation_status_cd, comment_tx, create_user_id, update_user_id, delete_sw, 
	validation_start_dt, validation_end_dt, create_ts, update_ts
)
values
(	nextval('sq_placement_validation'::regclass), 1564120, '2021-06-25', NULL, 
	NULL, '', 'CDM-16599', 'CDM-16599', 'N'::bpchar, '2021-08-01', '2021-08-31', now(),now()
);
