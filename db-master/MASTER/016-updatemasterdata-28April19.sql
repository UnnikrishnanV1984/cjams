
UPDATE cjams.tb_picklist_values
SET 
 delete_sw='Y' 
WHERE picklist_type_id=320 AND picklist_value_cd='3257 ';
-- Actual parameter values may differ, what you see is a default string representation of values
UPDATE cjams.tb_picklist_values
SET description_tx='Problem Follow-up Health Examination',value_tx='Problem Follow-up Health Examination'
WHERE picklist_type_id=320 AND picklist_value_cd='7069';

-- Actual parameter values may differ, what you see is a default string representation of values
-- Actual parameter values may differ, what you see is a default string representation of values
UPDATE cjams.tb_picklist_values
SET description_tx='Sick/Urgent Visit',value_tx='Sick/Urgent Visit'
WHERE picklist_type_id=320 AND picklist_value_cd='7834';
UPDATE cjams.tb_picklist_values
SET description_tx='Well child examination (EPSDT)',value_tx='Well child examination (EPSDT)'
WHERE picklist_type_id=320 AND picklist_value_cd='7833';
UPDATE cjams.tb_picklist_values
SET description_tx='Initial Health Screening Examination',value_tx='Initial Health Screening Examination'
WHERE picklist_type_id=320 AND picklist_value_cd='3255 ';


-- Actual parameter values may differ, what you see is a default string representation of values
UPDATE cjams.tb_picklist_values
SET delete_sw='Y',active_sw='N'
WHERE picklist_type_id=319 AND picklist_value_cd='7832';
UPDATE cjams.tb_picklist_values
SET delete_sw='Y',active_sw='N'
WHERE picklist_type_id=319 AND picklist_value_cd='7830';
UPDATE cjams.tb_picklist_values
SET value_tx='Other (specify if possible)',description_tx='Other (specify if possible)'
WHERE picklist_type_id=319 AND picklist_value_cd='7829';
UPDATE cjams.tb_picklist_values
SET delete_sw='Y',active_sw='N'
WHERE picklist_type_id=319 AND picklist_value_cd='7828';
UPDATE cjams.tb_picklist_values
SET value_tx='Hemoglobin/Hematocrit',description_tx='Hemoglobin/Hematocrit'
WHERE picklist_type_id=319 AND picklist_value_cd='7827';
UPDATE cjams.tb_picklist_values
SET value_tx='Tuberculosis (PPD/QFT/T-Spot)',description_tx='Tuberculosis (PPD/QFT/T-Spot)'
WHERE picklist_type_id=319 AND picklist_value_cd='3254 ';
UPDATE cjams.tb_picklist_values
SET delete_sw='Y',active_sw='N'
WHERE picklist_type_id=319 AND picklist_value_cd='3250 ';
UPDATE cjams.tb_picklist_values
SET delete_sw='Y',active_sw='N'
WHERE picklist_type_id=319 AND picklist_value_cd='3249 ';

-- Actual parameter values may differ, what you see is a default string representation of values
UPDATE cjams.tb_picklist_values
SET value_tx='HIV',description_tx='HIV'
WHERE picklist_type_id=319 AND picklist_value_cd='3253 ';
UPDATE cjams.tb_picklist_values
SET value_tx='Lipid Panel/Cholesterol',delete_sw='N',active_sw='Y',description_tx='Lipid Panel/Cholesterol'
WHERE picklist_type_id=319 AND picklist_value_cd='3250 ';

-- Actual parameter values may differ, what you see is a default string representation of values
UPDATE cjams.tb_picklist_values
SET description_tx='Other Specialty (specify)',value_tx='Other Specialty (specify)'
WHERE picklist_type_id=318 AND picklist_value_cd='7851';
UPDATE cjams.tb_picklist_values
SET active_sw='N',delete_sw='Y'
WHERE picklist_type_id=318 AND picklist_value_cd='7850';
UPDATE cjams.tb_picklist_values
SET active_sw='Y',delete_sw='N'
WHERE picklist_type_id=318 AND picklist_value_cd='10386';
UPDATE cjams.tb_picklist_values
SET active_sw='N',delete_sw='Y'
WHERE picklist_type_id=318 AND picklist_value_cd='10380';

UPDATE cjams.tb_picklist_values
SET value_tx='None', description_tx='None', active_sw='Y', sort_order_no=10, create_ts='2006-01-11-14.23.25.086000', create_user_id='cadmin', update_ts='2006-01-11-14.23.25.086000', update_user_id='cadmin', delete_sw='N', category_tx=NULL
WHERE picklist_type_id=48 AND picklist_value_cd='12911';

