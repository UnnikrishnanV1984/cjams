---------------------------------------------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 04/13/2025 Vinesh Puthan - CIDM-11321 - Create statements related to progressnotereasontypebysubtype in contact notes
--------------------------------------------------------------------------------------------------------------------------------------------

ALTER TABLE progressnote ADD COLUMN IF NOT EXISTS mioptions text;

COMMENT ON COLUMN cjams.progressnote.mioptions IS 'Column to save the motivational interview options key value';