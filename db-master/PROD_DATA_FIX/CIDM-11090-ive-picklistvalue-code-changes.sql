UPDATE cjams.tb_picklist_values
SET picklist_value_cd = btrim(picklist_value_cd)
WHERE picklist_type_id = 271
  AND delete_sw = 'N'
  AND picklist_value_cd IS NOT NULL
  AND picklist_value_cd <> btrim(picklist_value_cd)
  AND btrim(picklist_value_cd) <> '';