/*
 Issue Description: CJAMS-61046
    Client ID: 201810887 (JayLee Davis)
    Provider ID: 6157944 (LESLIE P ARMSTRONG)
    Service: Medical (Paid)
    Auth ID: 3733169
    Payment ID: 4677518
 Category/ Module: PurchaseAuthorization
 Root cause: User error and user requested to end_date to 12/12/2024
 Pull request#: N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update the main authorization table
UPDATE tb_service_purchase_authorization
SET end_dt = '2024-12-12'
WHERE service_log_id = 3604962 and authorization_id='3733169'
  AND end_dt = '2025-12-12';

-- Update the snapshot table
UPDATE tb_slpa_snapshot
SET end_dt = '2024-12-12'
WHERE service_log_id = 3604962 and slpa_snapshot_id='2502211'
  AND end_dt = '2025-12-12';

  
UPDATE tb_payment_detail
SET final_service_end_dt = '2025-12-12',
    update_ts = now(),
    update_user_id = 'CJAMS-61046'
WHERE payment_id = 4677518
  AND delete_sw = 'N';