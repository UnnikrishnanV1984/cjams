DROP TABLE IF EXISTS cjams.bintifamilyfindings_history;

CREATE TABLE IF NOT EXISTS cjams.bintifamilyfindings_history (
    bintifamilyfindingshistoryid uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
    LIKE cjams.bintifamilyfindings INCLUDING DEFAULTS INCLUDING COMMENTS
);
COMMENT ON TABLE cjams.bintifamilyfindings_history IS 'History table for binti_familyfindings.';