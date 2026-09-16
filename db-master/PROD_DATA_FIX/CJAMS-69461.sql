/*
Issue Description: CJAMS-69461 - Service Log
User requested to update the Actual End Date as 01/31/2022 in Service Log
   Case# 3195405
   Client# JADA JONES 1685691
   Provider 5029953 Shoppers Food
   Service Food (Paid)
   Actual Begin Date 05/26/2021

Category/Module: Service Log
Root cause: As per system design, duplicate or multiple service logs can not be created on the same or overlapping date period for the same client ID, 
            Provider/Vendor ID and Service.
Fix provided: Data fix has been done to update the Service Log Actual End Date to 01/31/2022.
Data/Code fix ticket#: CJAMS-69461
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Expected behaviour.
*/

update tb_service_log
set end_dt = '2022-01-31'::date,
    end_service_reason_cd = '1824',
    update_ts = now(),
    update_user_id = 'CJAMS-69461'
where service_log_id = 1999891
and case_id = 3195405
and client_id = 1685691
and end_dt is null;
