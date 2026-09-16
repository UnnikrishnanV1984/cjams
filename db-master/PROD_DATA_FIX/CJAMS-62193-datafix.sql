/*
Issue Description:251030454094::Date for MVA 2/3/2025 ended for 2/3/2026. Having trouble creating a new service for this authorization link 
Root cause: 
Fix provided: DB query to udate tb_service_log.
Data/Code fix ticket#:CJAMS-62193, DB query to udate tb_service_log.
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#:  no
Reason why no related code fix:User error, not logic error.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
    
 -- Update the main authorization table
UPDATE tb_service_purchase_authorization
SET end_dt = '2025-02-03',
    update_ts = now(), 
	update_user_id = 'CJAMS-62193'
WHERE service_log_id = 3584715 and authorization_id='3716034';

-- Update the snapshot table
UPDATE tb_slpa_snapshot
SET end_dt = '2025-02-03',
    update_user_id='CJAMS-62193',
	update_ts =now() 
WHERE authorization_id = 3716034 and  
      service_log_id = 3584715 and 
      slpa_snapshot_id='2494546';

  
UPDATE tb_payment_detail
SET final_service_end_dt = '2025-02-03',
    update_ts = now(),
    update_user_id = 'CJAMS-62193'
WHERE payment_id = 4668278
  AND delete_sw = 'N';
 
