----------------------------------------------------------------
-- 04/08/2025 - B-208462 - Naveenkumar Chemutu
---------------------------------------------------------------



DELETE FROM cjams.tb_picklist_values
WHERE picklist_type_id= 10060 and picklist_value_cd ='5467';

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('5467', 10060, 'Medication_Psychotropic', 'Medication Psychotropic', 'Y', 0, Now(), 'CIDM-10354', Now(), 'CIDM-10354', 'N', NULL);
