delete from tb_picklist_values tpv where picklist_type_id = 10047;
								   
INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES	('1', 10047, '3-5 days', '3-5 days', 'Y', 0, now(), 'cadmin', now(), 'cadmin', 'N', NULL),
		('2', 10047, '1 week', '1 week', 'Y', 0, now(), 'cadmin', now(), 'cadmin', 'N', NULL),
		('3', 10047, '2 weeks', '2 weeks', 'Y', 0, now(), 'cadmin', now(), 'cadmin', 'N', NULL),
		('4', 10047, '1 month', '1 month', 'Y', 0, now(), 'cadmin', now(), 'cadmin', 'N', NULL),
		('5', 10047, '2 months', '2 months', 'Y', 0, now(), 'cadmin', now(), 'cadmin', 'N', NULL),
		('6', 10047, '4 months', '4 months', 'Y', 0, now(), 'cadmin', now(), 'cadmin', 'N', NULL),
		('7', 10047, '6 months', '6 months', 'Y', 0, now(), 'cadmin', now(), 'cadmin', 'N', NULL),
		('8', 10047, '9 months', '9 months', 'Y', 0, now(), 'cadmin', now(), 'cadmin', 'N', NULL),
		('9', 10047, '12 months', '12 months', 'Y', 0, now(), 'cadmin', now(), 'cadmin', 'N', NULL),
		('10', 10047, '15 months', '15 months', 'Y', 0, now(), 'cadmin', now(), 'cadmin', 'N', NULL),
		('11', 10047, '18 months', '18 months', 'Y', 0, now(), 'cadmin', now(), 'cadmin', 'N', NULL),
		('12', 10047, '21 months', '21 months', 'Y', 0, now(), 'cadmin', now(), 'cadmin', 'N', NULL),
		('13', 10047, '24 months', '24 months', 'Y', 0, now(), 'cadmin', now(), 'cadmin', 'N', NULL),
		('14', 10047, '30 months', '30 months', 'Y', 0, now(), 'cadmin', now(), 'cadmin', 'N', NULL),
		('15', 10047, '36 months', '36 months', 'Y', 0, now(), 'cadmin', now(), 'cadmin', 'N', NULL),
		('16', 10047, '48 months', '48 months', 'Y', 0, now(), 'cadmin', now(), 'cadmin', 'N', NULL);