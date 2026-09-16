/*
  Issue Description: CIDM-2836 -- Reporting ETL job failed in production due to future start date and end date in   cjams.TB_service_log table, Can you please fix this issue on high priority.
						Financial reports are impacting this issue.
						end date: "20210-05-19"
   Category/ Module  :  Service log
   Root cause:
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:
back up: end_Dt:20210-05-19 
*/
update cjams.TB_service_log set end_dt='2021-05-19',update_ts=now(),update_user_id='CIDM-2836'
where service_log_id = 2000121;