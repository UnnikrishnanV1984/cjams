UPDATE tb_picklist_values SET value_tx='Final Disbursement',description_tx='Final Disbursement'
WHERE picklist_value_cd='5470' AND picklist_type_id=38;
--
INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('5483', 39, 'Other Disbursement', 'Other Disbursement', 'Y', 0, '2019-08-17', 'cadmin', '2019-08-17', 'cadmin', 'N', 'B') ON CONFLICT DO NOTHING;


INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('5484', 38, 'Social Security disbursements', 'Social Security disbursements', 'Y', 0, '2019-08-17', 'cadmin', '2019-08-17', 'cadmin', 'N', 'B') ON CONFLICT DO NOTHING;

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('5485', 38, 'Special Needs Trust disbursements', 'Special Needs Trust disbursements', 'Y', 0, '2019-08-17', 'cadmin', '2019-08-17', 'cadmin', 'N', 'B') ON CONFLICT DO NOTHING;

