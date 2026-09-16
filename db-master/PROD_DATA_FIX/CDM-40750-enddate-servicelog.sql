/* 
   Issue Description: CDM-40651 Permanencey Plan
   Category/ Module  : Permanency Plan
   Root cause:Need to end date the service log for the case 3270921 as requested by user.
            Case # : 3270921
            Cjams PID # : 4010338
            End Date should be : 05/01/2024
            Estimated End Date : 05/01/2024
            Service End Reason : Program Ende
   Fix Provided : Data fix has been provided to end date the service log for the to  05/01/2024
   Pull request# for code fix: N/A
   Reason why no related code fix: N/A 
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/

UPDATE tb_service_log
SET end_dt = '2024-05-01'::date ,
    update_ts = now(),
    update_user_id = 'CDM-40750',
    end_service_reason_cd = '1824'
WHERE service_log_id in ('2040165')
    and delete_sw = 'N';

UPDATE tb_service_log
SET end_dt = '2024-05-31'::date ,
    update_ts = now(),
    update_user_id = 'CDM-40750',
    end_service_reason_cd = '1824'
WHERE service_log_id in ('2040166')
    and delete_sw = 'N';