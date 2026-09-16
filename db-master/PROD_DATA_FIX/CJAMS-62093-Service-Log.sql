/*
   Issue Description: 3301764:There is a service log from 2021 with no end date. When an end date is entered, the start date is then marked invalid. When a new start date is entered, it is still marked as invalid. This is stopping the progression of closing the case.
   Category/ Module  : Service Log
   Root cause: As per system design, duplicate or multiple service logs can not be created on the same date period for the same client ID, Provider/Vendor ID and Service.
    Need data fix to end the Service log with "06/08/2021" and Service End Reason as "Service Completed".
    Client ID: 4407971 (MARIA GRANADOS)
    Provider ID: 5008821 (Baltimore Gas And Electric Revenue Cont.)
    Service: Utility Payments/Deposit (Paid)

   Fix Provided: Data fix has been done to endate the service log 
   Data/Code fix ticket#: CJAMS-62093
   Regression Impacts: N/A
   Is Code fix Required?: No
   Code fix ticket#: N/A
   Reason why no related code fix: User error 
*/
/*
select end_reason_desc_tx ,end_service_reason_cd ,start_dt ,estimated_end_dt ,* from tb_service_log tsl 
where client_id = '4407971' and end_dt is null and delete_sw = 'N';
*/

update tb_service_log
set end_dt = '2021-06-08'::date,
	update_ts = now(), 
	end_service_reason_cd = '1824',
	update_user_id = 'CJAMS-62093' 
where service_log_id = 2001681
      and case_id =  3301764
      and client_id = 4407971;     