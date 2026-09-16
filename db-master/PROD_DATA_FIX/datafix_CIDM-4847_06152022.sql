-- CIDM-4847 - CJAMS CW Daily Notifications Batch run clean of 06/15/2022 multiple run
/*
-- Issue Description: 
   CJAMS CW Daily Notifications Batch was ran in prod in error  
  
-- Category/ Module: User Notifications (Case Management) 
-- Root cause: N/A
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select count(*) 
	from usernotificationmap u2  
where activeflag  = 1
	and usernotificationid 
		in ( select usernotificationid 
				from usernotification u 
			 where insertedon >= '2022-06-15 14:39:40'
				and insertedon  <= '2022-06-15 14:50:16'
				and old_id is not null 
			) ;

update usernotificationmap 
set activeflag  = 0,
	updatedby = 'CIDM-4847',
	updatedon = now()
where activeflag  = 1
	and usernotificationid 
		in ( select usernotificationid 
				from usernotification u 
			 where insertedon >= '2022-06-15 14:39:40'
				and insertedon  <= '2022-06-15 14:50:16'
				and old_id is not null 
			) ;



select count(*) 
	from usernotification  
where insertedon >= '2022-06-15 14:39:40'
	and insertedon <= '2022-06-15 14:50:16'
	and old_id is not null 
	and activeflag = 1;

update usernotification 
set activeflag = 0,
	updatedby = 'CIDM-4847',
	updatedon = now()
where insertedon >= '2022-06-15 14:39:40'
	and insertedon <= '2022-06-15 14:50:16'
	and old_id is not null 
	and activeflag = 1;
	
select * 
	from tb_batch_log 
where batch_log_id in (406326, 406327, 406328, 406329) 
order by start_ts desc	;	

Delete from tb_batch_log where batch_log_id in (406326, 406327, 406328, 406329) ;

/*
To Revert if needed 
INSERT INTO cjams.tb_batch_log
(batch_log_id, batch_master_id, success_sw, run_dt, comments_tx, start_ts, end_ts, etl_userid, etl_load_date)
VALUES(406329, 75, 'Y', '2022-06-15', NULL, '2022-06-15 14:50:12.12515-04', '2022-06-15 14:50:16.582206-04', NULL, NULL);

INSERT INTO cjams.tb_batch_log
(batch_log_id, batch_master_id, success_sw, run_dt, comments_tx, start_ts, end_ts, etl_userid, etl_load_date)
VALUES(406328, 75, 'Y', '2022-06-15', NULL, '2022-06-15 14:45:12.066858-04', '2022-06-15 14:45:15.948406-04', NULL, NULL);

INSERT INTO cjams.tb_batch_log
(batch_log_id, batch_master_id, success_sw, run_dt, comments_tx, start_ts, end_ts, etl_userid, etl_load_date)
VALUES(406327, 75, 'Y', '2022-06-15', NULL, '2022-06-15 14:40:34.48112-04', '2022-06-15 14:41:12.764417-04', NULL, NULL);

INSERT INTO cjams.tb_batch_log
(batch_log_id, batch_master_id, success_sw, run_dt, comments_tx, start_ts, end_ts, etl_userid, etl_load_date)
VALUES(406326, 75, 'Y', '2022-06-15', NULL, '2022-06-15 14:39:40.938546-04', '2022-06-15 14:40:37.699612-04', NULL, NULL);
*/
