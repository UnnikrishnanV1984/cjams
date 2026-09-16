DELETE FROM cjams.tb_picklist_values
WHERE picklist_type_id= 323 and picklist_value_cd ='NKR7';

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('NKR7', 323, 'Provider/Caregiver missed medical appointment', 'Provider/Caregiver missed medical appointment', 'Y', 8 , Now(), 'CIDM-5986', Now(), 'CIDM-5986', 'N', NULL) ON CONFLICT DO NOTHING;