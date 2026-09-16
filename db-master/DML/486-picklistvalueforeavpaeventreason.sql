INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('3593', 263, 'EAVPA_R1_30_Days', 'EAVPA_R1_30_Days', 'Y', 0, now(), 'cadmin', now(), 'cadmin', 'N', NULL) ON CONFLICT DO NOTHING;