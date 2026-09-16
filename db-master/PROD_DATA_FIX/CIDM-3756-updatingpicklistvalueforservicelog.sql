update tb_picklist_values set value_tx = 'Other', description_tx = 'Other', update_ts = now(), update_user_id = 'CIDM-3756' where picklist_value_cd = '1840' and picklist_type_id = '10046';
