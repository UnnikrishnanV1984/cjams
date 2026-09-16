update tb_picklist_values set value_tx= 'Referred to CCU' ,description_tx = 'Referred to CCU' where Trim(picklist_value_cd)  = '775';

update tb_picklist_values set value_tx= 'Reissued' ,description_tx = 'Reissued' 
where Trim(picklist_value_cd)  = '4850';

update tb_picklist_values set active_sw = 'N' where  Trim(picklist_value_cd) not in ('4849','580','4269','4850')
and picklist_type_id = 37;