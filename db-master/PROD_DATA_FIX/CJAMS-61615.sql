/*
Issue Description: CJAMS-61615 Unable to close the case due to service log
Category/Module: Service log
Root cause: This is not a defect. As per system design, the service log can not be ended with the date that is greater than the selected client program date period and prior to the latest purchase authorization end date.

In this case, the Service log client program is selected as OOH (Out of Home), and the client program has end-dated prior to the latest purchase authorization end-date.
Data fix needed to endate the service log with 07/01/2024

Fix provided: Data fix has been done to end date the service log with date 07/01/2024
Data/Code fix ticket#:
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This is a known issue and we are handling it with this data fix.
*/

update tb_service_log
    set end_dt = '2024-07-01'::date, update_ts = now(), end_service_reason_cd = '1824',update_user_id = 'CJAMS-61615' 
    where service_log_id = 3254589
          and case_id =  3303032
          and client_id = 200950274;
