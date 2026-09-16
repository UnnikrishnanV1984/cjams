ALTER TABLE cjams.placement ADD COLUMN justification text;

COMMENT ON COLUMN cjams.placement.justification
    IS 'User justification for out of sequence placement';