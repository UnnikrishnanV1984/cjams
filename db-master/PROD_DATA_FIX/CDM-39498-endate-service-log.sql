/*
   Issue Description: CDM-39498 3049645:We are unable to end date this service log despite multiple attempts to have it closed using different date that do not conflict with other service logs
   Category/ Module  :  Service Log
   Root cause: Service Log end date missing and Data fix needed to end-date the service log with The latest Purchase Auth End Date (04/19/2024)
               Client ID: 1265504 (AMEERAH ROUZEE)
               Provider ID: 5075238 (Easy Transport, LLC)
               Service: Transportation assistance (Paid)
               Purchase Auth ID: 3174797
               The latest Purchase Auth End Date: 04/19/2024
   Fix Provided :Data fix needed to end-date the service log with The latest Purchase Auth End Date (04/19/2024)
   Pull request# for code fix:  N/A
   Reason why no related code fix: N/A
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/


update tb_service_log
  	set end_dt = '2024-04-19'::date, update_ts = now(), end_service_reason_cd = '1824',update_user_id = 'CDM-39498' 
  	where service_log_id = 1954493
  		and case_id = 3049645
  		and client_id = 1265504;