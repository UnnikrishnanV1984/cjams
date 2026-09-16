/* 
    Issue Description: CJAMS-68631
  Category/ Module  : Service log and PA
  Root cause: User request to add servicelog end date
        Need to end date as data fix with 5/1/22
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: 
  Backup before update/ delete: 

  2151020 - 10/21/2025	
3637912-3865950-funding pending
2384993-05/01/2022
*/




    UPDATE tb_service_log
SET end_dt = '2025-10-21',
    update_ts = now(),
    update_user_id = 'CJAMS-68631',
    end_service_reason_cd = '1824'  
WHERE service_log_id IN (2151020)
    and case_id = 3258590
    and delete_sw = 'N';


   
      UPDATE tb_service_log
SET end_dt = '2025-09-01',
    update_ts = now(),
    update_user_id = 'CJAMS-68631',
    end_service_reason_cd = '1824'  
WHERE service_log_id IN (2384993)
    and case_id = 3258590
    and delete_sw = 'N';