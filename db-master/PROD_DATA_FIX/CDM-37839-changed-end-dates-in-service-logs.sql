-- CDM-37839 - Changed end dates in Service Logs
/*  
-- Case ID: 3245550
-- Client ID: 2883772 (Arianna Williams)

-- Category/ Module: Service Log (Case Management) 
-- Root cause: User requested to update the service log end date from 03/11/2023 to 02/22/2024.
-- Fix Provided: Datafix has been promoted to end date the Service Logs.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Backup
select service_log_id, start_dt, end_dt, end_service_reason_cd, update_ts, update_user_id 
from tb_service_log where client_id=2883772 and end_dt='2024-03-11' and delete_sw = 'N';
-- UPDATE cjams.tb_service_log
-- SET start_dt='2024-02-22', end_dt='2024-03-11', end_service_reason_cd='1824', update_ts='2024-02-23 16:44:27.302575-05', update_user_id='097e343f-cfa4-4d35-8424-cdeb8c553964'
-- WHERE service_log_id=3053483;
-- UPDATE cjams.tb_service_log
-- SET start_dt='2024-02-22', end_dt='2024-03-11', end_service_reason_cd='1824', update_ts='2024-02-22 10:09:20.162089-05', update_user_id='097e343f-cfa4-4d35-8424-cdeb8c553964'
-- WHERE service_log_id=3051377;
-- UPDATE cjams.tb_service_log
-- SET start_dt='2020-07-31', end_dt='2024-03-11', end_service_reason_cd='1824', update_ts='2020-07-31 14:44:10.820789-04', update_user_id='097e343f-cfa4-4d35-8424-cdeb8c553964'
-- WHERE service_log_id=1961137;
-- UPDATE cjams.tb_service_log
-- SET start_dt='2024-02-19', end_dt='2024-03-11', end_service_reason_cd='1824', update_ts='2024-02-19 15:24:10.594925-05', update_user_id='097e343f-cfa4-4d35-8424-cdeb8c553964'
-- WHERE service_log_id=3047959;
-- UPDATE cjams.tb_service_log
-- SET start_dt='2024-02-19', end_dt='2024-03-11', end_service_reason_cd='1824', update_ts='2024-02-19 15:06:33.262009-05', update_user_id='097e343f-cfa4-4d35-8424-cdeb8c553964'
-- WHERE service_log_id=3047958;
-- UPDATE cjams.tb_service_log
-- SET start_dt='2023-12-05', end_dt='2024-03-11', end_service_reason_cd='1824', update_ts='2023-12-05 14:31:30.610565-05', update_user_id='097e343f-cfa4-4d35-8424-cdeb8c553964'
-- WHERE service_log_id=2876006;
-- UPDATE cjams.tb_service_log
-- SET start_dt='2023-06-02', end_dt='2024-03-11', end_service_reason_cd='1824', update_ts='2023-06-02 11:34:18.272725-04', update_user_id='097e343f-cfa4-4d35-8424-cdeb8c553964'
-- WHERE service_log_id=2361438;
-- UPDATE cjams.tb_service_log
-- SET start_dt='2021-03-22', end_dt='2024-03-11', end_service_reason_cd='1824', update_ts='2021-03-22 15:38:48.921422-04', update_user_id='097e343f-cfa4-4d35-8424-cdeb8c553964'
-- WHERE service_log_id=1990744;
-- UPDATE cjams.tb_service_log
-- SET start_dt='2020-12-21', end_dt='2024-03-11', end_service_reason_cd='1824', update_ts='2020-12-21 12:30:55.060244-05', update_user_id='097e343f-cfa4-4d35-8424-cdeb8c553964'
-- WHERE service_log_id=1981532;

-- Update
update tb_service_log
set end_dt = '2024-02-22'::date,
	update_ts = now(), 
	update_user_id = 'CDM-37839'
where client_id=2883772 and delete_sw = 'N' and service_log_id in (3053483,1961137,3047959,3047958,2876006,2361438,1990744,1981532);

update tb_service_log
set end_dt = '2024-02-26'::date,
	update_ts = now(), 
	update_user_id = 'CDM-37839'
where client_id=2883772 and delete_sw = 'N' and service_log_id in (3051377);



