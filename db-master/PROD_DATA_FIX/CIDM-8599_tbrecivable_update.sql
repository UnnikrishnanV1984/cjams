ALTER TABLE cjams.tb_receivable_detail add column if not exists update_ts_new timestamp;

update cjams.tb_receivable_detail set update_ts_new=update_ts::timestamp;

ALTER TABLE cjams.tb_receivable_detail drop column if exists update_ts CASCADE;

ALTER TABLE cjams.tb_receivable_detail rename column update_ts_new to update_ts;