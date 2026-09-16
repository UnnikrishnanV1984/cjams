ALTER TABLE defecttracking.supportlog ADD COLUMN IF NOT EXISTS program character varying(100);
ALTER TABLE defecttracking.supportlog ADD COLUMN IF NOT EXISTS focus character varying(100);
COMMENT ON COLUMN defecttracking.supportlog.program
    IS 'Program group such as In-home, out-of-home, etc';
COMMENT ON COLUMN defecttracking.supportlog.focus
    IS 'Focus area such as Access, Assignment, Placement, etc';	