-- Updating datatype of create_ts, update_ts on tb_receivable_detail
ALTER TABLE cjams.tb_receivable_detail add column if not exists create_ts_new timestamp;

update cjams.tb_receivable_detail set create_ts_new=create_ts::timestamp;

ALTER TABLE cjams.tb_receivable_detail drop column if exists create_ts CASCADE;

ALTER TABLE cjams.tb_receivable_detail rename column create_ts_new to create_ts;