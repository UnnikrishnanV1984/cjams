/*
   Issue Description: CJAMS-58981 3219631:Will not let us close the case/ Close permanency plan ( GAP) Due to outstanding service logs, once you go to the outstanding service log it says that the dates overlap eventhough they do not other dates where attempted but it did not work
   Category/ Module  : Service Log
   Root cause: Service Log end date is missing which is preventing the user to close the case.
               Data fix needed to end date the open service log to 07/01/2022 for the client
              Client ID: 4282588 (MYA PARKER)
              Provider ID: 5068111 (La Petite Academy - Himes Ave.)
              Service: Child Care (Paid)
   Fix Provided: Data fix has been done to endate the service log date to 07/01/2022 
   Data/Code fix ticket#: CJAMS-58981
   Regression Impacts: N/A
   Is Code fix Required?: No
   Code fix ticket#: N/A
   Reason why no related code fix: User error 
*/



update tb_service_log
    set end_dt = '2022-07-01'::date, update_ts = now(), end_service_reason_cd = '1824',update_user_id = 'CJAMS-58981' 
    where service_log_id = 2048907
          and case_id =  3219631
          and client_id = 4282588;