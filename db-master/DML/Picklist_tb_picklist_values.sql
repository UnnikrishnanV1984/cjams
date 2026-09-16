delete from tb_picklist_values where 
picklist_type_id=2 and picklist_value_cd in ('26') and delete_sw='N';

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('26', 2, 'CfE Bed Hold Retainer Fee', 'CfE Bed Hold Retainer Fee', 'Y', 0, now(), 'cadmin', now(), 'cadmin', 'N', NULL);