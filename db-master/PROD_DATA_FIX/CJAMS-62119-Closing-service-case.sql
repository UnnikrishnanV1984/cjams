/*
   Issue Description: 251030522713:I have been trying to close a service case from groceries that were purchased in June and July 2025. I have not been able to close it
   Category/ Module  : Service Log
   Root cause: As per system design, the service log can not be ended prior to the latest purchase authorization end date and beyond the selected client program date period.
    In this case, the client program is ended prior to the latest purchase authorization end-date in the service log. So data fix is needed to ended the respective open service log with 07/09/2025.
   Client ID: 3129979 (RUDOLPH RISBY)
    Provider ID: 6198162 (Klein's Shoprite of MD)
    Service: Food (Paid)
    Client Program Name: CPS
    CPS Program Assignment End Date: 07/03/2025
    Last Purchase Auth End Date: 07/09/2025
   Fix Provided: Data fix has been done to endate the service log date to 07/09/2025
   Data/Code fix ticket#: CJAMS-58981
   Regression Impacts: N/A
   Is Code fix Required?: No
   Code fix ticket#: N/A
   Reason why no related code fix: User error 
*/

update tb_service_log
set end_dt = '2025-07-09'::date, update_ts = now(), end_service_reason_cd = '1824',update_user_id = 'CJAMS-62119' 
where service_log_id = 3708983
      and case_id =  251030522713
      and client_id = 3129979;