ALTER TABLE Personprogramarea DROP COLUMN IF EXISTS reasonforclosure;

DROP INDEX IF EXISTS progressnote_servicecaseid_idx;

CREATE INDEX progressnote_servicecaseid_idx ON cjams.progressnote USING btree (servicecaseid);