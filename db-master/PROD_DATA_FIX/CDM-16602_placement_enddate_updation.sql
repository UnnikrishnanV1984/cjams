/*
   Issue Description: CDM-16602
   Category/ Module  :  Removing placement end date
   Root cause: user requeseted to update placement
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- 2021-07-06 00:00:00  08:00
update placement set enddatetime = null, endtime = null, updatedon = now(), updatedby = 'CDM-16602' where placementid = '1d09d686-e639-429b-8f62-48409bbd1f24' and activeflag = 1;
-- 2021-07-06 00:00:00	10:00
update placementrevision set exitdate = null, exittime = null, updatedon = now(), updatedby = 'CDM-16602' where placementid = '1d09d686-e639-429b-8f62-48409bbd1f24' and activeflag = 1;

-- validation table
update tb_placement_validation set placement_exit_dt = null, update_user_id = 'CDM-16602', update_ts = now() where placement_id  = 1562898;

-- Adding a new row for August Month
INSERT INTO cjams.tb_placement_validation
(	placement_validation_id, placement_id, placement_entry_dt, placement_exit_dt, 
	validation_status_cd, comment_tx, create_user_id, update_user_id, delete_sw, 
	validation_start_dt, validation_end_dt, create_ts, update_ts
)
values
(	nextval('sq_placement_validation'::regclass), 1562898, '2021-04-01', NULL, 
	NULL, '', 'CDM-16602', 'CDM-16602', 'N'::bpchar, '2021-08-01', '2021-08-31', now(),now()
);

