-- Query tuning for get_ancillary_payment
-- BTRIM is expensive and should be avoided in the where clause.  
-- This update will trim the values and then we can compare against the trimmed values in the where clause.
UPDATE tb_picklist_values
SET 
    picklist_value_cd = btrim(picklist_value_cd),                 
    update_user_id = 'CIDM-11127',
    update_ts = now()
WHERE picklist_type_id IN (1, 2, 5, 37, 82, 104, 133, 216, 277, 1316)
AND delete_sw = 'N'
AND (
    picklist_value_cd <> btrim(picklist_value_cd)
);