ALTER TABLE cjams.tb_placement_cpa_homes ALTER COLUMN exit_type_cd TYPE varchar(15) USING exit_type_cd::varchar;
ALTER TABLE cjams.tb_placement_cpa_homes ALTER COLUMN exit_reason_cd TYPE varchar(15) USING exit_reason_cd::varchar;
