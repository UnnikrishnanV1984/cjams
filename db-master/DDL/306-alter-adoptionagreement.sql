ALTER TABLE adoptionagreement
ADD COLUMN IF NOT EXISTS childplacedby character varying(15);
ALTER TABLE adoptionagreement
ADD COLUMN IF NOT EXISTS childplacedfrom character varying(15);