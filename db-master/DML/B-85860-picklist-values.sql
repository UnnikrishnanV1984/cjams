delete from cjams.tb_picklist_values where picklist_type_id=38 and picklist_value_cd='5491';

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('5491', 38, 'Contribution', 'Contribution', 'Y', 0, now(), 'B-85860', now(), 'B-85860', 'N', 'B');
