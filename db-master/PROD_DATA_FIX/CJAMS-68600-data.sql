/*
Issue Description: Service Log
Root cause: User request to end-date purchase authorization as the payment has been interfaced with the D365
Fix provided: DB query to update tb_service_purchase_authorization set end_dt to 2026-01-01
Data/Code fix ticket#: CJAMS-68600
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error/data correction.
Status of the code fix if already submitted and expected prod fix date: Data fix, raising PR
Backup before update/delete Query:
 */
UPDATE tb_service_purchase_authorization
SET
    end_dt = '2026-01-01',
    update_user_id = 'CJAMS-68600',
    update_ts = NOW ()
WHERE
    authorization_id = '4149681'
    AND delete_sw = 'N';

update tb_payment_detail tpd
set
    final_service_end_dt = '2026-01-01',
    update_user_id = 'CJAMS-68600',
    update_ts = NOW ()
where
    payment_id = 5041120
    and delete_sw = 'N'; 