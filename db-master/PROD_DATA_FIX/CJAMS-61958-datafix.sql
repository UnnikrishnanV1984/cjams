/*
   Issue Description: CJAMS-61958 3301177:We are unable to end date this service log despite multiple attempts to have it closed using different date that do not conflict with other service logs
   Category/ Module  :  Service Log
   Root cause: Service Log end date missing and Data fix needed to end-date the service log with The latest Purchase Auth End Date (04/19/2024)
            Client ID: 2323347
             Provider ID: 5032131 (Montgomery County, Maryland)
Service: Financial Management (Paid)
Latest Auth End Date: 02/12/2025
               The latest Purchase Auth End Date: 2025-02-12
   Fix Provided :Data fix needed to end-date the service log with The latest Purchase Auth End Date 2025-02-12
   Pull request# for code fix:  N/A
   Reason why no related code fix: N/A
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/


update tb_service_log
  	set end_dt = '2025-02-12'::date, 
        update_ts = now(), 
        end_service_reason_cd = '1824',
        update_user_id = 'CJAMS-61958' 
  	where service_log_id = 1996497
  		and case_id = 3301177
  		and client_id = 2323347;