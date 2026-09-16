/*
   Issue Description: CDM-41469 3290595:We are unable to end date this service log despite multiple attempts to have it closed using different date that do not conflict with other service logs
   Category/ Module  :  Service Log
   Root cause: Service Log end date missing and Data fix needed to end-date the service log with The latest Purchase Auth End Date (02/28/2020)
               Client ID: 4167135 (LARON WILSON)
                Provider ID: 5009914 (Bar-T, Inc.)
                Service: Child Care (Paid)
                Actual Begin Date: 04/01/2019
                The Latest Purchase Auth End Date: 02/28/2020
   Fix Provided :Data fix needed to end-date the service log with The latest Purchase Auth End Date (02/28/2020)
   Pull request# for code fix:  N/A
   Reason why no related code fix: N/A
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/


update tb_service_log
  	set end_dt = '02/28/2020'::date, update_ts = now(), end_service_reason_cd = '1824',update_user_id = 'CDM-41469' 
  	where service_log_id = 921872
  		and case_id = 3290595
  		and client_id = 4167135;
  		