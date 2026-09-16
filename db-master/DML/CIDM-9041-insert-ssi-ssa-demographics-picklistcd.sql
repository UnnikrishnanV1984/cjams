/*
    CIDM-9041 -- Court Validation Story
    DM - 'Demographics'  new picklist for demographics fail for SSI/SSA IV-E events
*/
DELETE FROM cjams.tb_picklist_values
WHERE picklist_value_cd = '3594' 
AND picklist_type_id = 263;

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx, mdmcode)
VALUES('3594', 263, 'DM', 'DM', 'Y', 0, now(), 'CIDM-9041', now(), 'CIDM-9041', 'N', NULL, NULL);
