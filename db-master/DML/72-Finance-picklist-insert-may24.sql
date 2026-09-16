delete from tb_picklist_values where picklist_value_cd ='3' and picklist_type_id =10042;
INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('3', 10042, 'Service Log', 'Service Log', 'Y', 0, '2015-12-21-11.45.03.226053', 'DBCR7238', '2015-12-21-11.45.03.226053', 'DBCR7238', 'N', NULL);

update team set countyid = '3d152f0a-1bc8-4923-a685-ecaf350c8bae' where teamid ='3d152f0a-1bc8-4923-a685-ecaf350c8bae';
