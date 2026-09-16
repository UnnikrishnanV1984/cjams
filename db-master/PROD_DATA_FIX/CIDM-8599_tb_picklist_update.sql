ALTER TABLE cjams.tb_picklist_values add column if not exists update_ts_new timestamp;

update cjams.tb_picklist_values set update_ts_new=to_timestamp(update_ts,'yyyy-mm-dd HH24:MI:SS');

ALTER TABLE cjams.tb_picklist_values drop column if exists update_ts CASCADE;

ALTER TABLE cjams.tb_picklist_values rename column update_ts_new to update_ts;