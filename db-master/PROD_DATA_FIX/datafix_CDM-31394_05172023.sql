-- CDM-31394 - Overpayment Letter and No FIscal Tickler
/*
-- Issue Description: 
	An Overpayment was identified and an Overpayment Letter dated 4/22/2023 was generated 
	for private provider Associated Catholic Charities (5000543) 
	for client id #1788396 Aleathia L Conner for Baltimore City for GAP program 
	and no fiscal tickler is listed

-- Category/ Module: GAP (Case Management)
-- Root cause: this GAP case was created with the wrong provider (Prviate Provider).
-- Fix Provided: Datafix has been promoted to add the missing FIscal Tickler
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

INSERT INTO cjams.tb_ticklers
(	tickler_id, 
	tickler_tx, 
	tickler_type_sw, due_dt, reminder_start_dt, entity_type_cd, entity_key_id, entity_nm, 
	assigned_to_staff_id, client_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, 
	county_cd, county_unit_id, system_tickler_id, tickler_nature_cd, assign_to_county_cd, assign_to_unit_id, 
	expiry_dt, entity_id1, entity_id2, 
	screen_cd, data_valid_sw, client_merge_id, action_tx, action_sw, action_dt, supervisor_review_sw, transfered_tickler_id, 
	action_by_staff_id, etl_userid, etl_load_date
	)
VALUES
(	cjams.SP_nextid('sq_ticklers'), 
	'A Subsidy/GAP overpayment has occurred for the provider Associated Catholic Charities Inc. . Send Overpayment Notice (Recovery).', 
	'S', '2023-05-22'::date, '2023-04-22'::date, '2953', 5000543, 'Associated Catholic Charities Inc. ', 
	NULL, 1788396, '2023-04-22 19:07:16.313191-04', 'CDM-31394', now(), 'CDM-31394', 'N', 
	'3824', 10052, 42, '2532', '3824', NULL, 
	'2023-06-21 00:00:00.000', 1729101, 3146683,
	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
	NULL, NULL, NULL
);

