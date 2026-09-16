-- CIDM-11381: Add two new columns, to hold reasons for delay and it flag.

ALTER TABLE cjams.progressnote 
ADD COLUMN IF NOT EXISTS delayreasons VARCHAR(1000),
ADD COLUMN IF NOT EXISTS hasdelay BOOLEAN;

COMMENT ON COLUMN cjams.progressnote.delayreasons
    IS 'text field to store delay reasons';

COMMENT ON COLUMN cjams.progressnote.hasdelay
    IS 'flag indicating whether there is a delay';

ALTER TABLE cjams.holidays
ALTER COLUMN date TYPE DATE
USING date::DATE;