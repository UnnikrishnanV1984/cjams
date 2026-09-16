ALTER TABLE IF EXISTS cjams.personprogramarea ADD COLUMN IF NOT EXISTS isdefault BOOLEAN DEFAULT false;

COMMENT ON COLUMN cjams.personprogramarea.isdefault IS 'To Idenitify particular program area is auto generated or not';