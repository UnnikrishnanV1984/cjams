/*INSERT INTO cjams.tb_service_purchase_authorization
(authorization_id, service_log_id, start_dt, end_dt, funding_source_cd, cost_no, justification_tx, funding_approval_fl, payment_approval_fl, final_amount_no, voucher_sw, finance_category_cd, sprvsr_approval_status_cd, ads_approval_status_cd, funding_approval_status_cd, payment_approval_status_cd, print_voucher_sw, unit_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, fiscal_category_cd, sprvsr_approval_dt, ads_approval_dt, funding_approval_dt, payment_approval_dt, dedicated_ac_sw, client_account_id, one_time_only_sw, reason_tx, modified_fiscal_category_cd, etl_userid, etl_load_date)
VALUES(1730930, 1954647, '2019-12-26', '2019-12-26', NULL, 60.00, 'initial clothing for AD', NULL, NULL, NULL, 'N', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-30T17:38:25.960Z', 'e8a72972-e1a4-43a6-9e17-f26a966094cf', '2020-01-06T21:41:03.723Z', '98b33fbc-7c40-47fa-8e83-101e7aab4d05', 'Y', '7126 ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '7126', NULL, NULL);*/

delete from tb_service_purchase_authorization where authorization_id = 1730930;

update routing set activeflag=0,updatedon=current_timestamp where 
routingid in ('5351a804-a059-4f02-9063-66d49e8fcc96','6a8a9111-49bc-49f9-ae81-dc2ef411598b','f7c2872b-9ad4-4c4b-b9e4-b6ac9eeaba37');
