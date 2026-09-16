-- Updating datatype of create_ts on tb_picklist_values
ALTER TABLE cjams.tb_picklist_values add column if not exists create_ts_new timestamp;

update cjams.tb_picklist_values set create_ts_new=to_timestamp(create_ts,'yyyy-mm-dd HH24:MI:SS');

ALTER TABLE cjams.tb_picklist_values drop column if exists create_ts CASCADE;

ALTER TABLE cjams.tb_picklist_values rename column create_ts_new to create_ts;

