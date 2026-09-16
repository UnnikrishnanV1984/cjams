---  1099 Reportable Tax selection new option request - NEC-01 

DELETE FROM cjams.tb_picklist_values
WHERE picklist_type_id = 308 and picklist_value_cd = '3159';

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_user_id, update_user_id, delete_sw, category_tx, mdmcode, update_ts, create_ts)
values
('3159', 308, 'NEC-01', 'NEC-01 (Non-Employee Compensation)', 'Y', 0, 'B-237332', 'B-237332', 'N', NULL, NULL, now(), now());