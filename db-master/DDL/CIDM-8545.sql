alter table meetingrecording ADD column if not exists placementid uuid NULL;

COMMENT ON COLUMN cjams.meetingrecording.placementid IS 'Save placement id to get the selected placement details';