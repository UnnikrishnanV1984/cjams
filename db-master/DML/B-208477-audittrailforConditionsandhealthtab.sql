
DELETE FROM cjams.tb_picklist_values
WHERE picklist_type_id= 10060 and picklist_value_cd ='5466';

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('5466', 10060, 'Health_Conditions', 'Conditions/Disorders', 'Y', 0, Now(), 'B-208477', Now(), 'B-208477', 'N', NULL);