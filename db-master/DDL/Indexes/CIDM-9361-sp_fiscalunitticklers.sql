/*
    -- CIDM-9361 Query Optimisation for sp_ticklers dashboard.
    -- Query tuning for `sp_fiscalunitticklers` function.
*/

drop index if exists idx_tb_ticklers_system_tickler_id_active;
CREATE INDEX idx_tb_ticklers_system_tickler_id_active ON cjams.tb_ticklers USING btree (system_tickler_id,delete_sw);