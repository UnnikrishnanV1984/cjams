ALTER TABLE defecttracking.releasenotes ADD COLUMN IF NOT EXISTS raisedby character varying;
COMMENT ON COLUMN defecttracking.releasenotes.raisedby IS 'User who created the story'; 
