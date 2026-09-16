DELETE FROM cjams.tb_picklist_values
WHERE picklist_type_id=263 AND trim(picklist_value_cd)='3585';

DELETE FROM cjams.tb_picklist_values
WHERE picklist_type_id=263 AND trim(picklist_value_cd)='3586';

DELETE FROM cjams.tb_picklist_values
WHERE picklist_type_id=263 AND trim(picklist_value_cd)='3587';

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('3585', 263, 'PC', 'PC', 'Y', 0, now(), 'cadmin', now(), 'cadmin', 'N', NULL);

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('3586', 263, 'CT', 'CT', 'Y', 0, now(), 'cadmin', now(), 'cadmin', 'N', NULL);

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('3587', 263, 'CC', 'CC', 'Y', 0, now(), 'cadmin', now(), 'cadmin', 'N', NULL);


