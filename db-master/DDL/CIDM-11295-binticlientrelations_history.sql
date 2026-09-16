DROP TABLE IF EXISTS cjams.binticlientrelations_history;

CREATE TABLE IF NOT EXISTS cjams.binticlientrelations_history (
    binticlientrelationshistoryid uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
    LIKE cjams.binticlientrelations INCLUDING DEFAULTS INCLUDING COMMENTS
);
COMMENT ON TABLE cjams.binticlientrelations_history IS 'History table for binticlientrelations.';