/*
Issue Description:3152404:I cannot close my services case due to previous service logs from other cases from years prior still being open. CJAMS will not allow me to change estimated end dates or actual end dates. The needed calendar selections are grayed out
Root cause: As per system design, the service log can not be ended prior to the latest approved purchase authorization end date.
Fix provided: DB query to udate tb_service_log.
Data/Code fix ticket#:CJAMS-61427
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#:  no
Reason why no related code fix:User error, not logic error.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
--02/14/2025
UPDATE tb_service_log
SET end_dt = '2025-02-14'::date ,
    update_ts = now(),
    update_user_id = 'CJAMS-61427',
    end_service_reason_cd = '1824',estimated_end_dt = '2025-02-14'
WHERE service_log_id in ('2037653')
    and delete_sw = 'N';
    
--   07/25/2025
   UPDATE tb_service_log
SET end_dt = '2025-07-25'::date ,
    update_ts = now(),
    update_user_id = 'CJAMS-61427',estimated_end_dt = '2025-07-25',
    end_service_reason_cd = '1824'
WHERE service_log_id in ('2035427')
    and delete_sw = 'N';
    
   
--   07/11/2024
   UPDATE tb_service_log
SET end_dt = '2024-07-11'::date ,
    update_ts = now(),
    update_user_id = 'CJAMS-61427',estimated_end_dt = '2024-07-11',
    end_service_reason_cd = '1824'
WHERE service_log_id in ('2063080')
    and delete_sw = 'N';
    
--   12/13/2012
   
      UPDATE tb_service_log
set start_dt  = '2012-12-13'::date , end_dt = '2012-12-13'::date ,
    update_ts = now(),
    update_user_id = 'CJAMS-61427',estimated_end_dt = '2012-12-13',
    end_service_reason_cd = '1824'
WHERE service_log_id in ('468601')
    and delete_sw = 'N';