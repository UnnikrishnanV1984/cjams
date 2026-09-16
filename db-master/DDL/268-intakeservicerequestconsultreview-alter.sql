ALTER TABLE intakeservicerequestconsultreview DROP CONSTRAINT IF EXISTS intakeservicerequestconsultreview_intakeserviceid_fkey;
			
ALTER TABLE intakeservicerequestconsultreview ADD COLUMN IF NOT EXISTS objectid character varying;
COMMENT ON COLUMN intakeservicerequestconsultreview.objectid IS 'object id';

ALTER TABLE intakeservicerequestconsultreview ADD COLUMN IF NOT EXISTS objecttypekey character varying;
COMMENT ON COLUMN intakeservicerequestconsultreview.objecttypekey IS 'object type key';