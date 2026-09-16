ALTER TABLE cjams.progressnote 
add column if not exists focusperson json;

COMMENT ON COLUMN cjams.progressnote.focusperson
    IS 'focus person json column';