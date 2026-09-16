ALTER TABLE IF EXISTS cjams.adoptionemotionalties
ALTER COLUMN importancetochildtx TYPE text;

COMMENT ON COLUMN cjams.adoptionemotionalties.importancetochildtx
IS 'To store important other information related to the child';
