/*
Issue Description: CJAMS-69520 - overlapping service log dates
User requested to update the Actual End Date as 02/06/2024 in Service Log
   Case# 231030179376
   Client# HAZEL LAWRENCE 200978100
   Provider 5047901 St. Mary's Sunshine Center
   Service Child Care (Paid)
   Actual Begin Date 10/17/2023

Category/Module: Service Log
Root cause: Service logs are overlapping, Service Log Actual End Date is missing which is preventing the user from closing the case.
Fix provided: Data fix has been done to update the Service Log Actual End Date to 02/06/2024.
Data/Code fix ticket#: CJAMS-69520
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error.
*/

update tb_service_log
set end_dt = '2024-02-06'::date,
    end_service_reason_cd = '1824',
    update_ts = now(),
    update_user_id = 'CJAMS-69520'
where service_log_id = 2770498
and case_id = 231030179376
and client_id = 200978100
and end_dt is null;