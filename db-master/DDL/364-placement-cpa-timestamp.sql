ALTER TABLE cjams.tb_placement_cpa_homes ALTER COLUMN create_ts TYPE timestamp USING create_ts::timestamp;
ALTER TABLE cjams.tb_placement_cpa_homes ALTER COLUMN update_ts TYPE timestamp USING update_ts::timestamp;
ALTER TABLE cjams.tb_placement_cpa_homes ALTER COLUMN entry_tm TYPE timestamp USING entry_dt::timestamp;
ALTER TABLE cjams.tb_placement_cpa_homes ALTER COLUMN exit_tm TYPE timestamp USING exit_dt::timestamp;