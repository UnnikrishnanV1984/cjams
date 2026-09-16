-- INSERT INTO cjams.tb_service_purchase_authorization
-- (authorization_id, service_log_id, start_dt, end_dt, funding_source_cd, cost_no, justification_tx, funding_approval_fl, payment_approval_fl, final_amount_no, voucher_sw, finance_category_cd, sprvsr_approval_status_cd, ads_approval_status_cd, funding_approval_status_cd, payment_approval_status_cd, print_voucher_sw, unit_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, fiscal_category_cd, sprvsr_approval_dt, ads_approval_dt, funding_approval_dt, payment_approval_dt, dedicated_ac_sw, client_account_id, one_time_only_sw, reason_tx, modified_fiscal_category_cd, etl_userid, etl_load_date)
-- VALUES(1730942, 1954469, '2019-12-20', '2019-12-22', NULL, 61.20, 'Respite Care', NULL, NULL, NULL, 'N', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-01-02T13:38:11.936Z', '63ff57d0-e448-45f0-b065-21df6c3d8621', '2020-01-06T18:43:03.762Z', 'eba740d3-c238-4497-a660-3b7b09e12922', 'N', '7157 ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '7157', NULL, NULL);

-- INSERT INTO cjams.tb_service_purchase_authorization
-- (authorization_id, service_log_id, start_dt, end_dt, funding_source_cd, cost_no, justification_tx, funding_approval_fl, payment_approval_fl, final_amount_no, voucher_sw, finance_category_cd, sprvsr_approval_status_cd, ads_approval_status_cd, funding_approval_status_cd, payment_approval_status_cd, print_voucher_sw, unit_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, fiscal_category_cd, sprvsr_approval_dt, ads_approval_dt, funding_approval_dt, payment_approval_dt, dedicated_ac_sw, client_account_id, one_time_only_sw, reason_tx, modified_fiscal_category_cd, etl_userid, etl_load_date)
-- VALUES(1730943, 1954469, '2019-12-06', '2019-12-08', NULL, 61.20, 'Respite Care. ', NULL, NULL, NULL, 'N', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-01-02T13:40:38.670Z', '63ff57d0-e448-45f0-b065-21df6c3d8621', '2020-01-06T18:42:50.769Z', 'eba740d3-c238-4497-a660-3b7b09e12922', 'N', '7157 ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '7157', NULL, NULL);

UPDATE cjams.routing
SET  activeflag=0
WHERE routingid='ce20e2ba-3bff-4ca2-94b3-a4ea40d2013d';

DELETE FROM cjams.tb_service_purchase_authorization
WHERE authorization_id=1730943;

DELETE FROM cjams.tb_service_purchase_authorization
WHERE authorization_id=1730942;

UPDATE cjams.routing
SET activeflag=0
WHERE routingid='70187f85-a806-4947-bef2-da00980b8b61';

