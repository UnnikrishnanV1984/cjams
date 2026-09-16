-- Updating datatype of create_ts, update_ts on tb_ticklers
ALTER TABLE cjams.tb_ticklers add column if not exists create_ts_new timestamp;

update cjams.tb_ticklers set create_ts_new=create_ts::timestamp;

ALTER TABLE cjams.tb_ticklers drop column if exists create_ts CASCADE;

ALTER TABLE cjams.tb_ticklers rename column create_ts_new to create_ts;

ALTER TABLE cjams.tb_ticklers ALTER COLUMN update_ts TYPE timestamp USING update_ts::timestamp;