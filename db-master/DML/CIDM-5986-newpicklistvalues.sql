DELETE FROM cjams.tb_picklist_values
WHERE picklist_type_id= 323;

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('NKR1', 323, 'Youth refused to attend/schedule', 'Youth refused to attend/schedule', 'Y', 0, Now(), 'CIDM-5986', Now(), 'CIDM-5986', 'N', NULL) ON CONFLICT DO NOTHING;
INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('NKR2', 323, 'Youth on runaway/AWOL', 'Youth on runaway/AWOL', 'Y', 2, Now(), 'CIDM-5986', Now(), 'CIDM-5986', 'N', NULL) ON CONFLICT DO NOTHING;
INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('NKR3', 323, 'Youth detained in correctional facility', 'Youth detained in correctional facility', 'Y', 3, Now(), 'CIDM-5986', Now(), 'CIDM-5986', 'N', NULL) ON CONFLICT DO NOTHING;
INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('NKR4', 323, 'Illness/Emergency/Hospitalization', 'Illness/Emergency/Hospitalization', 'Y', 5, Now(), 'CIDM-5986', Now(), 'CIDM-5986', 'N', NULL) ON CONFLICT DO NOTHING;
INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('NKR5', 323, 'Doctor office cancelation', 'Doctor office cancelation', 'Y', 6, Now(), 'CIDM-5986', Now(), 'CIDM-5986', 'N', NULL) ON CONFLICT DO NOTHING;
INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('NKR6', 323, 'Other', 'Other', 'Y', 7 , Now(), 'CIDM-5986', Now(), 'CIDM-5986', 'N', NULL) ON CONFLICT DO NOTHING;