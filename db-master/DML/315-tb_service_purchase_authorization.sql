-- INSERT INTO cjams.tb_service_purchase_authorization
-- (authorization_id, service_log_id, start_dt, end_dt, funding_source_cd, cost_no, justification_tx, funding_approval_fl, payment_approval_fl, final_amount_no, voucher_sw, finance_category_cd, sprvsr_approval_status_cd, ads_approval_status_cd, funding_approval_status_cd, payment_approval_status_cd, print_voucher_sw, unit_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, fiscal_category_cd, sprvsr_approval_dt, ads_approval_dt, funding_approval_dt, payment_approval_dt, dedicated_ac_sw, client_account_id, one_time_only_sw, reason_tx, modified_fiscal_category_cd, etl_userid, etl_load_date)
-- VALUES(1730977, 1954469, '2019-12-06', '2019-12-08', NULL, 61.20, 'Respite care', NULL, NULL, NULL, 'N', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-01-06T18:58:34.072Z', '63ff57d0-e448-45f0-b065-21df6c3d8621', '2020-01-14T17:20:14.408Z', '63ff57d0-e448-45f0-b065-21df6c3d8621', 'N', '7157 ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '7157', NULL, NULL);

DELETE FROM cjams.tb_service_purchase_authorization
WHERE authorization_id=1730977;

