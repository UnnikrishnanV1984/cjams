-- Table: cjams.binticlients_history
DROP TABLE IF EXISTS cjams.binticlients_history;
CREATE TABLE IF NOT EXISTS cjams.binticlients_history (
    binti_clientshistory_id uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
    LIKE cjams.binticlients INCLUDING DEFAULTS INCLUDING COMMENTS
);
COMMENT ON TABLE cjams.binticlients_history IS 'History table for binticlients.';