UPDATE cjams.tb_picklist_values
SET value_tx='Other (Specify)', description_tx='Other (Specify)', active_sw='Y', sort_order_no=0, create_ts='2002-01-10-12.00.00.000000', create_user_id='cadmin', update_ts='2002-01-10-12.00.00.000000', update_user_id='cadmin', delete_sw='N', category_tx=NULL
WHERE picklist_type_id=48 AND picklist_value_cd='763  ';

UPDATE cjams.tb_picklist_values
SET value_tx='Unknown', description_tx='Unknown', active_sw='Y', sort_order_no=0, create_ts='2002-01-10-12.00.00.000000', create_user_id='cadmin', update_ts='2002-01-10-12.00.00.000000', update_user_id='cadmin', delete_sw='N', category_tx=NULL
WHERE picklist_type_id=48 AND picklist_value_cd='764  ';

UPDATE cjams.tb_picklist_values
SET value_tx='Single Birth', description_tx='Single Birth', active_sw='Y', sort_order_no=0, create_ts='2002-01-10-12.00.00.000000', create_user_id='cadmin', update_ts='2002-01-10-12.00.00.000000', update_user_id='cadmin', delete_sw='Y', category_tx=NULL
WHERE picklist_type_id=90 AND picklist_value_cd='1288 ';

-- Actual parameter values may differ, what you see is a default string representation of values
UPDATE cjams.tb_picklist_values
SET active_sw='N',delete_sw='Y'
WHERE picklist_type_id=344 AND picklist_value_cd='8014';
UPDATE cjams.tb_picklist_values
SET active_sw='Y',delete_sw='N'
WHERE picklist_type_id=344 AND picklist_value_cd='8008';

UPDATE cjams.tb_picklist_values
SET active_sw='N',delete_sw='Y'
WHERE picklist_type_id=23 AND picklist_value_cd='8005';
UPDATE cjams.tb_picklist_values
SET value_tx='Other (Specify)',description_tx='Other (Specify)'
WHERE picklist_type_id=23 AND picklist_value_cd='7780';

-- Actual parameter values may differ, what you see is a default string representation of values
UPDATE cjams.tb_picklist_values
SET value_tx='Oncology/Cancer Treatment (specify)',description_tx='Oncology/Cancer Treatment (specify)'
WHERE picklist_type_id=230 AND picklist_value_cd='32777';
UPDATE cjams.tb_picklist_values
SET delete_sw='Y',active_sw='N'
WHERE picklist_type_id=230 AND picklist_value_cd='32776';
UPDATE cjams.tb_picklist_values
SET delete_sw='Y',active_sw='N'
WHERE picklist_type_id=230 AND picklist_value_cd='32775';

UPDATE cjams.tb_picklist_values
SET value_tx='Medications (Specify)',description_tx='Medications (Specify)'
WHERE picklist_type_id=15 AND picklist_value_cd='7939';
UPDATE cjams.tb_picklist_values
SET value_tx='Other Food (Specify)',description_tx='Other Food (Specify)'
WHERE picklist_type_id=15 AND picklist_value_cd='7938';
UPDATE cjams.tb_picklist_values
SET value_tx='Ragweed (Autumn)',description_tx='Ragweed (Autumn)'
WHERE picklist_type_id=15 AND picklist_value_cd='62   ';
UPDATE cjams.tb_picklist_values
SET value_tx='Insect Stings',description_tx='Insect Stings'
WHERE picklist_type_id=15 AND picklist_value_cd='57   ';
UPDATE cjams.tb_picklist_values
SET value_tx='Tobacco Smoke',description_tx='Tobacco Smoke'
WHERE picklist_type_id=15 AND picklist_value_cd='7944';
UPDATE cjams.tb_picklist_values
SET value_tx='Shellfish (crab, lobster, shrimp)',description_tx='Shellfish (crab, lobster, shrimp)'
WHERE picklist_type_id=15 AND picklist_value_cd='7943';
UPDATE cjams.tb_picklist_values
SET active_sw='N',delete_sw='Y'
WHERE picklist_type_id=15 AND picklist_value_cd='7942';
UPDATE cjams.tb_picklist_values
SET active_sw='N',delete_sw='Y'
WHERE picklist_type_id=15 AND picklist_value_cd='7941';