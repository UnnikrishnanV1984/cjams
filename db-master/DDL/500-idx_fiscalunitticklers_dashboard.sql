CREATE INDEX idx_tb_ticklers_fiscalunitticklers
ON cjams.tb_ticklers USING btree
(action_sw, delete_sw, county_cd, create_ts);