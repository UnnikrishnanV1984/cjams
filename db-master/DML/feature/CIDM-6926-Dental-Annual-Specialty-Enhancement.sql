DELETE FROM cjams.tb_picklist_values
WHERE picklist_type_id=318 AND picklist_value_cd='13007';
DELETE FROM cjams.tb_picklist_values
WHERE picklist_type_id=318 AND picklist_value_cd='13008';
DELETE FROM cjams.tb_picklist_values
WHERE picklist_type_id=318 AND picklist_value_cd='13009';
DELETE FROM cjams.tb_picklist_values
WHERE picklist_type_id=318 AND picklist_value_cd='13010';
DELETE FROM cjams.tb_picklist_values
WHERE picklist_type_id=318 AND picklist_value_cd='13011';

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('13007', 318, 'Urgent visit', 'Urgent visit', 'Y', 0, now(), 'cadmin', now(), 'cadmin', 'N', 'Dental');

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('13008', 318, 'Follow up visit', 'Follow up visit', 'Y', 0, now(), 'cadmin', now(), 'cadmin', 'N', 'Dental');

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('13009', 318, 'Orthodontics', 'Orthodontics', 'Y', 0, now(), 'cadmin', now(), 'cadmin', 'N', 'Dental');

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('13010', 318, 'Dental surgery', 'Dental surgery', 'Y', 0, now(), 'cadmin', now(), 'cadmin', 'N', 'Dental');

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('13011', 318, 'Specialist appointment', 'Specialist appointment', 'Y', 0, now(), 'cadmin', now(), 'cadmin', 'N', 'Dental');