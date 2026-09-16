DELETE FROM tb_picklist_values where picklist_type_id =38 and TRIM(picklist_value_cd) in('5487','5488','5489','5490');

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('5487', 38, 'SSDI', 'SSDI', 'Y', 0, '2009-04-15-18.10.58.548054', 'DBCR4712', '2009-04-15-18.10.58.548054', 'DBCR4712', 'N', 'B');

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('5488', 38, 'Dedicated SSA', 'Dedicated SSA', 'Y', 0, '2009-04-15-18.10.58.548054', 'DBCR4712', '2009-04-15-18.10.58.548054', 'DBCR4712', 'N', 'B');

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('5489', 38, 'Dedicated SSI', 'Dedicated SSI', 'Y', 0, '2009-04-15-18.10.58.548054', 'DBCR4712', '2009-04-15-18.10.58.548054', 'DBCR4712', 'N', 'B');


INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('5490', 38, 'Dedicated SSDI', 'Dedicated SSDI', 'Y', 0, '2009-04-15-18.10.58.548054', 'DBCR4712', '2009-04-15-18.10.58.548054', 'DBCR4712', 'N', 'B');
